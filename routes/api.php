<?php

use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\DataSiswaController;
use App\Http\Controllers\API\PembayaranPendaftaranController;
use App\Http\Controllers\API\PembayaranSppController;
use App\Http\Controllers\API\PembayaranUasController;
use App\Http\Controllers\API\PembayaranUtsController;
use App\Http\Controllers\API\NotifikasiController;
use Illuminate\Support\Facades\Route;

Route::post('/auth', [AuthController::class, 'login']);
Route::get('/siswa', [DataSiswaController::class, 'siswa']);
Route::get('/pendaftaran', [DataSiswaController::class, 'pendaftaran']);

Route::post('/data-siswa', [DataSiswaController::class, 'show']);
Route::post('/activity-siswa', [DataSiswaController::class, 'all']);

Route::get('/riwayat-tagihan-pendaftaran/{uuid}', [PembayaranPendaftaranController::class, 'riwayat_tagihan_pendaftaran']);
Route::get('/cek-tagihan-pendaftaran/{uuid}', [PembayaranPendaftaranController::class, 'cek_tagihan_pendaftaran']);
Route::get('/payment-pendaftaran/{uuid}/{amount}', [PembayaranPendaftaranController::class, 'createSnapToken']);
Route::post('/detail-tagihan-pendaftaran', [PembayaranPendaftaranController::class, 'detail_tagihan_pendaftaran']);

Route::post('/riwayat-tagihan-spp', [PembayaranSppController::class, 'riwayat_tagihan_spp']);
Route::post('/cek-tagihan-spp', [PembayaranSppController::class, 'cek_tagihan_spp']);
Route::get('/payment-spp/{uuid}/{amount}/{kelas}/{bln}', [PembayaranSppController::class, 'createSnapToken']);
Route::post('/detail-tagihan-spp', [PembayaranSppController::class, 'detail_tagihan_spp']);

Route::post('/riwayat-tagihan-uts', [PembayaranUtsController::class, 'riwayat_tagihan_uts']);
Route::post('/cek-tagihan-uts', [PembayaranUtsController::class, 'cek_tagihan_uts']);
Route::get('/payment-uts/{uuid}/{amount}/{kelas}', [PembayaranUtsController::class, 'createSnapToken']);
Route::post('/detail-tagihan-uts', [PembayaranUtsController::class, 'detail_tagihan_uts']);

Route::post('/riwayat-tagihan-uas', [PembayaranUasController::class, 'riwayat_tagihan_uas']);
Route::post('/cek-tagihan-uas', [PembayaranUasController::class, 'cek_tagihan_uas']);
Route::get('/payment-uas/{uuid}/{amount}/{kelas}', [PembayaranUasController::class, 'createSnapToken']);
Route::post('/detail-tagihan-uas', [PembayaranUasController::class, 'detail_tagihan_uas']);

Route::post('/callback-notifikasi', [NotifikasiController::class, 'handleNotification']);
Route::get('/send-wa/{pesan}/{no_telp}', [NotifikasiController::class, 'sendwa']);