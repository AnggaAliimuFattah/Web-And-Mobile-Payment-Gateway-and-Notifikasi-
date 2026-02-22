<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pembayaran_uas', function (Blueprint $table) {
            $table->id();
            $table->uuid()->unique();
            $table->foreignUuid('siswa_uuid')->references('uuid')->on('data_siswa')->onDelete('cascade');
            $table->string('status');
            $table->string('nominal');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pembayaran_uas');
    }
};