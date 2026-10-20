<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        <section class="page-content">
            <h1>{{ $taregtPage->title }}</h1>
            <x-common.webp-image :mediaObject='$taregtPage->mainImage' alt='{{ $taregtPage->title }}' />
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
            @include('site.partials.page_buttons')
        </section>

        {{-- Optional sections: Bms whose category = page slug --}}
        @foreach ($sections as $section)
            <section class="page-section">
                <h2>{{ $section->title }}</h2>
                <x-common.webp-image :mediaObject='$section->mainImage' alt='{{ $section->title }}' />
                <div>{!! Content::inlineStyleToClasses($section->content ?: $section->brief) !!}</div>
            </section>
        @endforeach

    @endsection

</x-layouts.layout>
