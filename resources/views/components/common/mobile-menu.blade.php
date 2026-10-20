<!-- Mobile Menu -->
<div class="offcanvas offcanvas-end mobile-nav-container" tabindex="-1" id="mobileMenu">
  <div class="offcanvas-header">
    <div class="logo-container">
      <picture>
        <img src="{{ $favIcon?->largeUrl ?? asset('images/logo.png') }}" alt="Logo"
             class="mobile-nav-logo default-image-class aspect-ratio-16-9">
      </picture>
    </div>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
  </div>

  <div class="offcanvas-body p-0 d-flex flex-column">
    <div class="flex-grow-1">
        
    @if (isset($menuParents) && $menuParents)
      <div class="accordion accordion-flush" id="accordionMobile">
        @foreach ($menuParents as $parent)
          <div class="accordion-item">
            <h2 class="accordion-header">
              <a class="accordion-button collapsed mobile-main-link border-bottom"
                 href="{{ url($lng . $parent->link) }}">
                {{ $parent->title }}
                @if(count($parent->childs))
                  <i class="fas fa-chevron-down"
                     data-bs-toggle="collapse"
                     data-bs-target="#collapseParent{{ $parent->id }}"
                     aria-expanded="false"
                     aria-controls="collapseParent{{ $parent->id }}">
                  </i>
                @endif
              </a>
            </h2>

            @if(count($parent->childs))
              <div id="collapseParent{{ $parent->id }}" class="accordion-collapse collapse"
                   data-bs-parent="#accordionMobile">
                <div class="accordion-body">
                  @foreach ($parent->childs as $child)
                    <a href="{{ url($lng . $child->link) }}" class="mobile-nav-link">
                      {{ $child->title }}
                    </a>
                  @endforeach
                </div>
              </div>
            @endif
          </div>
        @endforeach
      </div>
    @endif
    </div>

    <!-- Footer with Social Icons -->
    <div class="offcanvas-footer">
      <div class="social-icons">
        <a href="#" class="social-icon"><i class="fa-brands fa-facebook-f"></i></a>
        <a href="#" class="social-icon"><i class="fa-brands fa-x-twitter"></i></a>
        <a href="#" class="social-icon"><i class="fa-brands fa-linkedin"></i></a>
        <a href="#" class="social-icon"><i class="fa-brands fa-instagram"></i></a>
      </div>
    </div>
  </div>
</div>
