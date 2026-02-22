<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

class LoginController extends Controller
{
    public function index()
    {
        return view('login.index');
    }

     public function auth(Request $request)
    {
        $validated =  $request->validate([
            'email' => 'required',
            'password' => 'required'
        ]);
        if(Auth::attempt($validated)){
            $request->session()->regenerate();
        //    dd(Auth::user());
            return redirect()->intended('/dashboard');
        }else{
                //  dd(Auth::user());
          return redirect('/')->with('loginFailed', 'Login Failed!');
        }

    }

    public function logout(Request $request){
       // 1. Logout dari guard
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();
    Session::flush();

    // 5. Redirect ke halaman login atau halaman lain
    return redirect()->route('login')->with('status', 'Berhasil logout');

    }
}
