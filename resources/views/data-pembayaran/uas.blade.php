@extends('layouts.main')

@section('content')

<link rel="stylesheet" href="{{asset('assets/notiflix/dist/notiflix-3.2.7.min.css')}}" />
{{-- <link rel="stylesheet" href="{{asset('assets/css/bootstrap.min.css')}}" /> --}}
<script src="{{asset('assets/notiflix/dist/notiflix-3.2.7.min.js')}}"></script>

<div class="row blocking mt-5">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header d-flex">
          <h4 class="card-title">Data Siswa Bayar UAS</h4>
          {{-- <a href="#" class="btn btn-info btn-round ms-auto" onclick="add()"><i class="fa fa-plus"></i> Tambah Data Pendaftaran</a>&nbsp; --}}
        </div>
        <div class="card-body">
          <div class="table-responsive">
   <form class="dt_adv_search" method="POST" id="bulk_send">
                    <div class="row">
                      <div class="col-12">
                        <div class="row g-3">
                            @csrf
                         
                         <div class="col-6 col-sm-6 col-lg-4">
                            <label class="form-label">Tahun:</label>
                            <div class="mb-0">
                              <select name="tahun" class="form-control dt-input" id="tahun">
                                 @for ($tahun = 2025; $tahun <= $tahunSekarang + 2; $tahun++)
                                    <option value="{{ $tahun }}" {{ $tahun == $tahunSekarang ? 'selected' : '' }}>
                                        {{ $tahun }}
                                    </option>
                                 @endfor
                            </select>
                            </div>
                          </div> 
                         
                          
                          <div class="col-6 col-sm-6 col-lg-4">
                            <label class="form-label">Kelas:</label>
                            <select name="kelas" class="form-control dt-input" id="kelas">
                                <option value="X">X</option>
                                <option value="XI">XI</option>
                                <option value="XII">XII</option>
                            </select>
                          </div>
                          
                             <div class="col-6 col-sm-6 col-lg-4">
                            <label class="form-label">Status:</label>
                            <select name="status" class="form-control dt-input" id="status">
                                <option value="Belum Lunas">Belum Lunas</option>
                                <option value="Lunas">Lunas</option>

                            </select>
                          </div>

                        </div>
                      </div>
                    </div>
                    
                                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Kirim Text (Opsional)</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="col-12 col-sm-12 col-lg-12">
                            <label class="form-label">Pesan:</label>
                            <textarea class="form-control dt-input" name="mess" id="mess"></textarea>
                          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
         <a class="text-white btn btn-info" onclick="sender()">Send Notif All</a>
      </div>
    </div>
  </div>
</div>
                  </form>
                  
                                             <button type="button" class="mt-3 text-white btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
