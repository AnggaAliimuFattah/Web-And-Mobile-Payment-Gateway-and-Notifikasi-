<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\JenisPembayaran;
use Illuminate\Http\Request;

class JenisPembayaranController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pembayaran_terdaftar = DB::table('jenis_pembayaran')
        ->pluck('jenis')
        ->toArray();
         $semua_jenis = ['PENDAFTARAN', 'SPP', 'UTS', 'UAS'];
        return view('jenis-pembayaran.index',[
            'pembayaran_terdaftar' => $pembayaran_terdaftar,
            'semua_jenis' => $semua_jenis
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
       $validatedData =   $request->validate([
                'jenis' => 'required',
                'nominal' => 'required',
            ], [
                'jenis.required' => 'Jenis wajib diisi.',
                'nominal.required' => 'Nominal wajib diisi.',
            ]);

         DB::beginTransaction(); 

    try {
        
        $nominal = preg_replace('/\D/', '', $request->nominal);
        $pendaftaran = JenisPembayaran::create([
            'jenis' => $request->jenis,
            'nominal' => $nominal,
            'keterangan' => $request->keterangan
        ]);

        DB::commit(); 
        return response()->json($pendaftaran);

    } catch (\Throwable $th) {
        DB::rollBack(); 
        return response()->json([
            'error' => true,
            'message' => $th->getMessage(),
        ], 500);
    }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    public function ajax_data(Request $request, $uuid) {
        $dt = DB::table('jenis_pembayaran')->where('uuid', $uuid)->first();
        return response()->json($dt);
    }
    /**
     * Display the specified resource.
     */
    public function show(JenisPembayaran $jenisPembayaran)
    {
        $total = JenisPembayaran::get()->count();
        
        $length = intval($_REQUEST['length']);
        $length = $length < 0 ? $total : $length;
        $start  = intval($_REQUEST['start']);
        $draw   = intval($_REQUEST['draw']);
        $search = $_REQUEST['search']["value"];

        $output         = array();
        $output['data'] = array();

        $end = $start + $length;
        $end = $end > $total ? $total : $end;

        if($search != ''){
            $query = JenisPembayaran::where(function($filter) use ($search) {
                $filter->orWhere('jenis', 'like', '%' . $search . '%');
                $filter->orWhere('nominal', 'like', '%' . $search . '%');
                $filter->orWhere('keterangan', 'like', '%' . $search . '%');
               })->take($length)->skip($start)->latest()->get();
            $no = $start + 1;
            foreach ($query as $val) {
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->jenis</td>",
          "<td>$val->keterangan</td>",
          "<td>Rp ".number_format($val->nominal, 0, ',', '.')."</td>",
          '<td>
              <div class="btn-group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown"> Aksi </button>
               <ul class="dropdown-menu" role="menu">
                  <li>
                    <a class="dropdown-item" onclick="detail(\''.$val->uuid.'\')" href="#"><i class="fas fa-eye text-info"></i> Detail</a>
                    <a class="dropdown-item" onclick="edit(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-warning"></i> Edit</a>
                   
                  </li>
                </ul>
              </div>
        </td>'




      );
                $no++;
            }
            $rows = JenisPembayaran::where(function($filter) use ($search) {
                 $filter->orWhere('jenis', 'like', '%' . $search . '%');
                $filter->orWhere('nominal', 'like', '%' . $search . '%');
                $filter->orWhere('keterangan', 'like', '%' . $search . '%');
            })
            ->latest()
            ->get();
        
            $output['draw']                 = $draw;
            $output['recordsTotal']         = $output['recordsFiltered']      = $rows->count();
        }
        else{

                $query =JenisPembayaran::take($length)
                ->skip($start)
                ->latest()
                ->get();
           
            $no = $start + 1;
            foreach ($query as $val) {
              
         $output['data'][] =       
         array(
                        
          
           
         "<td>$no</td>",
          "<td>$val->jenis</td>",
          "<td>$val->keterangan</td>",
          "<td>Rp ".number_format($val->nominal, 0, ',', '.')."</td>",
          '<td>
              <div class="btn-group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown"> Aksi </button>
               <ul class="dropdown-menu" role="menu">
                  <li>
                    <a class="dropdown-item" onclick="detail(\''.$val->uuid.'\')" href="#"><i class="fas fa-eye text-info"></i> Detail</a>
                    <a class="dropdown-item" onclick="edit(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-warning"></i> Edit</a>
                  
                  </li>
                </ul>
              </div>
        </td>'

        );
                $no++;
            }
            $output['draw']             = $draw;
            $output['recordsTotal']     = $total;
            $output['recordsFiltered']  = $total;
        }
                                                    
        return response()->json($output);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(JenisPembayaran $jenisPembayaran)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, JenisPembayaran $jenisPembayaran)
    {
        $validatedData =   $request->validate([
                'nominal' => 'required',
            ], [
                'nominal.required' => 'Nominal wajib diisi.',

            ]);
 try {
        
        $nominal = preg_replace('/\D/', '', $request->nominal);
       $jb = JenisPembayaran::where('uuid', $request->uuid)->update([
    'nominal' => $nominal,
]);


        DB::commit(); 
        return response()->json($jb);

    } catch (\Throwable $th) {
        DB::rollBack(); 
        return response()->json([
            'error' => true,
            'message' => $th->getMessage(),
        ], 500);
    }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(JenisPembayaran $jenisPembayaran)
    {
        //
    }
}