@extends('landing-page.layouts.main')

@section('content')

<main class="main">
    <section id="contact" class="contact section">

        <h1 class="mb-5 text-center">Biaya Sekolah</h1>

        <div class="container" data-aos="fade-up" data-aos-delay="100">

            <form  class="mb-4">
                <div class="row justify-content-center">
                    
                    <div class="col-md-2">
                        <a href="/registrasi" class="btn btn-success w-100">Daftar Sekarang</a>
                    </div>
                </div>
            </form>

            <div class="row gy-4">

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">No</th>
                            <th scope="col">Jenis</th>
                            <th scope="col">Nominal</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($data as $d)

                            <tr>
                                <th scope="row">{{ $loop->iteration }}</th>
                                <td>{{ $d->jenis }}</td>
                                <td>{{ 'Rp ' . number_format($d->nominal, 0, ',', '.') }}</td>
                            </tr>

                        @endforeach
                    </tbody>
                </table>

            </div>

        </div>

    </section>
</main>

@endsection