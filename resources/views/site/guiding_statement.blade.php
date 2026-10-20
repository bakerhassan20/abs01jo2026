<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        {{-- Guiding statement: page content = vision / mission; values = Bms category = page slug --}}
        <section class="guiding-statement">
            <h1>{{ $taregtPage->title }}</h1>
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
        </section>

        <section class="values">
            @foreach ($sections as $section)
                <div>
                    <x-common.webp-image :mediaObject='$section->mainImage' alt='{{ $section->title }}' />
                    <h3>{{ $section->title }}</h3>
                    <div>{!! Content::inlineStyleToClasses($section->content ?: $section->brief) !!}</div>
                </div>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
