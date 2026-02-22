<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class NotifikasiController extends Controller
{

    public function handleNotification(Request $request)

{
    $data = $request->all();

    Log::info('tester-payment', [$data]);

    $orderId     = $data['order_id'];
    $statusCode  = $data['status_code'];
    $grossAmount = $data['gross_amount'];
    $signature   = $data['signature_key'];
    $serverKey   = 'SB-Mid-server-4yFLRsnGm4l0euDsVa32rTsb';

    $expected = hash('sha512', $orderId . $statusCode . $grossAmount . $serverKey);

    $dt = DB::table('pembayaran_pendaftaran')->where('uuid', $orderId)->where('kondisi', 'Generate Token')->latest()->first();
    $dt2 = DB::table('pembayaran_spp')->where('uuid', $orderId)->where('kondisi', 'Generate Token')->latest()->first();
    $dt3 = DB::table('pembayaran_uts')->where('uuid', $orderId)->where('kondisi', 'Generate Token')->latest()->first();
    $dt4 = DB::table('pembayaran_uas')->where('uuid', $orderId)->where('kondisi', 'Generate Token')->latest()->first();
    
    

    if($dt != null){
       $jns = 'PENDAFTARAN';
    }else if($dt2 != null){
       $jns = 'SPP';
    }else if($dt3 != null){
       $jns = 'UTS';
    }else if($dt4 != null){
       $jns = 'UAS';
    }

    $jns_pbyr = DB::table('jenis_pembayaran')->where('jenis', $jns)->first();

$dtx = null;
$dtx2 = null;
$dtx3 = null;
$dtx4 = null;

if ($dt != null) {
    $dtx = DB::table('pembayaran_pendaftaran')
        ->where('siswa_uuid', $dt->siswa_uuid)
        ->where('status', 'Belum Lunas')
        ->where('kondisi', 'Transaksi Selesai')
        ->latest()->first(); 
}

if ($dt2 != null) {
    $dtx2 = DB::table('pembayaran_spp')
        ->where('siswa_uuid', $dt2->siswa_uuid)
        ->where('status', 'Belum Lunas')
        ->where('bulan', $dt2->bulan)
        ->where('kelas', $dt2->kelas)
        ->where('kondisi', 'Transaksi Selesai')
        ->latest()->first(); 
}

if ($dt3 != null) {
    $dtx3 = DB::table('pembayaran_uts')
        ->where('siswa_uuid', $dt3->siswa_uuid)
        ->where('status', 'Belum Lunas')
        ->where('kelas', $dt3->kelas)
        ->where('kondisi', 'Transaksi Selesai')
        ->latest()->first(); 
}

if ($dt4 != null) {
    $dtx4 = DB::table('pembayaran_uas')
        ->where('siswa_uuid', $dt4->siswa_uuid)
        ->where('status', 'Belum Lunas')
        ->where('kelas', $dt3->kelas)
        ->where('kondisi', 'Transaksi Selesai')
        ->latest()->first(); 
}

if($jns == 'PENDAFTARAN'){
     if ($data['status_code'] == '200') {

        if($dtx != null){
             $amount =intval($dtx->sisa) - intval($data['gross_amount']);
        }else{
             $amount = intval($jns_pbyr->nominal) - intval($data['gross_amount']);
        }
       

        if ($amount == 0) {
            $sts = 'Lunas';
        }else{
            $sts = 'Belum Lunas';
        }

       
    }

      DB::table('pembayaran_pendaftaran')->where('uuid', $orderId)->update([
            'status' => $sts,
            'kondisi' => 'Transaksi Selesai',
            'sisa' => $amount,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now()
     ]);
     $nisn =  now()->format('ymd') . random_int(1000, 9999);

     DB::table('data_siswa')->where('uuid', $dt->siswa_uuid)->update([
            'nis' => $nisn,
            'username' => $nisn,
            'status' => 'Siswa',
        ]);

         $d = DB::table('pembayaran_pendaftaran')->where('uuid', $orderId)->first();
        $sw = DB::table('data_siswa')->where('uuid', $d->siswa_uuid)->first();
         $this->sendwa('
         
📚 YPI SCHOOL
🧾 Konfirmasi Pembayaran pendaftaran

Assalamu’alaikum/Salam sejahtera,
Kepada Yth. Orang tua / Wali murid dari '.$sw->nama.' – '.$sw->kelas.',

Terima kasih, kami telah menerima pembayaran Pendaftaran sekolah sebesar Rp '. $data['gross_amount'].'

📌 Rincian Pembayaran:
• Nama Siswa: '.$sw->nama.'
• Kelas: '.$sw->kelas.'
• Jumlah: Rp '. $data['gross_amount'].'
• Tanggal Pembayaran: '. Carbon::now()->translatedFormat('d F Y') .'



Bukti pembayaran telah dicatat oleh pihak administrasi sekolah.

Terima kasih atas kerja sama dan partisipasinya. 🙏
         ', $sw->no_telp);

}else if($jns == 'SPP'){
     if ($data['status_code'] == '200') {
         
          if($dtx2 != null){
             $amount =intval($dtx2->sisa) - intval($data['gross_amount']);
        }else{
             $amount = intval($jns_pbyr->nominal) - intval($data['gross_amount']);
        }

        if ($amount == 0) {
            $sts = 'Lunas';
        }else{
            $sts = 'Belum Lunas';
        }

       
    }

      DB::table('pembayaran_spp')->where('uuid', $orderId)->update([
            'status' => $sts,
            'kondisi' => 'Transaksi Selesai',
            'sisa' => $amount,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now()
            
     ]);
     
      $d = DB::table('pembayaran_spp')->where('uuid', $orderId)->first();
     $sw = DB::table('data_siswa')->where('uuid', $d->siswa_uuid)->first();
         $this->sendwa('
         
📚 YPI SCHOOL
🧾 Konfirmasi Pembayaran SPP bulan '.$d->bulan.'

Assalamu’alaikum/Salam sejahtera,
Kepada Yth. Orang tua / Wali murid dari '.$sw->nama.' – '.$sw->kelas.',

Terima kasih, kami telah menerima pembayaran SPP sekolah sebesar Rp '. number_format($data['gross_amount'], 0, ',', '.').'

📌 Rincian Pembayaran:
• Nama Siswa: '.$sw->nama.'
• Kelas: '.$sw->kelas.'
• Jumlah: Rp '. $data['gross_amount'].'
• Tanggal Pembayaran: '. Carbon::now()->translatedFormat('d F Y') .'

Bukti pembayaran telah dicatat oleh pihak administrasi sekolah.

Terima kasih atas kerja sama dan partisipasinya. 🙏
         ', $sw->no_telp);

}else if($jns == 'UTS'){
     if ($data['status_code'] == '200') {
         
          if($dtx3 != null){
             $amount =intval($dtx3->sisa) - intval($data['gross_amount']);
        }else{
             $amount = intval($jns_pbyr->nominal) - intval($data['gross_amount']);
        }

        if ($amount == 0) {
            $sts = 'Lunas';
        }else{
            $sts = 'Belum Lunas';
        }
       
    }

      DB::table('pembayaran_uts')->where('uuid', $orderId)->update([
            'status' => $sts,
            'kondisi' => 'Transaksi Selesai',
            'sisa' => $amount,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now()
            
     ]);
      $d = DB::table('pembayaran_uts')->where('uuid', $orderId)->first();
      $sw = DB::table('data_siswa')->where('uuid', $d->siswa_uuid)->first();
         $this->sendwa('
         
📚 YPI SCHOOL
🧾 Konfirmasi Pembayaran UTS kelas '.$sw->kelas.'

Assalamu’alaikum/Salam sejahtera,
Kepada Yth. Orang tua / Wali murid dari '.$sw->nama.' – '.$sw->kelas.',

Terima kasih, kami telah menerima pembayaran iuran sekolah sebesar Rp '. $data['gross_amount'].'

📌 Rincian Pembayaran:
• Nama Siswa: '.$sw->nama.'
• Kelas: '.$sw->kelas.'
• Jumlah: Rp '. $data['gross_amount'].'
• Tanggal Pembayaran: '. Carbon::now()->translatedFormat('d F Y') .'

Bukti pembayaran telah dicatat oleh pihak administrasi sekolah.

Terima kasih atas kerja sama dan partisipasinya. 🙏
         ', $sw->no_telp);

}else if($jns == 'UAS'){
     if ($data['status_code'] == '200') {
         
          if($dtx4 != null){
             $amount =intval($dtx4->sisa) - intval($data['gross_amount']);
        }else{
             $amount = intval($jns_pbyr->nominal) - intval($data['gross_amount']);
        }

        if ($amount == 0) {
            $sts = 'Lunas';
        }else{
            $sts = 'Belum Lunas';
        }
    }


      DB::table('pembayaran_uas')->where('uuid', $orderId)->update([
            'status' => $sts,
            'kondisi' => 'Transaksi Selesai',
            'sisa' => $amount,
            'created_at' => Carbon::now(),
            'updated_at' => Carbon::now()
            
     ]);

      $d = DB::table('pembayaran_uas')->where('uuid', $orderId)->first();
         $sw = DB::table('data_siswa')->where('uuid', $d->siswa_uuid)->first();
         $this->sendwa('
         
📚 YPI SCHOOL
🧾 Konfirmasi Pembayaran UAS kelas'.$sw->kelas.'

Assalamu’alaikum/Salam sejahtera,
Kepada Yth. Orang tua / Wali murid dari '.$sw->nama.' – '.$sw->kelas.',

Terima kasih, kami telah menerima pembayaran iuran sekolah sebesar Rp '. $data['gross_amount'].'

📌 Rincian Pembayaran:
• Nama Siswa: '.$sw->nama.'
• Kelas: '.$sw->kelas.'
• Jumlah: Rp '. $data['gross_amount'].'
• Tanggal Pembayaran: '. Carbon::now()->translatedFormat('d F Y') .'

Bukti pembayaran telah dicatat oleh pihak administrasi sekolah.

Terima kasih atas kerja sama dan partisipasinya. 🙏
         ', $sw->no_telp);

}

    if ($signature === $expected) {
        return response()->json([
            'message' => 'Signature valid',
            'status' => $data['transaction_status']
        ]);
    } else {
        return response()->json([
            'message' => 'Invalid signature',
            'your_signature' => $signature,
            'expected_signature' => $expected
        ], 403);
    }

}





public function sendwa ($pesan, $no_telp){
    $curl = curl_init();
    
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.fonnte.com/send',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => array(
'target' => $no_telp,
'message' => $pesan, 
'countryCode' => '62', //optional
),
  CURLOPT_HTTPHEADER => array(
    'Authorization: d4ANGZ6iJxgaMbZcoJkD' //change TOKEN to your actual token
  ),
));

$response = curl_exec($curl);

curl_close($curl);
$res = json_decode($response);
$dts = DB::table('data_siswa')->where('no_telp', $no_telp)->first();
DB::table('notif_wa')->insert([
    'pesan' => $pesan,
    'no_telp' => $no_telp,
    'status' => $res->detail,
    'uuid_siswa' => $dts->uuid,
    'created_at' => Carbon::now(),
    'updated_at' => Carbon::now()

]);
return response()->json($res);

}
}