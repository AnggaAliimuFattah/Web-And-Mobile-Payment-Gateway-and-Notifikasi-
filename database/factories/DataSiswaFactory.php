<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\DataSiswa>
 */
class DataSiswaFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        
    $faker = $this->faker;

    $nis = '23' . $faker->unique()->numberBetween(1000, 9999);
    $tanggal_lahir = $faker->date(); // default format: YYYY-MM-DD

    return [
        'uuid' => Str::random(10),
        'nis' => $nis,
        'nama' => $faker->name(),
        'kelas' => $faker->randomElement(['X', 'XI', 'XII']),
        'alamat' => $faker->address(),
        'no_telp' => $faker->phoneNumber(),
        'jenis_kelamin' => $faker->randomElement(['Laki-laki', 'Perempuan']),
        'agama' => $faker->randomElement(['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu']),
        'tempat_lahir' => $faker->city(),
        'tanggal_lahir' => $tanggal_lahir,
        'pekerjaan_ayah' => $faker->jobTitle(),
        'nama_ayah' => $faker->name(),
        'pekerjaan_ibu' => $faker->jobTitle(),
        'nama_ibu' => $faker->name(),

        // Username = NIS, Password = Tanggal Lahir (default format)
        'username' => $nis,
        'password' => bcrypt($tanggal_lahir), // plaintext, ubah ke bcrypt jika perlu
        'status' => 'Pendaftaran',
        'foto' => ''

    ];

    }
}