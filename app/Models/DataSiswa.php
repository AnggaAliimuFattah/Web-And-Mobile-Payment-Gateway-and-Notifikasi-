<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Support\Str;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Database\Eloquent\Model;

class DataSiswa extends Authenticatable implements JWTSubject
{
   use HasFactory;  
    protected $table = 'data_siswa';
    protected $hidden = ['password'];  
    protected $guarded = ['id'];

       public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    protected static function boot()
{
    parent::boot();

    static::creating(function ($model) {
        $model->uuid = (string) Str::uuid();
    });
}
}