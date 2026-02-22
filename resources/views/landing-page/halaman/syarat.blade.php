@extends('landing-page.layouts.main')

@section('content')

<main class="main">
    <section id="contact" class="contact section">
        <h1 class="mb-5 text-center">Persyaratan</h1>

        <div class="container" data-aos="fade-up" data-aos-delay="100">
            <div class="row gy-4 justify-content-center">
                <div class="col-lg-8">

                    <div class="card shadow-sm border-0 rounded-4 p-4">
                        <h5 class="mb-3">Syarat Umum</h5>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item">1. Mengisi formulir pendaftaran.</li>
                            <li class="list-group-item">2. Fotokopi Akta Kelahiran (1 lembar).</li>
                            <li class="list-group-item">3. Fotokopi Kartu Keluarga (1 lembar).</li>
                            <li class="list-group-item">4. Fotokopi KTP orang tua/wali (1 lembar).</li>
                            <li class="list-group-item">5. Pas foto 3x4 berwarna (2 lembar).</li>
                            <li class="list-group-item">6. Ijazah / Surat Keterangan Lulus dari jenjang sebelumnya.</li>
                            <li class="list-group-item">7. Fotokopi rapor semester terakhir.</li>
                            <li class="list-group-item">8. Surat keterangan sehat dari puskesmas/dokter.</li>
                            <li class="list-group-item">9. Fotokopi KIP / bantuan lain (jika ada).</li>
                        </ul>


                        <h5 class="mb-3">Syarat Khusus <small class="text-muted">(Jika berlaku)</small></h5>
                        <ul class="list-group list-group-flush mb-4">
                            <li class="list-group-item">1. Surat pindah dari sekolah sebelumnya.</li>
                            <li class="list-group-item">3. Surat pernyataan kesiapan mengikuti aturan sekolah.</li>
                            <li class="list-group-item">4. Wawancara siswa/orang tua.</li>
                        </ul>

                        <div class="alert alert-info mt-4">
                            <strong>Catatan:</strong> Semua dokumen dimasukkan dalam map berwarna sesuai ketentuan sekolah. 
                            Batas waktu pendaftaran: Yang Ditentukan Oleh Panitia Atau <em>Silakan hubungi panitia.</em>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
</main>


@endsection