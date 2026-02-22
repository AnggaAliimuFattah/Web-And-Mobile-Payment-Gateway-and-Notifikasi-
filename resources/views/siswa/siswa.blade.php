@extends('layouts.main')

@section('content')

<link rel="stylesheet" href="{{asset('assets/notiflix/dist/notiflix-3.2.7.min.css')}}" />
{{-- <link rel="stylesheet" href="{{asset('assets/css/bootstrap.min.css')}}" /> --}}
<script src="{{asset('assets/notiflix/dist/notiflix-3.2.7.min.js')}}"></script>
<link rel="stylesheet" href="{{asset('assets/vendor/libs/select2/select2.css')}}" rel="stylesheet" />

<div class="row blocking mt-5">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header d-flex">
          <h4 class="card-title">Data Siswa</h4>
          {{-- <a href="#" class="btn btn-info btn-round ms-auto" onclick="add()"><i class="fa fa-plus"></i> Tambah Data </a>&nbsp; --}}
        </div>
        <div class="card-body">
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
                          


                        </div>
                      </div>
                    </div>

                  </form>
          <div class="table-responsive">
            <table id="table" class="datatables-products table">
              <thead>
                <tr>
                  <th>No</th>
                  <th>Nama</th>
                  <th>No Telp </th>
                   <th>Nis</th>
                    <th>Tahun </th>
                  <th>Kelas </th>
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
                        <input style="display: none;" type="text" id="uuid"  name="uuid"/>
                        <input id="nama" name="nama" placeholder="" class="form-control"  type="text">
                        <span class="help-block text-danger nama_err"></span>
                      </div>
                    </div>

                      <div class="col-md-6">
                        <label class="form-label">No Telpon</label>
                        <div class="form-group form-group-default">
                            <input id="no_telp" name="no_telp" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger no_telp_err"></span>
                        </div>
                      </div> 
                      
                      <div class="col-md-6 g-4">
                        <label class="form-label">Jenis Kelamin</label>
                        <div class="form-group form-group-default">
                            <input id="jenis_kelamin" name="jenis_kelamin" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger jenis_kelamin_err"></span>
                        </div>
                      </div>  

                       <div class="col-md-6 g-4">
                        <label class="form-label">Agama</label>
                        <div class="form-group form-group-default">
                            <input type="text" id="agama" name="agama" placeholder="" class="form-control" >
                            <span class="help-block text-danger	agama_err"></span>
                        </div>
                      </div>  

                      <div class="col-md-6 g-4">
                        <label class="form-label">Tempat Lahir</label>
                        <div class="form-group form-group-default">
                            <input id="tempat_lahir" name="tempat_lahir" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger tempat_lahir_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Tanggal Lahir</label>
                        <div class="form-group form-group-default">
                            <input id="tanggal_lahir" name="tanggal_lahir" placeholder="" class="form-control"  type="date">
                            <span class="help-block text-danger tanggal_lahir_err"></span>
                        </div>
                      </div> 

                       <div class="col-md-12 g-4">
                        <label class="form-label">Alamat</label>
                        <div class="form-group form-group-default">
                           <textarea name="alamat" id="alamat" class="form-control"  rows="10" cols="50"></textarea>
                            <span class="help-block text-danger alamat_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Nama Ayah</label>
                        <div class="form-group form-group-default">
                            <input id="nama_ayah" name="nama_ayah" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger nama_ayah_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Pekerjaan Ayah</label>
                        <div class="form-group form-group-default">
                            <input id="pekerjaan_ayah" name="pekerjaan_ayah" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger pekerjaan_ayah_err"></span>
                        </div>
                      </div> 

                      <div class="col-md-6 g-4">
                        <label class="form-label">Nama Ibu</label>
                        <div class="form-group form-group-default">
                            <input id="nama_ibu" name="nama_ibu" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger nama_ibu_err"></span>
                        </div>
                      </div>

                      <div class="col-md-6 g-4">
                        <label class="form-label">Pekerjaan Ibu</label>
                        <div class="form-group form-group-default">
                            <input id="pekerjaan_ibu" name="pekerjaan_ibu" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger pekerjaan_ibu_err"></span>
                        </div>
                      </div>

                         <div class="col-md-6 g-4">
                        <label class="form-label">Kelas</label>
                        <div class="form-group form-group-default">
                       <input type="text" id="kelas" name="kelas" placeholder="" class="form-control" >
                            <span class="help-block text-danger	kelas_err"></span>
                        </div>
                      </div> 
                      
                               <div class="col-md-6 g-4">
                        <label class="form-label">Tahun</label>
                        <div class="form-group form-group-default">
                            <input id="tahun" name="tahun" placeholder="" class="form-control"  type="text">
                            <span class="help-block text-danger tahun_err"></span>
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
  <script src="{{asset('assets/vendor/libs/select2/select2.js')}}"></script>

  <script>
