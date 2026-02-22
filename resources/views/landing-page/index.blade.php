@extends('landing-page.layouts.main')
@section('content')
<main class="main">

        <!-- Hero Section -->
        <section id="hero" class="hero section">

            <img src="assets-landing/img/hero-bg-abstract.jpg" alt="" data-aos="fade-in" class="">

            <div class="container">
                <div class="row justify-content-center" data-aos="zoom-out">
                    <div class="col-xl-12 col-lg-12">
                        <h1 class="mb-4">Selamat Datang di Aplikasi Pendaftaran Siswa Baru YPI School Balikpapan</h1>
                        <span style="font-size: 20px;" class="mt-5">Sistem pendaftaran online ini ditujukan bagi calon siswa baru YPI School Balikpapan </span>
                        <br>
                        <span style="font-size: 20px;">guna mempermudah proses pendaftaran secara praktis dan efisien.</span>
                       
                    </div>
                </div>
               

                <div class="row gy-4 mt-5 justify-content-center">
                    <div class="col-md-6 col-lg-3" data-aos="zoom-out" data-aos-delay="100">
                        <a href="/biaya-pendaftaran">
                        <div class="icon-box text-center">
                            <div class="icon"><i style="font-size: 50px;" class="bi bi-calendar-week text-info"></i></div>
                            <h4 class="title"><a href="/biaya-pendaftaran">Informasi Biaya Sekolah</a></h4>
                           
                        </div>
                        </a>
                    </div><!--End Icon Box -->

                    <div class="col-md-6 col-lg-3" data-aos="zoom-out" data-aos-delay="200">
                        <a href="/registrasi">
                        <div class="icon-box text-center">
                            <div class="icon"><i style="font-size: 50px;" class="bi bi-person-badge text-info"></i></div>
                            <h4 class="title"><a href="/registrasi">Registrasi Pendaftaran</a></h4>
                        </div>
                        </a>
                    </div><!--End Icon Box -->

                    <div class="col-md-6 col-lg-3" data-aos="zoom-out" data-aos-delay="300">
                        <a href="/persyaratan">
                        <div class="icon-box text-center">
                            <div class="icon"><i style="font-size: 50px;" class="bi bi-person-badge-fill text-info"></i></div>
                            <h4 class="title"><a href="/persyaratan">Persyaratan Pendaftaran</a></h4>
                        </div>
                        </a>
                    </div><!--End Icon Box -->

                    

                </div>
            </div>

        </section><!-- /Hero Section -->

    </main>

    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form action="/cek-booking" method="post">
        @csrf
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Form Cek Booking</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
  <label for="basic-url" class="form-label">Masukan No Booking</label>
  <div class="input-group">
    <input type="text" class="form-control" id="no_booking" name="no_booking">
  </div>
</div>

  <div class="mb-3">
  <label for="basic-url" class="form-label">Masukan No Telpon</label>
  <div class="input-group">
    <input type="text" class="form-control" id="no_telp" name="no_telp">
  </div>
</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Kirim</button>
      </div>
      </form>
    </div>
  </div>
</div>

@endsection