Kirim Pesan Semua
</button>
            <table id="table" class="datatables-products table">
              <thead>
                <tr>
                  <th>No</th>
                  <th>Nama</th>
                  <th>No Telp </th>
                    <th>Nis</th>
                  <th>Tahun </th>
                  <th>Alamat </th>
                  <th>Status</th>
                  <th>Aksi</th>
                </tr>
              </thead>
              <tbody>
                <tr>      
                  
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap modal -->
  <div class="modal fade" id="modal_form" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
      <div class="modal-content">
          <div class="modal-header">
              <h3 class="modal-title">header</h3>
          </div>
          <div class="modal-body form">
            <div class="modal-body">

              <form id="form">
                @csrf
                  <div class="row">
                    
                    <div class="col-md-6">
                      <label class="form-label">Nama</label>
                      <div class="form-group form-group-default">
                        <input style="display: none;" type="text"  name="uuid"/>
                        <input id="nama" name="nama" placeholder="" class="form-control" type="text">
                        <span class="help-block text-danger nama_err"></span>
                      </div>
                    </div>

                      <div class="col-md-6">
                        <label class="form-label">No Telpon</label>
                        <div class="form-group form-group-default">
                            <input id="no_telp" name="no_telp" placeholder="" class="form-control" type="number">
                            <span class="help-block text-danger no_telp_err"></span>
                        </div>
                      </div> 
                      
                      <div class="col-md-6 g-4">
                        <label class="form-label">Jenis Kelamin</label>
                        <div class="form-group form-group-default">
                            <select name="jenis_kelamin" id="jenis_kelamin" class="form-control">
                                <option value="" selected>-- Pilih --</option>
                                <option value="Laki-laki">Laki-laki</option>
                                <option value="Perempuan">Perempuan</option>
                            </select>
                            <span class="help-block text-danger jenis_kelamin_err"></span>
                        </div>
                      </div>  

                       <div class="col-md-6 g-4">
                        <label class="form-label">Agama</label>
                        <div class="form-group form-group-default">
                            <select name="agama" id="	agama" class="form-control">
                                <option value="" selected>-- Pilih --</option>
                                <option value="Islam">Islam</option>
                                <option value="Kristen">Kristen</option>
                                <option value="Katolik">Katolik</option>
                                <option value="Hindu">Hindu</option>
                                <option value="Budha">Budha</option>
                            </select>
                            <span class="help-block text-danger	agama_err"></span>
                        </div>
                      </div>  

                      <div class="col-md-6 g-4">
                        <label class="form-label">Tempat Lahir</label>
                        <div class="form-group form-group-default">
                            <input id="tempat_lahir" name="tempat_lahir" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger tempat_lahir_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Tanggal Lahir</label>
                        <div class="form-group form-group-default">
                            <input id="tanggal_lahir" name="tanggal_lahir" placeholder="" class="form-control" type="date">
                            <span class="help-block text-danger tanggal_lahir_err"></span>
                        </div>
                      </div> 

                       <div class="col-md-12 g-4">
                        <label class="form-label">Alamat</label>
                        <div class="form-group form-group-default">
                           <textarea name="alamat" id="alamat" class="form-control" rows="10" cols="50"></textarea>
                            <span class="help-block text-danger alamat_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Nama Ayah</label>
                        <div class="form-group form-group-default">
                            <input id="nama_ayah" name="nama_ayah" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger nama_ayah_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Pekerjaan Ayah</label>
                        <div class="form-group form-group-default">
                            <input id="pekerjaan_ayah" name="pekerjaan_ayah" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger pekerjaan_ayah_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Nama Ibu</label>
                        <div class="form-group form-group-default">
                            <input id="nama_ibu" name="nama_ibu" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger nama_ibu_err"></span>
                        </div>
                      </div>

                      <div class="col-md-6 g-4">
                        <label class="form-label">Pekerjaan Ibu</label>
                        <div class="form-group form-group-default">
                            <input id="pekerjaan_ibu" name="pekerjaan_ibu" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger pekerjaan_ibu_err"></span>
                        </div>
                      </div>

                         <div class="col-md-6 g-4">
                        <label class="form-label">Kelas</label>
                        <div class="form-group form-group-default">
                            <select name="kelas" id="	kelas" class="form-control">
                                <option value="" selected>-- Pilih --</option>
                                <option value="X">X</option>
                                <option value="XI">XI</option>
                                <option value="XII">XII</option>
                            </select>
                            <span class="help-block text-danger	kelas_err"></span>
                        </div>
                      </div> 
                      
                      <div class="col-md-6 g-4">
                        <label class="form-label">Tahun Ajaran / Periode</label>
                        <div class="form-group form-group-default">
                            <select name="periode" id="	periode" class="form-control">
                                <option value="" selected>-- Pilih --</option>
                                @php
                                  $thn = 2024;
                                  $jum = $thn + 1;
                                  $now = date('Y');
                                @endphp

                                @for ($i = $thn; $i <= $now; $i++)
                                  <option value="{{  $i .'/'. $i + 1 }}">{{ $i .'/'. $i + 1 }}</option>
                                @endfor
                               
                            </select>
                            <span class="help-block text-danger	periode_err"></span>
                        </div>
                      </div>  

                          <div class="col-md-12 g-4">
                                <label for="judul" class="form-label">Foto</label>
                                <input type="file" class="form-control" id="foto" name="foto" onchange="previewImage()">
                                 <span class="help-block text-danger foto_err"></span>
                                <div class="ratio ratio-16x9">
                                <iframe  alt="user-avatar" class="d-block align-items-center rounded img-preview mt-3" id="pic"></iframe>
                              </div>
                              
                            </div>


                  </div>
                </form>
            </div>
          </div>
          <div class="modal-footer">
              <button type="button" id="btnSave" onclick="save()" class="btn btn-primary">Simpan</button>
              <button type="button" onclick="btn()" class="btn btn-danger" data-dismiss="modal">Batal</button>
          </div>
      </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


  <script src="{{ asset('assets/vendor/libs/jquery/jquery.js') }}"></script>
  

  <script>

  var table;
  var save_method;
  var tahun = $('#tahun').val();
    var kelas = $('#kelas').val();
  var sts = $('#status').val();


  $(document).ready(function () {
 table =  $('#table').DataTable ({
 processing: true,
 serverSide: true,
 ajax: { 
   url: "/data-bayar-uas",
type:"POST",
data: function (d) {
                // Menambahkan data t_awal dan t_akhir ke request
                 d._token = "{{ csrf_token() }}"; // Menyertakan token CSRF
                d.kelas = $('#kelas').val();
                 d.sts = $('#status').val();
                   d.tahun = $('#tahun').val(); // Ambil nilai dari input tanggal akhir
            }
},
columnDefs: [
 {

   targets: [ -1 ], //last column
   orderable: false, //set not orderable
 }
]
});
})



  $('#kelas').on('change', function() {
    reload_table(); // Memuat ulang DataTables saat input tanggal berubah
  });

  $('#status').on('change', function() {
    reload_table(); // Memuat ulang DataTables saat input tanggal berubah
  });
  
    $('#tahun').on('change', function() {
    reload_table(); // Memuat ulang DataTables saat input tanggal berubah
  });

 function reload_table() {
  table.ajax.reload();
    };

  function printErrorMsg (msg) {
         $.each( msg, function( key, value ) {
         console.log(key);
           $('.'+key+'_err').text(value);
         });
     }



   Notiflix.Confirm.init({
className: 'notiflix-confirm',
width: '300px',
zindex: 4003,
position: 'center',
distance: '10px',
backgroundColor: '#f8f8f8',
borderRadius: '25px',
backOverlay: true,
backOverlayColor: 'rgba(0,0,0,0.5)',
rtl: false,
fontFamily: 'Quicksand',
cssAnimation: true,
cssAnimationDuration: 300,
cssAnimationStyle: 'fade',
plainText: true,
titleColor: '#DC143C',
titleFontSize: '16px',
titleMaxLength: 34,
messageColor: '#1e1e1e',
messageFontSize: '14px',
messageMaxLength: 110,
buttonsFontSize: '15px',
buttonsMaxLength: 34,
okButtonColor: '#f8f8f8',
okButtonBackground: '#DC143C',
cancelButtonColor: '#f8f8f8',
cancelButtonBackground: '#a9a9a9',
});


