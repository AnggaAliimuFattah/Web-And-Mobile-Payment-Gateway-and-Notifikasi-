<?php

namespace App\Models;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Model;

class PembayaranSpp extends Model
{
      protected $table = 'pembayaran_spp';

    protected $guarded = ['id'];

    protected static function boot()
{
    parent::boot();

    static::creating(function ($model) {
        $model->uuid = (string) Str::uuid();
    });
}
}
