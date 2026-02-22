<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use App\Models\DataSiswa;
use App\Models\PembayaranPendaftaran;
use Carbon\Carbon;
use Illuminate\Support\Facades\File;
use Illuminate\Http\Request;

class PendaftaranSiswaController extends Controller
{
    public function index()
    {
        $tahunSekarang = Carbon::now()->year;
        return view('siswa.pendaftaran',[
            'tahunSekarang' => $tahunSekarang
        ]);;
    }


    public function approval(Request $request, $uuid) {
        
        try {
               DB::table('data_siswa')->where('uuid', $request->uuid)->update([
            'status3' => 'Terdaftar'
        ]);

       $data = DB::table('data_siswa')->where('uuid', $request->uuid)->first();

       $this->send('
Kepada Yth.
Orang Tua/Wali Murid & Siswa
di Tempat

Dengan hormat,
Bersama ini kami informasikan bahwa akun untuk mengakses Aplikasi Sekolah YPI School telah dibuat dan dapat digunakan untuk melihat informasi akademik siswa, absensi, nilai, jadwal, dan lainnya.

Berikut adalah detail akun Anda:

Nama Siswa: '. $data->nama .'
Kelas: '. $data->kelas .'
Username: '. $data->nis .'
Password: '. $data->tanggal_lahir .'

Silakan login melalui aplikasi YPI School.
Unduh aplikasinya melalui tautan berikut:  
👉 https://tester-yipischool-admin.online/apk/ypi-apk.apk

Dan Tutorialnya Berikut:
👉 https://tester-yipischool-admin.online/apk/panduan-cara-menggunakan-aplikasi-mobile-pembayaran.pdf

Catatan Penting:
Simpan informasi ini dengan baik dan jangan dibagikan kepada pihak yang tidak berkepentingan.
Jika mengalami kendala saat login, silakan hubungi admin sekolah atau tim IT.

Demikian informasi ini kami sampaikan. Atas perhatian dan kerjasamanya, kami ucapkan terima kasih.

Hormat kami,
Admin YPI School
       
       ', $data->no_telp);

        return response()->json('Data berhasil disimpan');
        }catch (\Throwable $th) {
            return response()->json('Data gagal disimpan');
        }
    }


    public function create(Request $request) {


           $validatedData =   $request->validate([
                'nama' => 'required',
                'tempat_lahir' => 'required',
                'tanggal_lahir' => 'required|date',
                'alamat' => 'required',
                'agama' => 'required',
                'jenis_kelamin' => 'required',
                'no_telp' => 'required',
                'nama_ayah' => 'required',
                'pekerjaan_ayah' => 'required',
                'nama_ibu' => 'required',
                'pekerjaan_ibu' => 'required',
                'kelas' => 'required',
                'foto' => 'required|mimetypes:image/jpeg,image/png,image/jpg|max:10800',
                'periode' => 'required'
            ], [
                'nama.required' => 'Nama wajib diisi.',
                'agama.required' => 'Agama wajib diisi.',
                'jenis_kelamin.required' => 'Jenis Kelamin wajib diisi.',
                'pekerjaan_ayah.required' => 'Pekerjaan ayah wajib diisi.',
                'pekerjaan_ibu.required' => 'Pekerjaan ibu wajib diisi.',
                'nama_ayah.required' => 'Nama ayah wajib diisi.',
                'nama_ibu.required' => 'Nama ibu wajib diisi.',
                'tempat_lahir.required' => 'Tempat lahir wajib diisi.',
                'tanggal_lahir.required' => 'Tanggal lahir wajib diisi.',
                'tanggal_lahir.date' => 'Tanggal lahir tidak valid.',
                'alamat.required' => 'Alamat wajib diisi.',
                'no_telp.required' => 'Nomor HP wajib diisi.',
                'kelas.required' => 'Kelas wajib diisi.',
                'foto.required' => 'Foto wajib diunggah.',
                'periode.required' => 'Periode wajib diisi.',
            ]);

         DB::beginTransaction(); 

    try {
        $fileName = time().'.'. $request->foto->extension();
        $pathPrivate = base_path('private');

        if (!File::exists($pathPrivate)) {
            File::makeDirectory($pathPrivate, 0755, true);
        }

        $request->foto->move($pathPrivate, $fileName);
        $Url = '/private/'.$fileName;

        // $nisn =  now()->format('ymd') . random_int(1000, 9999);
        $nisn = random_int(1000, 9999);
        // fungsi generate toke nisn

        if($request->kelas == 'X'){
           $sts = 'Pendaftar Baru';
        }else if($request->kelas == 'XI'){
          $sts = 'Pendaftar Kelas XI';
        }else if($request->kelas == 'XII'){
          $sts = 'Pendaftar Kelas XII';
        }

        $pendaftaran = DataSiswa::create([
            'nama' => $request->nama,
            'nis' => $nisn,
            'no_telp' => $request->no_telp,
            'alamat' => $request->alamat,
            'jenis_kelamin' => $request->jenis_kelamin,
            'agama' => $request->agama,
            'tempat_lahir' => $request->tempat_lahir,
            'tanggal_lahir' => $request->tanggal_lahir,
            'nama_ayah' => $request->nama_ayah,
            'tahun' => '2025',
            'pekerjaan_ayah' => $request->pekerjaan_ayah,
            'nama_ibu' => $request->nama_ibu,
            'pekerjaan_ibu' => $request->pekerjaan_ibu,
            'username' => $nisn,
            'password' => bcrypt($request->tanggal_lahir),
            'kelas' => $request->kelas,
            'status' => 'Pendaftaran',
            'status2' => $sts,
            'status3' => 'Register',
            'tahun' => date("Y"),
            'periode' => $request->periode,
            'foto' => $Url,
        ]);

        DB::commit(); 
        return response()->json($pendaftaran);

    } catch (\Throwable $th) {
        DB::rollBack(); 
        if (isset($Url) && File::exists(base_path($Url))) {
            File::delete(base_path($Url));
        }

        return response()->json([
            'error' => true,
            'message' => $th->getMessage(),
        ], 500);
    }
}



public function update(Request $request)
{
    $validatedData = $request->validate([
        'nama' => 'required',
        'tempat_lahir' => 'required',
        'tanggal_lahir' => 'required|date',
        'alamat' => 'required',
        'agama' => 'required',
        'jenis_kelamin' => 'required',
        'no_telp' => 'required',
        'nama_ayah' => 'required',
        'pekerjaan_ayah' => 'required',
        'nama_ibu' => 'required',
        'pekerjaan_ibu' => 'required',
        'kelas' => 'required',
        'foto' => 'nullable|mimetypes:image/jpeg,image/png,image/jpg|max:10800',
        'periode' => 'required'
    ], [
        // Pesan error sama seperti di create
        'nama.required' => 'Nama wajib diisi.',
        'agama.required' => 'Agama wajib diisi.',
        'jenis_kelamin.required' => 'Jenis Kelamin wajib diisi.',
        'pekerjaan_ayah.required' => 'Pekerjaan ayah wajib diisi.',
        'pekerjaan_ibu.required' => 'Pekerjaan ibu wajib diisi.',
        'nama_ayah.required' => 'Nama ayah wajib diisi.',
        'nama_ibu.required' => 'Nama ibu wajib diisi.',
        'tempat_lahir.required' => 'Tempat lahir wajib diisi.',
        'tanggal_lahir.required' => 'Tanggal lahir wajib diisi.',
        'tanggal_lahir.date' => 'Tanggal lahir tidak valid.',
        'alamat.required' => 'Alamat wajib diisi.',
        'no_telp.required' => 'Nomor HP wajib diisi.',
        'kelas.required' => 'Kelas wajib diisi.',
        'periode.required' => 'Periode wajib diisi.',
    ]);

    DB::beginTransaction();

    try {
        $siswa = DataSiswa::where('uuid', $request->uuid)->first();

        // Proses upload foto jika ada
        if ($request->hasFile('foto')) {
            $fileName = time().'.'. $request->foto->extension();
            $pathPrivate = base_path('private');

            if (!File::exists($pathPrivate)) {
                File::makeDirectory($pathPrivate, 0755, true);
            }

            $request->foto->move($pathPrivate, $fileName);
            $newFotoUrl = '/private/' . $fileName;

            // Hapus foto lama jika ada
            if ($siswa->foto && File::exists(base_path($siswa->foto))) {
                File::delete(base_path($siswa->foto));
            }

            $siswa->foto = $newFotoUrl;
        }

        // Perbarui status2 berdasarkan kelas
        $sts = match($request->kelas) {
            'X' => 'Pendaftar Baru',
            'XI' => 'Pendaftar Kelas XI',
            'XII' => 'Pendaftar Kelas XII',
            default => $siswa->status2,
        };

        // Update field lainnya
        $siswa->update([
            'nama' => $request->nama,
            'no_telp' => $request->no_telp,
            'alamat' => $request->alamat,
            'jenis_kelamin' => $request->jenis_kelamin,
            'agama' => $request->agama,
            'tempat_lahir' => $request->tempat_lahir,
            'tanggal_lahir' => $request->tanggal_lahir,
            'nama_ayah' => $request->nama_ayah,
            'pekerjaan_ayah' => $request->pekerjaan_ayah,
            'nama_ibu' => $request->nama_ibu,
            'pekerjaan_ibu' => $request->pekerjaan_ibu,
            'kelas' => $request->kelas,
            'tahun' => $request->tahun,
            'status2' => $sts,
            'periode' => $request->periode,
            // Password tidak diubah saat update. Bisa ditambahkan jika perlu.
        ]);

        DB::commit();
        return response()->json($siswa);

    } catch (\Throwable $th) {
        DB::rollBack();
        return response()->json([
            'error' => true,
            'message' => $th->getMessage(),
        ], 500);
    }
}



    public function ajax_data(Request $request, $uuid) {
        $pendaftaran = DataSiswa::where('uuid', $uuid)->first();
        return response()->json($pendaftaran);
    }

    public function show (Request $request) {
      
         $total = DataSiswa::where('status', 'Pendaftaran')->where('status3', 'Register')->get()->count();
        
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
                $filter->orWhere('status_bayar', 'like', '%' . $search . '%');
                $filter->orWhere('agama', 'like', '%' . $search . '%');
                $filter->orWhere('jenis_kelamin', 'like', '%' . $search . '%');
                $filter->orWhere('tempat_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('tanggal_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ibu', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ibu', 'like', '%' . $search . '%');
               })->where('status3', 'Register')->where('status', 'Pendaftaran')->where('tahun', $request->tahun)
                ->where('kelas', $request->kelas)->take($length)->skip($start)->latest()->get();
            $no = $start + 1;
            foreach ($query as $val) {
            if ($val->status_bayar == 'Belum Bayar Pendaftaran') {
            $badge = 'badge bg-danger';
          } else if ($val->status_bayar == 'Belum Lunas Pendaftaran') {
            $badge = 'badge bg-warning';
          }else {
            $badge = 'badge bg-success';
          }
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->nama <br> <span class=\"badge bg-secondary\">$val->agama</span></td>",
          "<td>$val->no_telp</td>",
                 "<td>$val->kelas</td>",
          "<td>$val->tahun</td>",
        //   "<td>$val->alamat Hari</td>",
        //   "<td>$val->status <br> <span class=\"$badge\">$val->status_bayar</span</td>",
          '<td>
              <div class="btn-group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown"> Aksi </button>
               <ul class="dropdown-menu" role="menu">
                  <li>
                    <a class="dropdown-item" onclick="detail(\''.$val->uuid.'\')" href="#"><i class="fas fa-eye text-info"></i> Detail</a>
                    <a class="dropdown-item" onclick="edit(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-warning"></i> Edit</a>
                    <a class="dropdown-item" onclick="approval(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-success"></i> Approval</a>
                  </li>
                </ul>
              </div>
        </td>'




      );
                $no++;
            }
            $rows = DataSiswa::where(function($filter) use ($search) {
                 $filter->orWhere('nama', 'like', '%' . $search . '%');
                $filter->orWhere('no_telp', 'like', '%' . $search . '%');
                $filter->orWhere('alamat', 'like', '%' . $search . '%');
                $filter->orWhere('status', 'like', '%' . $search . '%');
                $filter->orWhere('status_bayar', 'like', '%' . $search . '%');
                $filter->orWhere('agama', 'like', '%' . $search . '%');
                $filter->orWhere('jenis_kelamin', 'like', '%' . $search . '%');
                $filter->orWhere('tempat_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('tanggal_lahir', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ayah', 'like', '%' . $search . '%');
                $filter->orWhere('nama_ibu', 'like', '%' . $search . '%');
                $filter->orWhere('pekerjaan_ibu', 'like', '%' . $search . '%');
            })->where('status3', 'Register')
            ->where('status', 'Pendaftaran')
            ->latest()
            ->get();
        
            $output['draw']                 = $draw;
            $output['recordsTotal']         = $output['recordsFiltered']      = $rows->count();
        }
        else{

                $query =DataSiswa::take($length)->where('status3', 'Register')
                ->where('status', 'Pendaftaran')
                ->where('tahun', $request->tahun)
                ->where('kelas', $request->kelas)
                ->skip($start)
                ->latest()
                ->get();
           
            $no = $start + 1;
            foreach ($query as $val) {

          $biaya_pendafatran = PembayaranPendaftaran::where('siswa_uuid', $val->uuid)->first();

          if ($biaya_pendafatran ?? null == null) {
            $badge = 'badge bg-danger';
            $stt = 'Belum Bayar Pendaftaran';
          } else if ($biaya_pendafatran ?? null == 'Belum Lunas') {
            $badge = 'badge bg-warning';
            $stt = 'Belum Lunas Pendaftaran';
          }else {
            $badge = 'badge bg-success';
            $stt = 'Lunas Pendaftaran';
          }
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->nama <br> <span class=\"badge bg-secondary\">$val->agama</span></td>",
          "<td>$val->no_telp</td>",
          "<td>$val->kelas</td>",
          "<td>$val->tahun</td>",
          '<td>
              <div class="btn-group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown"> Aksi </button>
               <ul class="dropdown-menu" role="menu">
                  <li>
                    <a class="dropdown-item" onclick="detail(\''.$val->uuid.'\')" href="#"><i class="fas fa-eye text-info"></i> Detail</a>
                    <a class="dropdown-item" onclick="edit(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-warning"></i> Edit</a>
                      <a class="dropdown-item" onclick="approval(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-success"></i> Approval</a>
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


      public function send ($pesan, $no_telp){


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