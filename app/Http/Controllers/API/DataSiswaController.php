<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DataSiswaController extends Controller
{
    public function pendaftaran()
    {
        $data = DB::table('data_siswa')->where('status', 'Pendaftaran')->get();
        return response()->json($data);
    }
    public function siswa()
    {
        $data = DB::table('data_siswa')->where('status', 'siswa')->get();
        return response()->json($data);
    }

       public function show(Request $request)
    {
        $data = DB::table('data_siswa')->where('uuid', $request->uuid)->first();
        return response()->json($data);
    }

       public function all(Request $request)
    {
$uuid = $request->uuid;

// Ambil data dari masing-masing tabel
$pendaftaran = DB::table('pembayaran_pendaftaran')
    ->where('siswa_uuid', $uuid)
    ->get();

$spp = DB::table('pembayaran_spp')
    ->where('siswa_uuid', $uuid)
    ->get();

$uts = DB::table('pembayaran_uts')
    ->where('siswa_uuid', $uuid)
    ->get();

$uas = DB::table('pembayaran_uas')
    ->where('siswa_uuid', $uuid)
    ->get();

// Gabungkan semua data jadi satu collection
$allData = $pendaftaran
    ->concat($spp)
    ->concat($uts)
    ->concat($uas)
    ->unique('uuid')   // hapus duplikat berdasarkan UUID
    ->values();        // reset index agar rapi

return response()->json($allData);

    }
}