<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\DataSiswa;
use Midtrans\Snap;

class PembayaranUasController extends Controller
{
    public function riwayat_tagihan_uas(Request $request)
    {
        $uas = DB::table('pembayaran_uas')->where('siswa_uuid', $request->uuid)->where('kelas', $request->kelas)->where('kondisi', '!=', 'Generate Token')->get();  
        return response()->json($uas);
    }

     public function detail_tagihan_uas(Request $request)
    {
        $uas = DB::table('pembayaran_uas')->where('uuid', $request->uuid)->first();  
        return response()->json($uas);
    }

     public function cek_tagihan_uas(Request $request)
    {
        $jenis = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first(); 
        $siswa = DataSiswa::where('uuid', $request->uuid)->first();
       
        $jenis_nominal = intval($jenis->nominal);

       $kelas = [];

       if (
    ($siswa->status2 == 'Pendaftar Kelas XI' && $request->kelas == 'X') ||
    ($siswa->status2 == 'Pendaftar Kelas XII' && in_array($request->kelas, ['X', 'XI']))
    ) {
    return response()->json(['status' => 'Lunas', 'sisa' => 0]);
    }

if ($siswa->status2 == 'Pendaftar Baru') {
    $kelas = [$request->kelas];
} elseif ($siswa->status2 == 'Pendaftar Kelas XI') {
    $kelas = ['XI', 'XII'];
} elseif ($siswa->status2 == 'Pendaftar Kelas XII') {
    $kelas = ['XII'];
}

$baseQuery = DB::table('pembayaran_uas')
    ->where('siswa_uuid', $request->uuid)
    ->whereIn('kelas', $kelas);

$uas = (clone $baseQuery)
    ->where('status', 'Lunas')
    ->latest()
    ->first();

$uas2 = (clone $baseQuery)
    ->where('status', 'Belum Lunas')
    ->latest()
    ->first();

 $sisa = intval($uas2->sisa ?? 0);


               if($uas == null && $uas2 == null){
               return response()->json(['status' => 'Belum Bayar', 'sisa' => $jenis_nominal ]);
               }else if ($uas != null && $uas2 == null){ 
                return response()->json(['status' => 'Lunas', 'sisa' => 0]);
               }else if($uas == null && $uas2 != null){
                return response()->json(['status' => 'Belum Lunas', 'sisa' => $sisa]);
               }else if ($uas != null && $uas2 != null){
                return response()->json(['status' => 'Lunas', 'sisa' => 0]);
               }
    }


    public function createSnapToken(Request $request,$uuid,$amount,$kelas)
    {
        $dataperson = DataSiswa::where('uuid', $uuid)->first();

        // dd($jenis_pembayaran);
        // 1. Detail Transaksi
        $order_id = "PAY-" . rand(100000, 999999);
        $transaction_details = [
            'order_id' => $order_id,
            'gross_amount' => $amount,
        ];

        // 2. Detail Produk
        $item_details = [
            [
                'id' => 'a1',
                'price' => $amount,
                'quantity' => 1,
                'name' => 'Pembayaran UAS',
            ]
        ];

        // 3. Alamat Customer
        $billing_address = [
            'first_name' => $dataperson->nama,
            'address' => $dataperson->alamat,
            'city' => $dataperson->tempat_lahir,
            'phone' => $dataperson->no_telp,
        ];

        $shipping_address = $billing_address;

        // 4. Data Customer
        $customer_details = [
       'first_name' => $dataperson->nama,
            'address' => $dataperson->alamat,
            'city' => $dataperson->tempat_lahir,
            'phone' => $dataperson->no_telp,
            'billing_address' => $billing_address,
            'shipping_address' => $shipping_address
        ];

        // 5. Gabungkan Transaksi
        $transaction = [
            'transaction_details' => $transaction_details,
            'customer_details' => $customer_details,
            'item_details' => $item_details,
            "callbacks" => array('finish' => 'javascript:void(0)'),
              'enabled_payments' => [

        'bank_transfer',
        'echannel',
        // jangan masukkan 'gopay' atau 'qris' di sini supaya ga muncul
    ],
        ];

        // 6. Ambil Snap Token
        $snapToken = Snap::getSnapToken($transaction);
        
           $n= DB::table('pembayaran_uas')->where('siswa_uuid', $uuid)->where('kelas', $kelas)->where('kondisi', '!=', 'Generate Token')->sum('nominal');
          $jenis = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first();
          $n_all = $jenis->nominal - $n;
          
          if($amount > $n_all){
              
          }else{

      DB::table('pembayaran_uas')->insert([
                'uuid' => $order_id,
                'siswa_uuid' => $uuid,
                'kelas' => $kelas,
                'nominal' => $amount,
                'status' => '-',
                'kondisi' => 'Generate Token',
        ]);
        
          }

        // 7. Kirim ke frontend
        return response()->json([
            'snap_token' => $snapToken,
                          'sisa' => $n_all,
             'amount' => intval($amount) ,
        ]);
    }

  
}