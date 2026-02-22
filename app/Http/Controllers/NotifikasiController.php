<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class NotifikasiController extends Controller
{
    public function index()
    {
        return view('notifikasi.index');
    }

// public function send(Request $request)
// {
//     $jns = $request->jenis ?? '';
//     $kelas = $request->kelas;

//     $tableMap = [
//         'PENDAFTARAN' => 'pembayaran_pendaftaran',
//         'SPP'         => 'pembayaran_spp',
//         'UTS'         => 'pembayaran_uts',
//         'UAS'         => 'pembayaran_uas',
//     ];

//     if (!isset($tableMap[$jns])) {
//         return response()->json(['error' => 'Jenis tidak valid'], 400);
//     }

//     $table = $tableMap[$jns];
//     $siswaList = DB::table('data_siswa')->where('kelas', $kelas)->get();

//     foreach ($siswaList as $siswa) {

//         $count = DB::table($table)
//     ->where('siswa_uuid', $siswa->uuid)
//     ->where('status', 'Transaksi Selesai')
//     ->when($jns !== 'PENDAFTARAN', function ($query) use ($request) {
//         return $query->where('kelas', $request->kelas);
//     })
//     ->sum('nominal');

//         $count2 = DB::table('jenis_pembayaran')->where('jenis', $table)->first();
      
//         $allcount = $count2->nominal ?? 0 - $count ;
        
//         // dd($allcount);
//         if ($allcount <= 0) {
//         $no_telp = $siswa->no_telp ?? null;



//             $curl = curl_init();
//             curl_setopt_array($curl, [
//                 CURLOPT_URL => 'https://api.fonnte.com/send',
//                 CURLOPT_RETURNTRANSFER => true,
//                 CURLOPT_POST => true,
//                 CURLOPT_POSTFIELDS => [
//                     'target' => $no_telp,
//                     'message' =>$request->pesan,
//                     'countryCode' => '62',
//                 ],
//                 CURLOPT_HTTPHEADER => [
//                     'Authorization: d4ANGZ6iJxgaMbZcoJkD'
//                 ],
//             ]);
//             $response = curl_exec($curl);
//             curl_close($curl);

//             $res = json_decode($response);
//             DB::table('notif_wa')->insert([
//                 'pesan' => $request->pesan,
//                 'no_telp' => $no_telp,
//                 'status' => $res->detail ?? 'Gagal',
//                 'uuid_siswa' => $siswa->uuid,
//                 'created_at' => Carbon::now(),
//                 'updated_at' => Carbon::now()
//             ]);
            
// }
      
//     }

//     return response()->json(['status' => 'Pesan dikirim ke semua siswa']);
// }


    public function send (Request $request){

      // dd()
        $notlp = DB::table('data_siswa')->where('uuid', $request->no_telp)->first();
        $pesan = $request->pesan;
        $no_telp = $notlp->no_telp;

        try{
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
                       'Authorization: d4ANGZ6iJxgaMbZcoJkD'
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
    'uuid_siswa' => $request->no_telp,
    'created_at' => Carbon::now(),
    'updated_at' => Carbon::now()

]);
return response()->json($res);

        }catch(\Exception $e){
            return response()->json($e->getMessage());
        }
    
}



public function show(Request $request)
    {
         $total = DB::table('notif_wa')->get()
         ->count();
        
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
            $query = DB::table('notif_wa')->where(function($filter) use ($search) {
                $filter->orWhere('no_telp', 'like', '%' . $search . '%');
                $filter->orWhere('status', 'like', '%' . $search . '%');
               })
               
               ->take($length)
               ->skip($start)
               ->latest()
               ->get();

            $no = $start + 1;
            foreach ($query as $val) {

              $dta = DB::table('data_siswa')->where('uuid', $val->uuid_siswa)->first();
              $hasil = DB::table('notif_wa')->where('status', 'like', '%success%')->first();

              
              if ($hasil != null) {
                $badge = "badge badge-success";
                $style = "background-color: green";
              } else {
                $badge = "badge badge-danger";
                $style = "background-color: red";
              }
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->no_telp</td>",
          "<td>$dta?->nama</td>",
          "<td>$val->pesan</td>",
          "<td><span class=\"$badge\" style=\"$style\"> $val->status</span</td>",

        );
                $no++;
            }
            $rows = DB::table('notif_wa')->where(function($filter) use ($search) {
               $filter->orWhere('no_telp', 'like', '%' . $search . '%');
                $filter->orWhere('status', 'like', '%' . $search . '%');
            })
            
            ->latest()
            ->get();
        
            $output['draw']                 = $draw;
            $output['recordsTotal']         = $output['recordsFiltered']      = $rows->count();
        }
        else{

                $query =DB::table('notif_wa')->take($length)
                
                ->skip($start)
                ->latest()
                ->get();
           
            $no = $start + 1;
           
            foreach ($query as $val) {

           $dta = DB::table('data_siswa')->where('uuid', $val->uuid_siswa)->first();
              $hasil = DB::table('notif_wa')->where('status', 'like', '%success%')->first();

              if ($hasil != null) {
                $badge = "badge badge-success";
                $style = "background-color: green";
              } else {
                $badge = "badge badge-danger";
                $style = "background-color: red";
              }
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->no_telp</td>",
          "<td>$dta?->nama</td>",
          "<td>$val->pesan</td>",
          "<td><span class=\"$badge\" style=\"$style\"> $val->status</span</td>",

        );
                $no++;
            }
            $output['draw']             = $draw;
            $output['recordsTotal']     = $total;
            $output['recordsFiltered']  = $total;
        }
                                                    
        return response()->json($output);
    }

}