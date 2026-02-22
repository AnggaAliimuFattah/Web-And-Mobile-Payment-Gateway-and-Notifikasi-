<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LandingPageController extends Controller
{

    public function index()
    {
        return view('landing-page.index');
    }
    
    public function daftar_biaya()
    {
        $data = DB::table('jenis_pembayaran')->get();
        return view('landing-page.halaman.info_biaya',[
            'data' => $data
        ]);
    }

    public function syarat()
    {
        return view('landing-page.halaman.syarat');
    }
}