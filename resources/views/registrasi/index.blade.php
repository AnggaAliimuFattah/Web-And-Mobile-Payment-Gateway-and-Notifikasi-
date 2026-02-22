





  
    
<!doctype html>

<html
  lang="en"
  class="layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-skin="default"
  data-assets-path="{{asset('assets/')}}"
  data-template="vertical-menu-template"
  data-bs-theme="light">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>Admin</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="{{ asset('assets/img/branding/Logo.png') }}" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
      rel="stylesheet" />

    <link rel="stylesheet" href="{{asset('assets/vendor/fonts/iconify-icons.css')}}" />

    <!-- Core CSS -->
    <!-- build:css assets/vendor/css/theme.css  -->

    <link rel="stylesheet" href="{{asset('assets/vendor/libs/node-waves/node-waves.css')}}" />

    <link rel="stylesheet" href="{{asset('assets/vendor/libs/pickr/pickr-themes.css')}}" />

    <link rel="stylesheet" href="{{asset('assets/vendor/css/core.css')}}" />
    <link rel="stylesheet" href="{{asset('assets/css/demo.css')}}" />

    <!-- Vendors CSS -->

    <link rel="stylesheet" href="{{asset('assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css')}}" />

    <!-- endbuild -->

    <link rel="stylesheet" href="{{asset('assets/vendor/libs/apex-charts/apex-charts.css')}}" />
    <link rel="stylesheet" href="{{asset('assets/vendor/libs/swiper/swiper.css')}}" />
    <link rel="stylesheet" href="{{asset('assets/vendor/libs/datatables-bs5/datatables.bootstrap5.css')}}" />
    <link rel="stylesheet" href="{{asset('assets/vendor/libs/datatables-responsive-bs5/responsive.bootstrap5.css')}}" />
    <link rel="stylesheet" href="{{asset('assets/vendor/fonts/flag-icons.css')}}" />

    <!-- Page CSS -->
    <link rel="stylesheet" href="{{asset('assets/vendor/css/pages/cards-advance.css')}}" />

    <!-- Helpers -->
    <script src="{{asset('assets/vendor/js/helpers.js')}}"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->

    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->

    <script src="{{asset('assets/js/config.js')}}"></script>
  </head>

  <body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->

       
        <div class="menu-mobile-toggler d-xl-none rounded-1">
          <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large text-bg-secondary p-2 rounded-1">
            <i class="ti tabler-menu icon-base"></i>
            <i class="ti tabler-chevron-right icon-base"></i>
          </a>
        </div>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="l">
          <!-- Navbar -->

      

          <!-- / Navbar -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row g-6">

                
<div class="row blocking mt-5">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header d-flex">
          <h4 class="card-title"> Pendaftaran Siswa</h4>
        
        </div>
        <div class="card-body">
      

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
          <div class="modal-footer">
              <button type="button" id="btnSave" onclick="save()" class="btn btn-primary">Simpan</button>
              <button type="button" onclick="btn()" class="btn btn-danger" data-dismiss="modal">Batal</button>
          </div>
        </div>
      </div>
    </div>
  </div>
            

               

             
                <!--/ Projects table -->
              </div>
            </div>
            <!-- / Content -->

            <!-- Footer -->
       
  <script src="{{ asset('assets/vendor/libs/jquery/jquery.js') }}"></script>
  

  <script>


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
          url = "/update-pendaftaran-siswa";
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
                url: "/delete-pendaftaran-siswa/" + uuid,  // ID diteruskan sebagai bagian dari URL
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
