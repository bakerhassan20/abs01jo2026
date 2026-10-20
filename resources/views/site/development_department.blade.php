<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        <section class="development-department">
            <h1>{{ $taregtPage->title }}</h1>
            <h2>{{ $taregtPage->brief }}</h2>
            <x-common.webp-image :mediaObject='$taregtPage->mainImage' alt='{{ $taregtPage->title }}' />
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
        </section>

        {{-- Flipbooks / cards: Bms category = page slug (title, image, url, button_text_1) --}}
        <section class="development-flipbooks">
            @foreach ($sections as $section)
                <div>
                    <x-common.webp-image :mediaObject='$section->mainImage' alt='{{ $section->title }}' />
                    <h3>{{ $section->title }}</h3>
                    <p>{{ $section->brief }}</p>
                    @if ($section->url)
                        <a {!! Utility::printAllUrl($section->url) !!}>{{ $section->button_text_1 ?: __('site.OPEN_FLIPBOOK') }}</a>
                    @endif
                </div>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
