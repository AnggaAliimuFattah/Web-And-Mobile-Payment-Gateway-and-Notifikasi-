@extends('layouts.main')

@section('content')
 <div class="card mb-6">
                    <div class="card-header">
                       <h5 class="card-title m-0">Detail Tunggakan Pembayaran Pendaftaran {{$person->nama}} </h5>
                    </div>
                    <div class="card-body pt-1">
                      <ul class="timeline pb-0 mb-0">

               
                               <li class="timeline-item timeline-item-transparent border-primary">
                          <span class="timeline-point timeline-point-primary"></span>
                          <div class="timeline-event">
                            <div class="timeline-header">
                              <h6 class="mb-0">Tunggakan</h6>
                            </div>
                            <div class="d-flex  flex-column">
                            <span class=" text-warning">Jumlah Tagihan : {{ 'Rp ' . number_format($tunggakan, 0, ',', '.') }}</span>
                          </div>
                             <div class="d-flex  flex-column">
                          </div>
                          </div>
                        </li>
                   

                     


                        
                    
                      </ul>
                    </div>
                  </div>
@endsection