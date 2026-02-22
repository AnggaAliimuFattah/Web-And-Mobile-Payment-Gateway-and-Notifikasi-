<?php


use App\Http\Controllers\PembayaranPendaftaranController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DataSiswaController;
use App\Http\Controllers\JenisPembayaranController;
use App\Http\Controllers\LandingPageController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\NotifikasiController;
use App\Http\Controllers\PembayaranSppController;
use App\Http\Controllers\PendaftaranSiswaController;
use App\Http\Controllers\PembayaranUasController;
use App\Http\Controllers\PembayaranUtsController;
use App\Http\Controllers\RegistrasiController;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Route;




route::get('/', [LandingPageController::class, 'index']);
route::get('/biaya-pendaftaran', [LandingPageController::class, 'daftar_biaya']);
route::get('/persyaratan', [LandingPageController::class, 'syarat']);


route::get('/login-admin', [LoginController::class, 'index'])->name('login');
route::post('/login', [LoginController::class, 'auth']);
route::post('/logout', [LoginController::class, 'logout'])->name('logout');




Route::get('/dashboard', [DashboardController::class, 'index'])->middleware('auth');

Route::get('/registrasi', [RegistrasiController::class, 'index']);


Route::get('/approval-siswa/{uuid}', [PendaftaranSiswaController::class, 'approval'])->middleware('auth');
Route::get('/pendaftaran-siswa', [PendaftaranSiswaController::class, 'index'])->middleware('auth');
Route::post('/pendaftaran-siswa', [PendaftaranSiswaController::class, 'show'])->middleware('auth');
Route::post('/insert-pendaftaran-siswa', [PendaftaranSiswaController::class, 'create']);
Route::post('/update-pendaftaran-siswa', [PendaftaranSiswaController::class, 'update'])->middleware('auth');
Route::get('/ajax-data-pendaftaran-siswa/{uuid}', [PendaftaranSiswaController::class, 'ajax_data'])->middleware('auth');
Route::get('/foto/{folder}/{data}', function ($folder, $data) {
    $path = base_path(  $folder.'/'.$data);
    if (!file_exists($path)) {
        abort(403);
    }
    return response()->file($path);
})->middleware('auth');


Route::get('/data-siswa', [DataSiswaController::class, 'index'])->middleware('auth');
Route::post('/data-siswa', [DataSiswaController::class, 'show'])->middleware('auth');
Route::post('/edit-data-siswa', [DataSiswaController::class, 'update'])->middleware('auth');
Route::post('/insert-data-siswa', [DataSiswaController::class, 'create'])->middleware('auth');
Route::get('/ajax-data-siswa/{uuid}', [DataSiswaController::class, 'ajax_data'])->middleware('auth');
Route::get('/ajax-list-data-siswa', [DataSiswaController::class, 'ajax_list'])->middleware('auth');
Route::get('/ajax-change-data-siswa/{uuid}', [DataSiswaController::class, 'onChange'])->middleware('auth');
Route::get('/delete-data-siswa/{uuid}', [DataSiswaController::class, 'destroy'])->middleware('auth');

Route::get('/jenis-pembayaran', [JenisPembayaranController::class, 'index'])->middleware('auth');
Route::post('/jenis-pembayaran', [JenisPembayaranController::class, 'show'])->middleware('auth');
Route::post('/insert-jenis-pembayaran', [JenisPembayaranController::class, 'create'])->middleware('auth');
Route::get('/ajax-data-jenis-pembayaran/{uuid}', [JenisPembayaranController::class, 'ajax_data'])->middleware('auth');
Route::post('/edit-data-jenis-pembayaran', [JenisPembayaranController::class, 'update'])->middleware('auth');


Route::get('/data-bayar-pendaftaran', [PembayaranPendaftaranController::class, 'index'])->middleware('auth');
Route::post('/data-bayar-pendaftaran', [PembayaranPendaftaranController::class, 'show'])->middleware('auth');
Route::get('/detail-pembayaran-pendaftaran/{uuid}', [PembayaranPendaftaranController::class, 'detail'])->middleware('auth');
Route::get('/detail-tunggakan-pendaftaran/{uuid}', [PembayaranPendaftaranController::class, 'tunggakan'])->middleware('auth');
Route::get('/notifikasi-tunggakan-pendaftaran/{uuid}', [PembayaranPendaftaranController::class, 'send'])->middleware('auth');
Route::post('/notifikasi-tunggakan-pendaftaran-all', [PembayaranPendaftaranController::class, 'send_bulk'])->middleware('auth');

Route::get('/data-bayar-spp', [PembayaranSppController::class, 'index'])->middleware('auth');
Route::post('/data-bayar-spp', [PembayaranSppController::class, 'show'])->middleware('auth');
Route::get('/detail-pembayaran-spp/{uuid}/{bln}/{kelas}', [PembayaranSppController::class, 'detail'])->middleware('auth');
Route::get('/detail-pembayaran-spp2/{uuid}/{bln}/{kelas}', [PembayaranSppController::class, 'detail2'])->middleware('auth');
Route::get('/detail-tunggakan-spp/{uuid}/{bln}/{kelas}', [PembayaranSppController::class, 'tunggakan'])->middleware('auth');
Route::get('/notifikasi-tunggakan-spp/{uuid}/{bln}/{kelas}', [PembayaranSppController::class, 'send'])->middleware('auth');
Route::post('/notifikasi-tunggakan-spp-all', [PembayaranSppController::class, 'send_bulk'])->middleware('auth');

Route::get('/data-bayar-uts', [PembayaranUtsController::class, 'index'])->middleware('auth');
Route::post('/data-bayar-uts', [PembayaranUtsController::class, 'show'])->middleware('auth');
Route::get('/detail-pembayaran-uts/{uuid}/{kelas}', [PembayaranUtsController::class, 'detail'])->middleware('auth');
Route::get('/detail-pembayaran-uts2/{uuid}/{kelas}', [PembayaranUtsController::class, 'detail2'])->middleware('auth');
Route::get('/detail-tunggakan-uts/{uuid}/{kelas}', [PembayaranUtsController::class, 'tunggakan'])->middleware('auth');
Route::get('/notifikasi-tunggakan-uts/{uuid}/{kelas}', [PembayaranUtsController::class, 'send'])->middleware('auth');
Route::post('/notifikasi-tunggakan-uts-all', [PembayaranUtsController::class, 'send_bulk'])->middleware('auth');

Route::get('/data-bayar-uas', [PembayaranUasController::class, 'index'])->middleware('auth');
Route::post('/data-bayar-uas', [PembayaranUasController::class, 'show'])->middleware('auth');
Route::get('/detail-pembayaran-uas/{uuid}/{kelas}', [PembayaranUasController::class, 'detail'])->middleware('auth');
Route::get('/detail-pembayaran-uas2/{uuid}/{kelas}', [PembayaranUasController::class, 'detail2'])->middleware('auth');
Route::get('/detail-tunggakan-uas/{uuid}/{kelas}', [PembayaranUasController::class, 'tunggakan'])->middleware('auth');
Route::get('/notifikasi-tunggakan-uas/{uuid}/{kelas}', [PembayaranUasController::class, 'send'])->middleware('auth');
Route::post('/notifikasi-tunggakan-uas-all', [PembayaranUasController::class, 'send_bulk'])->middleware('auth');



Route::get('/notifikasi', [NotifikasiController::class, 'index'])->middleware('auth');
Route::post('/send-notifikasi', [NotifikasiController::class, 'send'])->middleware('auth');

Route::post('/notif-wa', [NotifikasiController::class, 'show'])->middleware('auth');