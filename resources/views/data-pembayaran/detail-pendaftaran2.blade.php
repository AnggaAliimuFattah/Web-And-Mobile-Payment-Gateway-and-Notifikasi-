@extends('layouts.main')

@section('content')
 <div class="card mb-6">
                    <div class="card-header">
                      <h5 class="card-title m-0">Detail Tracking Pembayaran Pendaftaran {{$person->nama}}</h5>
                    </div>
                    <div class="card-body pt-1">
                      <ul class="timeline pb-0 mb-0">

               
                               <li class="timeline-item timeline-item-transparent border-primary">
                          <span class="timeline-point timeline-point-primary"></span>
                          <div class="timeline-event">
                            <div class="timeline-header">
                              <h6 class="mb-0">Tidak ada tagihan , Pindahan sebelumnya dari kelas {{$kelas}}</h6>
                             
                            </div>
                             <div class="d-flex  flex-column">
                          </div>
                          </div>
                        </li>
                   

                     


                        
                    
                      </ul>
                    </div>
                  </div>
@endsection