<?php

namespace App\Http\Controllers;

use App\Models\DataSiswa;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class PembayaranUasController extends Controller
{
    public function index()
    {
 
    $tahunSekarang = Carbon::now()->year;
        return view('data-pembayaran.uas',[
            'tahunSekarang' => $tahunSekarang
        ]);
    }


     public function detail($uuid, $kelas)
    {
        $data = DB::table('pembayaran_uas')->where('siswa_uuid', $uuid)->get();
        $person = DB::table('data_siswa')->where('uuid', $uuid)->first();
        return view('data-pembayaran.detail-uas',[
            'data' => $data,
            'person' => $person,
            'kelas' => $kelas
        ]);
    }

     public function detail2($uuid, $kelas)
    {
        $person = DB::table('data_siswa')->where('uuid', $uuid)->first();
        return view('data-pembayaran.detail-uas2',[
             'kelas' => $kelas,
             'person' => $person,
        ]);
    }
    
    
           public function send_bulk(Request $request)
    {

        $js = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first();
        
          $queryz = DB::table('data_siswa')
    ->leftJoin('pembayaran_uas', function ($join) use ($request) {
        $join->on('data_siswa.uuid', '=', 'pembayaran_uas.siswa_uuid')
            ->where('pembayaran_uas.kondisi', '=', 'Transaksi Selesai');

    })
    ->select(
        'data_siswa.id',
        'data_siswa.uuid',
        'data_siswa.nama',
         'data_siswa.kelas',
        'data_siswa.nis',
        'data_siswa.tahun',
        'data_siswa.no_telp',
        'data_siswa.alamat',
        'data_siswa.status3',
        'data_siswa.created_at',
        'data_siswa.updated_at',
        DB::raw('COALESCE(SUM(pembayaran_uas.nominal), 0) as total_bayar'),
        DB::raw('CASE WHEN COALESCE(SUM(pembayaran_uas.nominal), 0) >=' .$js->nominal.' THEN "LUNAS" ELSE "BELUM LUNAS" END as lunas')
    )
    ->where('data_siswa.status3', 'Terdaftar')
    ->where('data_siswa.kelas', $request->kelas)
    ->where('data_siswa.tahun', '=', $request->tahun)
    ->groupBy(
        'data_siswa.id',
        'data_siswa.uuid',
        'data_siswa.nama',
        'data_siswa.tahun',
        'data_siswa.nis',
        'data_siswa.kelas',
        'data_siswa.no_telp',
        'data_siswa.alamat',
        'data_siswa.status3',
        'data_siswa.created_at',
        'data_siswa.updated_at'
    )
    ->orderByDesc('data_siswa.created_at');


// ✅ Filter status pembayaran jika request ada
if ($request->filled('status')) {
    $queryz->having('lunas', $request->status); // 'LUNAS' atau 'BELUM LUNAS'
}

// ✅ Pagination
$query = $queryz->get();

  foreach ($query as $val) {
      $ttl = $js->nominal - $val->total_bayar;
      
       if($request->mess == null){
           $this->notifikasi('
📢 YPI SCHOOL
Assalamualaikum Wr. Wb.
Yth. Bapak/Ibu Orang Tua/Wali Murid
Nama Siswa: '. $val->nama .'
Kelas: '. $val->kelas .'

Kami informasikan bahwa hingga saat ini masih terdapat tunggakan pembayaran:
📌 Pendaftaran UAS Kelas '.$val->kelas.'
Jumlah: Rp '. number_format($ttl, 0, ',', '.') .'

Kami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.

Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.

Wassalamualaikum Wr. Wb.
📞  Admin Keuangan
🕘 Jam kerja: 08.00 - 14.00 WITA
        
        ', $val->no_telp);
      
  }else{
            
         $this->notifikasi($request->mess, $val->no_telp);
            
        }
      
  }
    return response()->json(['Data' => 'Data berhasil disimpan']);
    }

   public function tunggakan($uuid, $kelas)
    {
         $jns = DB::table('jenis_pembayaran')->where('jenis', 'uas')->first();

          $dt_tot = DB::table('pembayaran_uas')
          ->where('kelas', $kelas)
          ->where('siswa_uuid', $uuid)
          ->sum('nominal');

        $totals = $dt_tot ?? 0;
        $data = DB::table('pembayaran_uas')->where('siswa_uuid', $uuid)->where('kelas', $kelas)->get();
        $person = DB::table('data_siswa')->where('uuid', $uuid)->first();
        return view('data-pembayaran.tunggakan-uas',[
            'data' => $data,
            'person' => $person,
            'kelas' => $kelas,
            'tunggakan' => intval($jns->nominal) - intval($totals)
        ]);
    }
public function ajax_data(Request $request, $uuid) {
        $pendaftaran = DB::table('pembayaran_uas')->where('uuid', $uuid)->first();
        return response()->json($pendaftaran);
    }

     public function show(Request $request)
    {
         $total = DataSiswa::where('status3', 'Terdaftar')->get()
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
            $query = DataSiswa::where(function($filter) use ($search) {
                $filter->orWhere('nama', 'like', '%' . $search . '%');
                $filter->orWhere('no_telp', 'like', '%' . $search . '%');
                $filter->orWhere('alamat', 'like', '%' . $search . '%');
                $filter->orWhere('status', 'like', '%' . $search . '%');
                $filter->orWhere('agama', 'like', '%' . $search . '%');
                $filter->orWhere('jenis_kelamin', 'like', '%' . $search . '%');
                $filter->orWhere('tempat_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('tanggal_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ibu', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ibu', 'like', '%' . $search . '%');
               })
               ->where('status3', 'Terdaftar')
               ->take($length)
               ->skip($start)
               ->latest()
               ->get();

            $no = $start + 1;
            foreach ($query as $val) {

          $dt = DB::table('pembayaran_uas')
          ->where('kelas', $request->kelas)
          ->where('siswa_uuid', $val->uuid)
          ->where('status', 'Lunas')
          ->first();


           $jns = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first();

          $dt_tot = DB::table('pembayaran_uas')
          ->where('kelas', $request->kelas)
          ->where('siswa_uuid', $val->uuid)
          ->sum('nominal');

          $totals = $dt_tot ?? 0;


    if (
    ($val->status2 == 'Pendaftar Kelas XI' && $request->kelas == 'X') ||
    ($val->status2 == 'Pendaftar Kelas XII' && in_array($request->kelas, ['X', 'XI']))
    ) {
            $badge = 'badge bg-success';
            $stt = 'Lunas UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'' ;
            $n = '<a class="btn btn-sm btn-primary" href="/detail-pembayaran-uas2/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-info"></i> Rincian</a>';
    }else{
         if ($totals == null || $totals == 0) { 
            $badge = 'badge bg-danger';
            $stt = 'Belum Bayar UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'';
             $n = '
                    <a class="btn btn-sm btn-danger mt-1" href="/detail-tunggakan-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-danger"></i> Tunggakan</a>
                    <a class="btn btn-sm btn-warning mt-1" onclick="notif(\''.$val->uuid.'\', \''.$request->kelas.'\')"><i class="fas fa-eye text-warning"></i> Kirim Notifikasi</a>
                 ';
          } else if($totals > 0 && $totals < $jns->nominal){ 
            $badge = 'badge bg-warning';
            $stt = 'Belum Lunas UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'' ;
            $n = '
                    <a class="btn btn-sm btn-danger mt-1" href="/detail-tunggakan-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-danger"></i> Tunggakan</a>
                    <a class="btn btn-sm btn-primary mt-1" href="/detail-pembayaran-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-info"></i> Rincian</a>
                    <a class="btn btn-sm btn-warning mt-1" onclick="notif(\''.$val->uuid.'\', \''.$request->kelas.'\')"><i class="fas fa-eye text-warning"></i> Kirim Notifikasi</a>';
          }else if($totals >= $jns->nominal){
              $badge = 'badge bg-success';
            $stt = 'Lunas UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'' ;
            $n = '<a class="btn btn-sm btn-primary" href="/detail-pembayaran-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-info"></i> Rincian</a>';
          }
    }

  $thn = $val->created_at->format('Y');
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->nama <br> <span class=\"badge bg-secondary\">$val->agama</span></td>",
          "<td>$val->no_telp</td>",
           "<td>$val->nis</td>",
          "<td>$val->tahun</td>",
          "<td>$val->alamat Hari</td>",
          "<td><span class=\"$badge\"> $stt</span</td>",
          '<td>
         '.$n.'
         </td>'

        );
                $no++;
            }
            $rows = DataSiswa::where(function($filter) use ($search) {
                 $filter->orWhere('nama', 'like', '%' . $search . '%');
                $filter->orWhere('no_telp', 'like', '%' . $search . '%');
                $filter->orWhere('alamat', 'like', '%' . $search . '%');
                $filter->orWhere('status', 'like', '%' . $search . '%');
                $filter->orWhere('agama', 'like', '%' . $search . '%');
                $filter->orWhere('jenis_kelamin', 'like', '%' . $search . '%');
                $filter->orWhere('tempat_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('tanggal_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ibu', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ibu', 'like', '%' . $search . '%');
            })
            ->where('status3', 'Terdaftar')
            ->latest()
            ->get();
        
            $output['draw']                 = $draw;
            $output['recordsTotal']         = $output['recordsFiltered']      = $rows->count();
        }
        else{

                                       $js = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first();
     
   $queryz = DB::table('data_siswa')
    ->leftJoin('pembayaran_uas', function ($join) use ($request) {
        $join->on('data_siswa.uuid', '=', 'pembayaran_uas.siswa_uuid')
            ->where('pembayaran_uas.kondisi', '=', 'Transaksi Selesai');
  
    })
    ->select(
        'data_siswa.id',
        'data_siswa.uuid',
        'data_siswa.nama',
        'data_siswa.nis',
        'data_siswa.no_telp',
        'data_siswa.tahun',
        'data_siswa.alamat',
        'data_siswa.status3',
        'data_siswa.status2',
        'data_siswa.created_at',
        'data_siswa.updated_at',
        DB::raw('COALESCE(SUM(pembayaran_uas.nominal), 0) as total_bayar'),
        DB::raw('CASE WHEN COALESCE(SUM(pembayaran_uas.nominal), 0) >= '.$js->nominal.' THEN "LUNAS" ELSE "BELUM LUNAS" END as lunas')
    )
    ->where('data_siswa.status3', 'Terdaftar')
    ->where('data_siswa.kelas', $request->kelas)
    ->where('data_siswa.tahun', '=', $request->tahun)
    ->groupBy(
        'data_siswa.id',
        'data_siswa.uuid',
        'data_siswa.nama',
        'data_siswa.nis',
        'data_siswa.tahun',
        'data_siswa.no_telp',
        'data_siswa.alamat',
        'data_siswa.status3',
        'data_siswa.status2',
        'data_siswa.created_at',
        'data_siswa.updated_at'
    )
    ->orderByDesc('data_siswa.created_at');


// ✅ Filter status pembayaran jika request ada
if ($request->filled('sts')) {
    $queryz->having('lunas', $request->sts); // 'LUNAS' atau 'BELUM LUNAS'
}

// ✅ Pagination
$query = $queryz->skip($start)->take($length)->get();
           
            $no = $start + 1;
           
            foreach ($query as $val) {

          $dt = DB::table('pembayaran_uas')
          ->where('kelas', $request->kelas)
          ->where('siswa_uuid', $val->uuid)
          ->where('status', 'Lunas')
          ->first();


           $jns = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first();

          $dt_tot = DB::table('pembayaran_uas')
          ->where('kelas', $request->kelas)
          ->where('siswa_uuid', $val->uuid)
          ->sum('nominal');

          $totals = $dt_tot ?? 0;


    if (
    ($val->status2 == 'Pendaftar Kelas XI' && $request->kelas == 'X') ||
    ($val->status2 == 'Pendaftar Kelas XII' && in_array($request->kelas, ['X', 'XI']))
    ) {
            $badge = 'badge bg-success';
            $stt = 'Lunas UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'' ;
            $n = '<a class="btn btn-sm btn-primary" href="/detail-pembayaran-uas2/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-info"></i> Rincian</a>';
    }else{
         if ($totals == null || $totals == 0) { 
            $badge = 'badge bg-danger';
            $stt = 'Belum Bayar UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'';
             $n = '
                    <a class="btn btn-sm btn-danger mt-1" href="/detail-tunggakan-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-danger"></i> Tunggakan</a>
                    <a class="btn btn-sm btn-warning mt-1" onclick="notif(\''.$val->uuid.'\', \''.$request->kelas.'\')"><i class="fas fa-eye text-warning"></i> Kirim Notifikasi</a>
                 ';
          } else if($totals > 0 && $totals < $jns->nominal){ 
            $badge = 'badge bg-warning';
            $stt = 'Belum Lunas UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'' ;
            $n = '
                    <a class="btn btn-sm btn-danger mt-1" href="/detail-tunggakan-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-danger"></i> Tunggakan</a>
                    <a class="btn btn-sm btn-primary mt-1" href="/detail-pembayaran-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-info"></i> Rincian</a>
                    <a class="btn btn-sm btn-warning mt-1" onclick="notif(\''.$val->uuid.'\', \''.$request->kelas.'\')"><i class="fas fa-eye text-warning"></i> Kirim Notifikasi</a>';
          }else if($totals >= $jns->nominal){
              $badge = 'badge bg-success';
            $stt = 'Lunas UAS Kelas '.$request->kelas.' Bulan '.$request->bulan.'' ;
            $n = '<a class="btn btn-sm btn-primary" href="/detail-pembayaran-uas/'.$val->uuid.'/'.$request->kelas.'"><i class="fas fa-eye text-info"></i> Rincian</a>';
          }
    }


   $thn = \Carbon\Carbon::parse($val->created_at)->format('Y');
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->nama</td>",
          "<td>$val->no_telp</td>",
           "<td>$val->nis</td>",
          "<td>$val->tahun</td>",
          "<td>$val->alamat Hari</td>",
          "<td><span class=\"$badge\"> $stt</span</td>",
          '<td>
         '.$n.'
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



    public function send($uuid,$kelas)
    {
        $data = DB::table('data_siswa')->where('uuid', $uuid)->first();
        $jns = DB::table('jenis_pembayaran')->where('jenis', 'UAS')->first();

          $dt_tot = DB::table('pembayaran_uas')
          ->where('siswa_uuid', $uuid)
          ->sum('nominal');

        $totals = $dt_tot ?? 0;

        $jum = intval($jns->nominal) - intval($totals);

        $this->notifikasi('
YPI SCHOOL
Assalamualaikum Wr. Wb.
Yth. Bapak/Ibu Orang Tua/Wali Murid
Nama Siswa: '. $data->nama .'
Kelas: '. $data->kelas .'

Kami informasikan bahwa hingga saat ini masih terdapat
tunggakan pembayaran UAS Kelas '.$kelas.'
Jumlah: Rp '. number_format($jum, 0, ',', '.') .'

Kami mohon Bapak/Ibu dapat segera melakukan pelunasan dan juga bisa menghubungi bagian administrasi untuk konfirmasi.

Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.

Wassalamualaikum Wr. Wb.
Admin Keuangan
Jam kerja: 08.00 - 14.00 WIB
        
        ', $data->no_telp);
        return response()->json(['Data' => 'Data berhasil disimpan']);
    }

       public function notifikasi ($pesan, $no_telp){


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

        }catch(\Exception $e){
            return response()->json($e->getMessage());
        }
    
}
}