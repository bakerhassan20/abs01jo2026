

@if($originalUrl)
  @if($withAnchor)
    <a class="anchor-none" {!! Utility::printAllUrl( $url ) !!} >
  @endif
      <picture class="{{ $pictureClass }}">
        @if($webpUrl)
          <source type="image/webp" srcset="{{ asset($webpUrl) }}" rel="prefetch" width="{{ $webpWidht }}" height="{{ $webpHeight }}" media="(min-width:992px)">
        @endif

        @if($tabletWebpUrl)
          <source type="image/webp" srcset="{{ asset($tabletWebpUrl) }}" rel="prefetch" width="{{ $tabletWebpWidht }}" height="{{ $tabletWebpHeight }}" media="(min-width:575px)">
        @endif

        @if($mobileWebpUrl)
          <source type="image/webp" srcset="{{ asset($mobileWebpUrl) }}" rel="prefetch" width="{{ $mobileWebpWidht }}" height="{{ $mobileWebpHeight }}" media="(min-width:1px)">
        @endif

        <img class="{{ $imgClass }}" src="{{ asset($originalUrl) }}" alt="{{ $alt }}" rel="prefetch" loading="lazy" width="{{ $originalWidht }}" height="{{ $originalHeight }}" id="{{ $imageID }}">

        @if($overlay)
          <div class="overlay" data-src="{{ asset($originalUrl) }}" data-fancybox="gallery" > + {{ $counter }} </div>
        @endif
      </picture>

      @if($withIcon)
        <div class="nav-icon">
            <span class="nav-icon-border">
                <i class="far fa-circle-play nav-icon-white"></i>
            </span>
        </div>
      @endif

      @if($cameraIcon)
        <div class="camera-icon">
            <span class="camera-icon-border">
              @if($counter)
                <span> {{ $counter }} </span>
              @endif
              <i class="fa-regular fa-circle-play"></i>
            </span>
        </div>
      @endif
      @if($dynamicIcon)
      <div class="camera-icon">
          <span class="camera-icon-border">
            @if($counter)
              <span> {{ $counter }} </span>
            @endif
            <i class="fa-regular {{ $dynamicIcon }}"></i>
          </span>
      </div>
    @endif
      @if($photoIcon)
        <div class="photo-icon">
            <span class="photo-icon-border">
              @if($counter)
                <span> {{ $counter }} </span>
              @endif
              <x-common.webp-image imagePath="{{ asset('/images/album-icon.svg') }}" alt='{{ __("site.album-icon.svg")}}'  withAnchor="{{false}}"  allowWebp="{{true}}" />

            </span>
        </div>
      @endif

  @if($withAnchor)
    </a>
  @endif
@else
  @if($withAnchor)
    <a class="anchor-none" {!! Utility::printAllUrl( $url ) !!} >
  @endif
    <picture class="{{ $pictureClass }}">
      <img class="{{ $imgClass }}" src="" alt="{{ $alt }}" rel="prefetch" loading="lazy">
    </picture>
    @if($withIcon)
        <div class="nav-icon">
            <span class="nav-icon-border">
                <i class="far fa-circle-play nav-icon-white"></i>
            </span>
        </div>
    @endif

    @if($cameraIcon)
      <div class="camera-icon">
          <span class="camera-icon-border">
            @if($counter)
              <span> {{ $counter }} </span>
            @endif
            <i class="fa-regular fa-circle-play"></i>
          </span>
      </div>
    @endif

    @if($dynamicIcon)
      <div class="camera-icon">
          <span class="camera-icon-border">
            @if($counter)
              <span> {{ $counter }} </span>
            @endif
            <i class="fa-regular {{ $dynamicIcon }}"></i>
          </span>
      </div>
    @endif
    @if($photoIcon)
      <div class="photo-icon">
          <span class="photo-icon-border">
            @if($counter)
              <span> {{ $counter }} </span>
            @endif
            <x-common.webp-image imagePath="{{ asset('/images/album-icon.svg') }}" alt='{{ __("site.album-icon.svg")}}'  withAnchor="{{false}}"  allowWebp="{{true}}" />
          </span>
      </div>
    @endif

  @if($withAnchor)
    </a>
  @endif
@endif
