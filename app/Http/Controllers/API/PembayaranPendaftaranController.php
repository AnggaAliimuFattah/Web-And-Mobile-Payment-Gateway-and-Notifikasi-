<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\DataSiswa;
use Midtrans\Snap;


class PembayaranPendaftaranController extends Controller
{
    public function riwayat_tagihan_pendaftaran($uuid)
    {  
                             $data= DB::table('pembayaran_pendaftaran')->where('siswa_uuid', $uuid)->where('kondisi', '!=', 'Generate Token')->get();
                     return response()->json($data);             
       
    }


     public function detail_tagihan_pendaftaran(Request $request)
    {  
               $data= DB::table('pembayaran_pendaftaran')->where('uuid', $request->uuid)->first();
                     return response()->json($data);             
       
    }

     public function cek_tagihan_pendaftaran($uuid)
    {  

               $data= DB::table('pembayaran_pendaftaran')->where('siswa_uuid', $uuid)->where('status', 'Lunas')->latest()->first();
               $data2= DB::table('pembayaran_pendaftaran')->where('siswa_uuid', $uuid)->where('status', 'Belum Lunas')->latest()->first();
               $jenis = DB::table('jenis_pembayaran')->where('jenis', 'PENDAFTARAN')->first();
               $sisa = intval($data2->sisa ?? 0);
               $jenis_nominal = intval($jenis->nominal);
               if($data == null && $data2 == null){
               return response()->json(['status' => 'Belum Lunas', 'sisa' => $jenis_nominal]);
               }else if ($data != null && $data2 == null){ 
                return response()->json(['status' => 'Lunas', 'sisa' => 0]);
               }else if($data == null && $data2 != null){
                return response()->json(['status' => 'Belum Lunas', 'sisa' => $sisa]);
               }else if ($data != null && $data2 != null){
                return response()->json(['status' => 'Lunas', 'sisa' => 0]);
               }
    }


     public function createSnapToken(Request $request,$uuid,$amount)
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
                'name' => 'Pembayaran SPP',
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

        $n= DB::table('pembayaran_pendaftaran')->where('siswa_uuid', $uuid)->where('kondisi', '!=', 'Generate Token')->sum('nominal');
          $jenis = DB::table('jenis_pembayaran')->where('jenis', 'PENDAFTARAN')->first();
          $n_all = $jenis->nominal - $n;
          
          if($amount > $n_all){
              
          }else{
    
              DB::table('pembayaran_pendaftaran')->insert([
            'uuid' => $order_id,
            'siswa_uuid' => $uuid,
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