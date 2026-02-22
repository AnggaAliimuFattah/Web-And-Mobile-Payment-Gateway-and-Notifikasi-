@extends('layouts.main')

@section('content')
 <div class="card mb-6">
                    <div class="card-header">
                      <h5 class="card-title m-0">Detail Tracking Pembayaran SPP {{$person->nama}} Bulan {{$bln}} Kelas {{$kelas}}</h5>
                    </div>
                    <div class="card-body pt-1">
                      <ul class="timeline pb-0 mb-0">

                        @foreach ($data as $d)
                               <li class="timeline-item timeline-item-transparent border-primary">
                          <span class="timeline-point timeline-point-primary"></span>
                          <div class="timeline-event">
                            <div class="timeline-header">
                              <h6 class="mb-0">{{ $d->status }} (Payment ID: #{{ $d->uuid }})</h6>
                              <small class="text-body-secondary">{{ \Carbon\Carbon::parse($d->created_at)->locale('id')->translatedFormat('l H:i:s') }}</small>
                            </div>
                             <div class="d-flex  flex-column">
                            <span class="text-success">Jumlah Bayar : {{ 'Rp ' . number_format($d->nominal, 0, ',', '.') }}</span>
                            <span class=" text-warning">Sisa Tagihan : {{ 'Rp ' . number_format($d->sisa, 0, ',', '.') }}</span>
                          </div>
                          </div>
                        </li>
                        @endforeach

                     


                        
                    
                      </ul>
                    </div>
                  </div>
@endsection