function add()
  {
    Notiflix.Block.hourglass('.blocking', 'Please wait...', {
      svgSize: '129px',
      position: 'absolute',
      svgColor: 'rgba(50,198,30)',
      zIndex: 9999 // Gerakkan elemen 20px ke atas
      });

      save_method = 'add';
         // $('#label-photo').text('Upload Photo'); // label photo upload
         $('#form')[0].reset(); // reset form on modals
      $('.form-group').removeClass('has-error'); // clear error class
      $('.help-block').empty(); // clear error string
      Notiflix.Block.remove('.blocking');
      $('#modal_form').modal('show'); // show bootstrap modal
      $('.modal-title').text('Tambah Data Pendafataran Siswa'); // Set Title to Bootstrap modal title
      $('#photo-preview').hide(); // hide photo preview modal
      $('#btnSave').show();   
      const imagePreview2 = document.querySelector('.img-preview').classList;
      // imagePreview2.add('d-none');
  }

  function btn()
  {
    $('#modal_form').modal('hide');
  }

  




function save()
  {
      $('#btnSave').text('Menyimpan...'); //change button text
      $('#btnSave').attr('disabled',true); //set button disable 
      var url;
   
      if(save_method == 'add') {
          url = "/insert-pendaftaran-siswa";
      }  
      else {
          url = "/edit-pendaftaran-siswa";
      }

      Notiflix.Block.hourglass('.blocking', 'Please wait...', {
      svgSize: '129px',
      position: 'absolute',
      svgColor: 'rgba(50,198,30)',
      zIndex: 9999 // Gerakkan elemen 20px ke atas
      });
   
      // ajax adding data to database
      var formData = new FormData($('#form')[0]);
      $.ajax({
           url : url,
           type: "POST",
           data: formData,
           contentType: false,
           processData: false,
           dataType: "JSON",
          success: function(data)
          {
            Notiflix.Block.remove('.blocking');
              if(data.error ) { 
                
                printErrorMsg(data.error);
                if(save_method == 'add') {
                  Notiflix.Notify.failure('Data gagal diinput');
                  reload_table();
                }else {
                  Notiflix.Notify.failure('Data gagal diubah');
                  reload_table();
                }
              }else{
               $('#modal_form').modal('hide');
               if(save_method == 'add') {
                  Notiflix.Notify.success('Data berhasil diinput');
                  reload_table();
                }else {
                  // Notiflix.Report.success(
                  // 'Data berhasil diubah',
                  // ''
                  // );
                  Notiflix.Notify.success('Data berhasil diubah');
                  reload_table();
                }
              }

              $('#btnSave').text('Simpan'); //change button text
              $('#btnSave').attr('disabled',false); //set button enable 
   
   
          },
          error: function (jqXHR, textStatus, errorThrown)
          {
            
            Notiflix.Block.remove('.blocking');
            Notiflix.Notify.failure('Data gagal diinput');
            
             printErrorMsg(jqXHR.responseJSON.errors);
              $('#btnSave').text('Simpan'); //change button text
              $('#btnSave').attr('disabled',false); //set button enable 
   
          }
      });
  }


  function detail(uuid)
  {
     
      $('#form')[0].reset(); // reset form on modals
      $('.form-group').removeClass('has-error'); // clear error class
      $('.help-block').empty(); // clear error string
      $('#btnSave').hide();

      Notiflix.Block.hourglass('.blocking', 'Please wait...', {
      svgSize: '129px',
      position: 'absolute',
      svgColor: 'rgba(50,198,30)',
      zIndex: 9999 // Gerakkan elemen 20px ke atas
      });
   
      //Ajax Load data from ajax
      $.ajax({
          url : "/ajax-data-pendaftaran-siswa/" + uuid,
          type: "GET",
          dataType: "JSON",
          
          success: function(data)
          {
                 $('[name="uuid"]').val(data.uuid);
                 $('[name="nama"]').val(data.nama);
                 $('[name="no_telp"]').val(data.no_telp);
                 $('[name="agama"]').val(data.agama);
                 $('[name="alamat"]').val(data.alamat);
                 $('[name="tempat_lahir"]').val(data.tempat_lahir);
                 $('[name="tanggal_lahir"]').val(data.tanggal_lahir);
                 $('[name="jenis_kelamin"]').val(data.jenis_kelamin);
                 $('[name="nama_ayah"]').val(data.nama_ayah);
                 $('[name="pekerjaan_ayah"]').val(data.pekerjaan_ayah);
                 $('[name="nama_ibu"]').val(data.nama_ibu);
                 $('[name="pekerjaan_ibu"]').val(data.pekerjaan_ibu);
                 $('[name="kelas"]').val(data.kelas);
                 $('.img-preview').attr('src', '/foto'+data.foto);
          
              Notiflix.Block.remove('.blocking');
              $('#modal_form').modal('show'); // show bootstrap modal when complete loaded
              $('.modal-title').text('Detail Data Pendafataran Siswa '); // Set title to Bootstrap modal title
             
            
          },
          error: function (jqXHR, textStatus, errorThrown)
          {
            Notiflix.Block.remove('.blocking');
              alert('Error get data from ajax');
          }
      });
  }


  function sender() {
    // Menampilkan konfirmasi menggunakan Notiflix
    Notiflix.Confirm.show(
        'Kirim Notifikasi',
        'Anda yakin ingin kirim notifikasi ini ?',
        'Yes',
        'No',
        function okCb() {

          Notiflix.Block.hourglass('.blocking', 'Please wait...', {
      svgSize: '129px',
      position: 'absolute',
      svgColor: 'rgba(50,198,30)',
      zIndex: 9999 // Gerakkan elemen 20px ke atas
      });
      var formData = new FormData($('#bulk_send')[0]);
            $.ajax({
                url: "/notifikasi-tunggakan-uas-all",  // ID diteruskan sebagai bagian dari URL
                type: "POST",  // Menggunakan metode GET jika itu adalah API GET
                data: formData,
                contentType: false,
                processData: false,
                success: function(data) {
                    Notiflix.Block.remove('.blocking');
                    Notiflix.Notify.success('Data berhasil dikirim');
                    reload_table();  
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // Jika terjadi error
                    Notiflix.Block.remove('.blocking');
                    Notiflix.Notify.failure('Data gagal dikirim');
                    reload_table();  // Memuat ulang data meskipun terjadi error
                }
            });
        },
        function cancelCb() {
            // Tidak ada tindakan yang dilakukan jika user membatalkan
            Notiflix.Block.remove('.blocking');
        }
    );
}

  function edit(uuid)
  {
    
    save_method = 'edit';
      $('#form')[0].reset(); // reset form on modals
      $('.form-group').removeClass('has-error'); // clear error class
      $('.help-block').empty(); // clear error string
      $('#btnSave').show();

      Notiflix.Block.hourglass('.blocking', 'Please wait...', {
      svgSize: '129px',
      position: 'absolute',
      svgColor: 'rgba(50,198,30)',
      zIndex: 9999 // Gerakkan elemen 20px ke atas
      });
   
      //Ajax Load data from ajax
      $.ajax({
          url : "/ajax-data-pendaftaran-siswa/" + uuid,
          type: "GET",
          dataType: "JSON",
          
          success: function(data)
          {
                  $('[name="uuid"]').val(data.uuid);
                 $('[name="nama"]').val(data.nama);
                 $('[name="no_telp"]').val(data.no_telp);
                 $('[name="agama"]').val(data.agama);
                 $('[name="alamat"]').val(data.alamat);
                 $('[name="tempat_lahir"]').val(data.tempat_lahir);
                 $('[name="tanggal_lahir"]').val(data.tanggal_lahir);
                 $('[name="jenis_kelamin"]').val(data.jenis_kelamin);
                 $('[name="nama_ayah"]').val(data.nama_ayah);
                 $('[name="pekerjaan_ayah"]').val(data.pekerjaan_ayah);
                 $('[name="nama_ibu"]').val(data.nama_ibu);
                 $('[name="pekerjaan_ibu"]').val(data.pekerjaan_ibu);
                 $('[name="kelas"]').val(data.kelas);
                 $('.img-preview').attr('src', '/foto'+data.foto);
          
              Notiflix.Block.remove('.blocking');
              $('#modal_form').modal('show'); // show bootstrap modal when complete loaded
              $('.modal-title').text('Edit Data Pendafataran Siswa '); // Set title to Bootstrap modal title
             
            
          },
          error: function (jqXHR, textStatus, errorThrown)
          {
            Notiflix.Block.remove('.blocking');
              alert('Error get data from ajax');
          }
      });
  }


  function notif(uuid,kelas) {
    // Menampilkan konfirmasi menggunakan Notiflix
    Notiflix.Confirm.show(
        'Kirim Notifikasi',
        'Anda yakin ingin kirim notifikasi ini ?',
        'Yes',
        'No',
        function okCb() {

          Notiflix.Block.hourglass('.blocking', 'Please wait...', {
      svgSize: '129px',
      position: 'absolute',
      svgColor: 'rgba(50,198,30)',
      zIndex: 9999 // Gerakkan elemen 20px ke atas
      });

            // Melakukan request AJAX ke server untuk menghapus data
            $.ajax({
                url: "/notifikasi-tunggakan-uas/" + uuid  + '/' + kelas,  // ID diteruskan sebagai bagian dari URL
                type: "GET",  // Menggunakan metode GET jika itu adalah API GET
                dataType: "JSON",  // Menyatakan bahwa kita mengharapkan response JSON
                data: {
                    _token: "{{ csrf_token() }}"  // Mengirimkan CSRF token untuk validasi
                },
                success: function(data) {
                    // Jika berhasil menghapus data
                    Notiflix.Block.remove('.blocking');
                    Notiflix.Notify.success('Data berhasil dihapus');
                    reload_table();  // Memuat ulang data setelah penghapusan
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // Jika terjadi error
                    Notiflix.Block.remove('.blocking');
                    Notiflix.Notify.failure('Data gagal dihapus');
                    reload_table();  // Memuat ulang data meskipun terjadi error
                }
            });
        },
        function cancelCb() {
            // Tidak ada tindakan yang dilakukan jika user membatalkan
            Notiflix.Block.remove('.blocking');
        }
    );
}


 function previewImage(){
 const image = document.querySelector('#foto');
 const imagePreview = document.querySelector('#pic');

 imagePreview.style.display = 'block';

 const oFReader = new FileReader();
 oFReader.readAsDataURL(image.files[0]);

 oFReader.onload = function(oFREvent) {
     imagePreview.src = oFREvent.target.result;
 }
}

  </script>

  
    

@endsection