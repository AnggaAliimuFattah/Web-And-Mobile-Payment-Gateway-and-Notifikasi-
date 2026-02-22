<?php

namespace App\Http\Controllers;

use App\Models\DataSiswa;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class DataSiswaController extends Controller
{
    public function index()
    {
        $tahunSekarang = Carbon::now()->year;
        return view('siswa.siswa',[
            'tahunSekarang' => $tahunSekarang
        ]);
    }


    public function ajax_list(Request $request) {

            $dt = DB::table('data_siswa')->select('nis', 'nama', 'uuid', 'id')
            ->where(function ($query) use ($request) {
                $query->where('nis', 'LIKE', '%'.$request->q.'%')
                      ->orWhere('nama', 'LIKE', '%'.$request->q.'%');
            })
            ->where('status', 'pendaftaran')
            ->orWhere('status', 'Terdaftar')
            ->orWhere('status', 'siswa')
            ->limit(100)->get();
        
    // Format data agar sesuai dengan select2
    $data = $dt->map(function ($item) {

        return [
            'id' => $item->uuid,
            'nis' => $item->nis,
            'nama' => $item->nama,
            'text' => $item->nama . ' # ' . $item->nis
        ];
        
    });

    return response()->json($data);
  
    }

     public function ajax_data(Request $request, $uuid) {
        $data = DataSiswa::where('uuid', $uuid)->first();
        return response()->json($data);
    }
    public function onchange(Request $request, $uuid) {
        $data = DataSiswa::where('uuid', $uuid)->first();
        return response()->json($data);
    }


      public function create(Request $request) {
        $data = DataSiswa::where('uuid', $request->uuid)->update(['status' => 'Siswa']);
        return response()->json($data);
    }


    public function show (Request $request) {
        
         $total = DataSiswa::where('status', 'Siswa')->where('status3', 'Terdaftar')->get()->count();
        
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
               })->where('status3', 'Terdaftar')->where('tahun', $request->tahun)
                ->where('kelas', $request->kelas)->take($length)->skip($start)->latest()->get();
            $no = $start + 1;
            foreach ($query as $val) {
                
        $badge = 'badge bg-success';
        $stt = 'Siswa';
        $thn = $val->created_at->format('Y');
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->nama <br> <span class=\"badge bg-secondary\">$val->agama</span></td>",
          "<td>$val->no_telp</td>",
           "<td>$val->nis</td>",
          "<td> $thn</td>",
          "<td>$val->alamat </td>",
        "<td>$val->kelas</td>",
          '<td>
              <div class="btn-group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown"> Aksi </button>
               <ul class="dropdown-menu" role="menu">
                  <li>
                    <a class="dropdown-item" onclick="detail(\''.$val->uuid.'\')" href="#"><i class="fas fa-eye text-info"></i> Detail</a>
                    <a class="dropdown-item" onclick="edit(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-warning"></i> Edit</a>
                    <a class="dropdown-item" onclick="hapus(\''.$val->uuid.'\')" href="#"><i class="fas fa-trash text-danger"></i> Delete</a>
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
            })->where('status3', 'Terdaftar')
            
            ->latest()
            ->get();
        
            $output['draw']                 = $draw;
            $output['recordsTotal']         = $output['recordsFiltered']      = $rows->count();
        }
        else{

                $query =DataSiswa::take($length)->where('status3', 'Terdaftar')
                ->where('tahun', $request->tahun)
                ->where('kelas', $request->kelas)
                ->skip($start)
                ->latest()
                ->get();
           
            $no = $start + 1;
            foreach ($query as $val) {

        $badge = 'badge bg-success';
        $stt = 'Siswa';
        $thn = $val->created_at->format('Y');
              
         $output['data'][] =       
         array(
                        
          
           
          "<td>$no</td>",
          "<td>$val->nama <br> <span class=\"badge bg-secondary\">$val->agama</span></td>",
          "<td>$val->no_telp</td>",
           "<td>$val->nis</td>",
          "<td> $thn</td>",
          "<td>$val->alamat </td>",
          "<td>$val->kelas</td>",
          '<td>
              <div class="btn-group dropdown">
                  <button class="btn btn-primary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown"> Aksi </button>
               <ul class="dropdown-menu" role="menu">
                  <li>
                    <a class="dropdown-item" onclick="detail(\''.$val->uuid.'\')" href="#"><i class="fas fa-eye text-info"></i> Detail</a>
                    <a class="dropdown-item" onclick="edit(\''.$val->uuid.'\')" href="#"><i class="fas fa-edit text-warning"></i> Edit</a>
                    <a class="dropdown-item" onclick="hapus(\''.$val->uuid.'\')" href="#"><i class="fas fa-trash text-danger"></i> Delete</a>
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

    public function destroy(Request $request, $uuid) {
        $data = DataSiswa::where('uuid', $uuid)->delete();
        DB::table('pembayaran_pendaftaran')->where('siswa_uuid', $uuid)->delete();
         DB::table('pembayaran_spp')->where('siswa_uuid', $uuid)->delete();
          DB::table('pembayaran_uts')->where('siswa_uuid', $uuid)->delete();
           DB::table('pembayaran_uas')->where('siswa_uuid', $uuid)->delete();
        return response()->json($data);
    }

    public function update (Request $request) {
        
        $data = DataSiswa::where('uuid', $request->uuid)->update([
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
        ]);
        return response()->json($data);
    }
}