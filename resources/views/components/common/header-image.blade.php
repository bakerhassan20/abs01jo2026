@if ($image)
    <!-- Start Header Image -->
    <section class="header-image-section without-header-image">
        <div class="header-image-container position-relative">
            <picture>
                <img src="{{ $image->url }}" alt="" class="default-image-class" />
            </picture>
        </div>
        <div class="container header-section-title ">
            <h1 class="mb-3">{{ $title }}</h1>
            <p>
                {{ $brief }}
            </p>
        </div>
    </section>
@endif
