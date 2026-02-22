@extends('landing-page.layouts.main')

@section('content')

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

<div class="container mt-5">
    <div class="card">
        <div class="card-header">
            <h4 class="card-title">Pendaftaran Siswa</h4>
        </div>
        <div class="card-body">
            <form id="form" enctype="multipart/form-data">
                @csrf
                <input type="hidden" name="uuid" />

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nama</label>
                        <input id="nama" name="nama" class="form-control" type="text">
                        <span class="help-block text-danger nama_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">No Telepon</label>
                        <input id="no_telp" name="no_telp" class="form-control" type="number">
                        <span class="help-block text-danger no_telp_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Jenis Kelamin</label>
                        <select name="jenis_kelamin" id="jenis_kelamin" class="form-control">
                            <option value="">-- Pilih --</option>
                            <option value="Laki-laki">Laki-laki</option>
                            <option value="Perempuan">Perempuan</option>
                        </select>
                        <span class="help-block text-danger jenis_kelamin_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Agama</label>
                        <select name="agama" id="agama" class="form-control">
                            <option value="">-- Pilih --</option>
                            <option value="Islam">Islam</option>
                            <option value="Kristen">Kristen</option>
                            <option value="Katolik">Katolik</option>
                            <option value="Hindu">Hindu</option>
                            <option value="Budha">Budha</option>
                        </select>
                        <span class="help-block text-danger agama_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tempat Lahir</label>
                        <input id="tempat_lahir" name="tempat_lahir" class="form-control" type="text">
                        <span class="help-block text-danger tempat_lahir_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tanggal Lahir</label>
                        <input id="tanggal_lahir" name="tanggal_lahir" class="form-control" type="date">
                        <span class="help-block text-danger tanggal_lahir_err"></span>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">Alamat</label>
                        <textarea name="alamat" id="alamat" class="form-control" rows="4"></textarea>
                        <span class="help-block text-danger alamat_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nama Ayah</label>
                        <input id="nama_ayah" name="nama_ayah" class="form-control" type="text">
                        <span class="help-block text-danger nama_ayah_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Pekerjaan Ayah</label>
                        <input id="pekerjaan_ayah" name="pekerjaan_ayah" class="form-control" type="text">
                        <span class="help-block text-danger pekerjaan_ayah_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nama Ibu</label>
                        <input id="nama_ibu" name="nama_ibu" class="form-control" type="text">
                        <span class="help-block text-danger nama_ibu_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Pekerjaan Ibu</label>
                        <input id="pekerjaan_ibu" name="pekerjaan_ibu" class="form-control" type="text">
                        <span class="help-block text-danger pekerjaan_ibu_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Kelas</label>
                        <select name="kelas" id="kelas" class="form-control">
                            <option value="">-- Pilih --</option>
                            <option value="X">X</option>
                            <option value="XI">XI</option>
                            <option value="XII">XII</option>
                        </select>
                        <span class="help-block text-danger kelas_err"></span>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tahun Ajaran / Periode</label>
                        <select name="periode" id="periode" class="form-control">
                            <option value="">-- Pilih --</option>
                            @php
                                $thn = 2024;
                                $jum = $thn + 1;
                                $now = date('Y');
                            @endphp
                            @for ($i = $thn; $i <= $now; $i++)
                                <option value="{{ $i .'/'. ($i + 1) }}">{{ $i .'/'. ($i + 1) }}</option>
                            @endfor
                        </select>
                        <span class="help-block text-danger periode_err"></span>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">Foto</label>
                        <input type="file" class="form-control" id="foto" name="foto" onchange="previewImage()">
                        <span class="help-block text-danger foto_err"></span>
                        <div class="ratio ratio-16x9 mt-3">
                            <iframe class="d-block rounded img-preview" id="pic" style="display: none;"></iframe>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="card-footer text-end">
            <button type="button" id="btnSave" onclick="save()" class="btn btn-primary">Simpan</button>
            <button type="button" onclick="btn()" class="btn btn-danger">Batal</button>
        </div>
    </div>
</div>

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
      var url = "/insert-pendaftaran-siswa";
   

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
                 Notiflix.Report.failure(
                 'Error',
                 'Data gagal diinput',
                 'Okay',
                );
              }else{
                            Notiflix.Report.success(
                'Berhasil',
                'Data berhasil diinput',
                'Okay',
              function() {
        window.location.href = ''; // Ganti dengan URL tujuan kamu
    }
);
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