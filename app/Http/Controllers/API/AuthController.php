<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;


class AuthController extends Controller
{

      public function login(Request $request)
{
    $credentials = $request->only('username', 'password');

    // Tambahkan kondisi status3 = 'terdaftar'
    $credentials['status3'] = 'Terdaftar';

    if (!$token = Auth::guard('api')->attempt($credentials)) {
        return response()->json(['error' => 'Username, password, atau status tidak valid'], 401);
    }

    return response()->json([
        'access_token' => $token,
        'user' => Auth::guard('api')->user(),
    ]);
}


    public function me()
    {
        return response()->json(Auth::guard('api')->user());
    }

}