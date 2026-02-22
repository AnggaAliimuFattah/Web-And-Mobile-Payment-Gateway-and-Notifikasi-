 <aside id="layout-menu" class="layout-menu menu-vertical menu">
          <div class="app-brand demo">
            <a href="index.html" class="app-brand-link">
              <span class="app-brand-logo demo">
                <span class="text-primary">
            <img src="{{ asset('assets/img/branding/Logo.png') }}" alt="" width="205">
                </span>
              </span>
              {{-- <span class="app-brand-text demo menu-text fw-bold ms-3">Vuexy</span> --}}
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto">
              <i class="icon-base ti menu-toggle-icon d-none d-xl-block"></i>
              <i class="icon-base ti tabler-x d-block d-xl-none"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
         

          

            <!-- Apps & Pages -->

            <li class="menu-item {{ request()->is('dashboard*') ? 'active' : '' }}">
              <a href="/dashboard" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-smart-home"></i>
                <div data-i18n="Dashboard">Dashboard</div>
              </a>
            </li>

            
              <li class="menu-header small">
              <span class="menu-header-text" data-i18n="Master Data">Master Data</span>
            </li>

            <li class="menu-item {{ request()->is('pendaftaran-siswa*') ? 'active' : '' }}">
              <a href="/pendaftaran-siswa" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-clipboard-list"></i>
                <div data-i18n="Pendaftaran Siswa">Pendaftaran Siswa</div>
              </a>
            </li>

         <li class="menu-item {{ request()->is('data-siswa*') ? 'active' : '' }}">
              <a href="/data-siswa" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-user-square"></i>
                <div data-i18n="Data Siswa">Data Siswa</div>
              </a>
            </li>

              <li class="menu-item {{ request()->is('jenis-pembayaran*') ? 'active' : '' }}">
              <a href="/jenis-pembayaran" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-cash-register"></i>
                <div data-i18n="Jenis Pembayaran">Jenis Pembayaran</div>
              </a>
            </li>

            <li class="menu-header small">
              <span class="menu-header-text" data-i18n="Data Pembayaran">Data Pembayaran</span>
            </li>

           <li class="menu-item {{ request()->is('data-bayar-pendaftaran*') ? 'active' : '' }}
                                {{ request()->is('detail-pembayaran-pendaftaran*') ? 'active' : '' }}">
              <a href="/data-bayar-pendaftaran" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-report-money"></i>
                <div>Data Pembayaran <br> Pendaftaran</div>
              </a>
            </li>

            <li class="menu-item {{ request()->is('data-bayar-spp*') ? 'active' : '' }}
                                 {{ request()->is('detail-pembayaran-spp*') ? 'active' : '' }}">
              <a href="/data-bayar-spp" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-receipt"></i>
                <div>Data Pembayaran <br>  Spp Siswa</div>
              </a>
            </li>

                <li class="menu-item {{ request()->is('data-bayar-uts*') ? 'active' : '' }}
                                     {{ request()->is('detail-pembayaran-uts*') ? 'active' : '' }}">
              <a href="/data-bayar-uts" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-receipt-dollar"></i>
                <div data-i18n="Data Pembayaran UTS">Data Pembayaran UTS</div>
              </a>
            </li>

                <li class="menu-item {{ request()->is('data-bayar-uas*') ? 'active' : '' }}
                                     {{ request()->is('detail-pembayaran-uas*') ? 'active' : '' }}">
              <a href="/data-bayar-uas" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-receipt-2"></i>
                <div data-i18n="Data Pembayaran UAS">Data Pembayaran UAS</div>
              </a>
            </li>

          
              <li class="menu-header small">
              <span class="menu-header-text" data-i18n="Notif WA">Notif WA</span>
            </li>

            
             <li class="menu-item {{ request()->is('notifikasi*') ? 'active' : '' }}">
              <a href="/notifikasi" class="menu-link">
                 <i class="menu-icon icon-base ti tabler-brand-whatsapp"></i>
                <div data-i18n="Notifikasi WA">Notifikasi WA</div>
              </a>
            </li>



          
            <li class="menu-item">
    <a href="#" class="menu-link" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
        <i class="menu-icon icon-base ti tabler-logout-2"></i>
        <div data-i18n="Logout">Logout</div>
    </a>

    <form id="logout-form" action="/logout" method="POST" style="display: none;">
        @csrf
    </form>
</li>

       
          
          </ul>
        </aside>