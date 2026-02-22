<?php

namespace Tests\Feature;

use App\Models\Expense;
use App\Models\Status;
use App\Models\Approver;
use App\Models\ApprovalStage;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ExpenseTest extends TestCase
{
    use RefreshDatabase;




     public function test_create_data()
    {
        // Buat expense dan approvers
    
       // Kirim request untuk membuat tiga approver
        $response1 = $this->postJson('/api/approvers', ['name' => 'Ana']);
        $response2 = $this->postJson('/api/approvers', ['name' => 'Ani']);
        $response3 = $this->postJson('/api/approvers', ['name' => 'Ina']);


        // Assert masing-masing berhasil (status 201 Created)
        $response1->assertStatus(201);
        $response1->assertJsonFragment(['name' => 'Ana']);

        $response2->assertStatus(201);
        $response2->assertJsonFragment(['name' => 'Ani']);

        $response3->assertStatus(201);
        $response3->assertJsonFragment(['name' => 'Ina']);
    }



  public function test_create_expense_amount()
{
      $status1 = Status::create(['name' => 'menunggu persetujuan']);
      $status2 = Status::create(['name' => 'disetujui']);
    

    $amounts = [10000, 20000, 30000, 40000];

    foreach ($amounts as $amount) {
        $response = $this->postJson('/api/expenses', [
            'amount' => $amount,
            'status_id' => $status1->id,  // Menggunakan ID yang benar dari database
        ]);

        $response->assertStatus(201);
        $response->assertJsonFragment([
            'amount' => $amount
        ]);
    }
}


    // Test untuk endpoint PATCH /expense/{expenseId}/approve/{approverId}
    public function test_approve_expense()
{
         // Buat status untuk expense
    $status = Status::create(['name' => 'menunggu persetujuan']);
    Status::create(['name' => 'disetujui']);
// dd($status);

    // Buat beberapa approver
    Approver::create(['name' => 'Ani']);
    Approver::create(['name' => 'Ana']);
    Approver::create(['name' => 'Ina']);

    // Buat beberapa expense
    $expense1 = Expense::create(['amount' => 10000, 'status_id' => 3]);  // Status 'menunggu persetujuan'
    $expense2 = Expense::create(['amount' => 20000, 'status_id' => 3]);  // Status 'menunggu persetujuan'
    $expense3 = Expense::create(['amount' => 30000, 'status_id' => 3]);  // Status 'menunggu persetujuan'
    $expense4 = Expense::create(['amount' => 40000, 'status_id' => 3]);



    $testCases = [
        ['expense_id' => $expense1->id, 'approver_id' => 4],
        ['expense_id' => $expense1->id, 'approver_id' => 5],
        ['expense_id' => $expense1->id, 'approver_id' => 6],
        ['expense_id' => $expense2->id, 'approver_id' => 4],
        ['expense_id' => $expense2->id, 'approver_id' => 5],
        ['expense_id' => $expense3->id, 'approver_id' => 4],
    ];

    foreach ($testCases as $case) {
        $response = $this->patchJson(
            "/api/expense/{$case['expense_id']}/approve",
            ['approver_id' => $case['approver_id']]
        );

        // Assert valid response
        $response->assertStatus(400);  // Pastikan response yang diterima adalah 400
        $response->assertJson([
            'error' => 'Approver tidak ditemukan atau tidak berada pada tahap yang benar',
        ]);
    }
}


    // Test jika approver mencoba approve sebelum approver sebelumnya
    public function test_approval_stage()
    {
        // Buat expense dan approvers
        $approver1 = Approver::create(['name' => 'Ana']);
        $approver2 = Approver::create(['name' => 'Ani']);
        $approver3 = Approver::create(['name' => 'Ina']);
        
        $response = $this->postJson('/api/approval-stages', ['approver_id' => $approver1->id]);
        $response->assertStatus(201);
        $response->assertJsonFragment([
            'approver_id' => $approver1->id
        ]);

             $response2 = $this->postJson('/api/approval-stages', ['approver_id' => $approver2->id]);
        $response2->assertStatus(201);
        $response2->assertJsonFragment([
            'approver_id' => $approver2->id
        ]);

        $response3 = $this->postJson('/api/approval-stages', ['approver_id' => $approver3->id]);
        $response3->assertStatus(201);
         $response3->assertJsonFragment([
            'approver_id' => $approver3->id
        ]);
    }



    // Test untuk mendapatkan pengeluaran yang telah disetujui
    public function test_get_expense_details()
    {
        // Buat expense
        $expense = Expense::create(['amount' => 5000, 'status_id' => Status::firstOrCreate(['name' => 'disetujui'])->id]);

        // Test GET /expense/{id}
        $response = $this->getJson('/api/expense/'.$expense->id);
        $response->assertStatus(200);
        $response->assertJson([
            'id' => $expense->id,
            'amount' => 5000,
            'status' => [
                'name' => 'disetujui'
            ]
        ]);
    }
}
