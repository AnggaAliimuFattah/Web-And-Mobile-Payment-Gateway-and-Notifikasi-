@extends('layouts.main')

@section('content')

<link rel="stylesheet" href="{{asset('assets/notiflix/dist/notiflix-3.2.7.min.css')}}" />
{{-- <link rel="stylesheet" href="{{asset('assets/css/bootstrap.min.css')}}" /> --}}
<script src="{{asset('assets/notiflix/dist/notiflix-3.2.7.min.js')}}"></script>

<div class="row blocking mt-5">
    <div class="col-md-12">
      <div class="card">
        <div class="card-header d-flex">
          <h4 class="card-title">Data Jenis Pembayaran</h4>
          {{-- <a href="#" class="btn btn-info btn-round ms-auto" onclick="add()"><i class="fa fa-plus"></i> Tambah Data Jenis Pembayaran</a>&nbsp; --}}
        </div>
        <div class="card-body">
          <div class="table-responsive">
            <table id="table" class="datatables-products table">
              <thead>
                <tr>
                  <th>No</th>
                  <th>Jenis</th>
                  <th>Keterangan </th>
                  <th>Nominal</th>
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
                      <label class="form-label">Jenis Pembayaran</label>
                      <div class="form-group form-group-default">
                        <input style="display: none;" type="text"  name="uuid"/>
                        <select id="jenis" name="jenis" class="form-control">
                          <option value="">-- Pilih --</option>
                              @foreach ($semua_jenis as $jenis)
                                   @if (!in_array($jenis, $pembayaran_terdaftar))
                          <option value="{{ $jenis }}">{{ $jenis }}</option>
                                    @endif
                              @endforeach
                          </select>
                        <span class="help-block text-danger jenis_err"></span>
                      </div>
                    </div>

                      <div class="col-md-6">
                        <label class="form-label">Keterangan</label>
                        <div class="form-group form-group-default">
                            <input id="keterangan" name="keterangan" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger keterangan_err"></span>
                        </div>
                      </div> 
                      

                      <div class="col-md-6 g-4">
                        <label class="form-label">Nominal</label>
                        <div class="form-group form-group-default">
                            <input id="nominal" name="nominal" placeholder="" class="form-control" type="text">
                            <span class="help-block text-danger nominal_err"></span>
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
     var nominal = document.getElementById('nominal');
    nominal.addEventListener('keyup', function(e){
    nominal.value = formatRupiah(this.value);
    });
    

var table;
  var save_method;
 $(document).ready(function () {
   table =  $('#table').DataTable ({
   processing: true,
   serverSide: true,
   ajax: { 
     url: "/jenis-pembayaran",
 type:"POST",
 data: {
   "_token" : "{{csrf_token()}}"
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
      $('.modal-title').text('Tambah Data Jenis Pembayaran'); // Set Title to Bootstrap modal title
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
          url = "/insert-jenis-pembayaran";
      }  
      else {
          url = "/edit-data-jenis-pembayaran";
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
          url : "/ajax-data-jenis-pembayaran/" + uuid,
          type: "GET",
          dataType: "JSON",
          
          success: function(data)
          {
                 $('[name="uuid"]').val(data.uuid);
                 $('[name="jenis"]').val(data.jenis);
                 $('[name="keterangan"]').val(data.keterangan);
                 $('[name="nominal"]').val(data.nominal);

          
              Notiflix.Block.remove('.blocking');
              $('#modal_form').modal('show'); // show bootstrap modal when complete loaded
              $('.modal-title').text('Detail Data Jenis Pembayaran '); // Set title to Bootstrap modal title
             
            
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
          url : "/ajax-data-jenis-pembayaran/" + uuid,
          type: "GET",
          dataType: "JSON",
          
          success: function(data)
          {
                 $('[name="uuid"]').val(data.uuid);
                $('[name="jenis"]').val(data.jenis).prop('disabled', true);
                $('[name="keterangan"]').val(data.keterangan).prop('disabled', true);
                 $('[name="nominal"]').val(data.nominal);
          
              Notiflix.Block.remove('.blocking');
              $('#modal_form').modal('show'); // show bootstrap modal when complete loaded
              $('.modal-title').text('Edit Data Jenis Pembayaran '); // Set title to Bootstrap modal title
             
            
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
                url: "/delete-jenis-pembayaran/" + uuid,  // ID diteruskan sebagai bagian dari URL
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

  
    
    /* Dengan Rupiah */

    function formatRupiah(angka, prefix)
    {
        var number_string = angka.replace(/[^,\d]/g, '').toString(),
            split    = number_string.split(','),
            sisa     = split[0].length % 3,
            rupiah     = split[0].substr(0, sisa),
            ribuan     = split[0].substr(sisa).match(/\d{3}/gi);
            
        if (ribuan) {
            separator = sisa ? '.' : '';
            rupiah += separator + ribuan.join('.');
        }
        
        rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
        return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
    }



  </script>

  
    

@endsection