var table;
  var save_method;
    var tahun = $('#tahun').val();
    var kelas = $('#kelas').val()
 $(document).ready(function () {
   table =  $('#table').DataTable ({
   processing: true,
   serverSide: true,
   ajax: { 
     url: "/data-siswa",
 type:"POST",
data: function (d) {
                // Menambahkan data t_awal dan t_akhir ke request
                d._token = "{{ csrf_token() }}"; // Menyertakan token CSRF
                d.tahun = $('#tahun').val(); // Ambil nilai dari input tanggal akhir
                d.kelas = $('#kelas').val();
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
 

 $('#tahun').on('change', function() {
    reload_table(); // Memuat ulang DataTables saat input tanggal berubah
  });

  $('#kelas').on('change', function() {
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



//       $("#nama").select2({
//         width: '100%',
//     dropdownParent: $("#modal_form"),
//     ajax: {
//         url: '/ajax-list-data-siswa',
//         dataType: 'json',
//         delay: 250,
//         data: function (params) {
//             return {
//                 q: params.term // gunakan params.term untuk search term
//             };
//         },
//         processResults: function (data) { // ganti results dengan processResults
//             return {
//                 results: $.map(data, function (item) {
//                     return {
//                         text: item.nama + ' # ' + item.nis,
//                         id: item.id
//                     };
//                 })
//             };
//         },
//         cache: true
//     }
// });

$('#nama').on('change', function() {
        $.ajax({
            url: '/ajax-change-data-siswa/' + $(this).val(),
            type: 'GET',
            dataType: 'json',
        })
        .done(function(data) {
        //   $('#form')[0].reset();

            $("#uuid").val(data.uuid);
            $("#no_telp").val(data.no_telp);
            $("#agama").val(data.agama);
            $("#jenis_kelamin").val(data.jenis_kelamin);
            $("#kelas").val(data.kelas);
            $("#alamat").text(data.alamat);
            $("#tempat_lahir").val(data.tempat_lahir);
            $("#tanggal_lahir").val(data.tanggal_lahir);
            $("#nama_ayah").val(data.nama_ayah);
            $("#nama_ibu").val(data.nama_ibu);
            $("#pekerjaan_ayah").val(data.pekerjaan_ayah);
            $("#pekerjaan_ibu").val(data.pekerjaan_ibu);
          
        })
        .fail(function() {
            console.log("error");
        })
        .always(function() {
            console.log("complete");
        });

      
    });


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
     
      var url;
   
      if(save_method == 'add') {
          url = "/insert-data-siswa";
      }  
      else {
          url = "/edit-data-siswa";
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
              $('#btnSave').attr('',false); //set button enable 
   
   
          },
          error: function (jqXHR, textStatus, errorThrown)
          {
            
            Notiflix.Block.remove('.blocking');
            Notiflix.Notify.failure('Data gagal diinput');
            
             printErrorMsg(jqXHR.responseJSON.errors);
              $('#btnSave').text('Simpan'); //change button text
              $('#btnSave').attr('',false); //set button enable 
   
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
          url : "/ajax-data-siswa/" + uuid,
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
                   $('[name="tahun"]').val(data.tahun);
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
          url : "/ajax-data-siswa/" + uuid,
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
                  $('[name="tahun"]').val(data.tahun);
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


  function hapus(uuid) {
    // Menampilkan konfirmasi menggunakan Notiflix
    Notiflix.Confirm.show(
        'Hapus',
        'Anda yakin ingin menghapus data ini ?',
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
                url: "/delete-data-siswa/" + uuid,  // ID diteruskan sebagai bagian dari URL
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