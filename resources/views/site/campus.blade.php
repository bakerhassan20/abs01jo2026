<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        <section class="campus">
            <h1>{{ $taregtPage->title }}</h1>
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
        </section>

        {{-- Albums whose category slug = page slug --}}
        <section class="campus-albums">
            @foreach ($albums as $album)
                <a href="{{ route('albums-view', ['locale' => $lng, 'slug' => $album->slug]) }}">
                    <x-common.webp-image :mediaObject='$album->mainImage' alt='{{ $album->title }}' />
                    <h3>{{ $album->title }}</h3>
                    <span>+{{ $album->images_count }}</span>
                </a>
            @endforeach
        </section>

        @foreach ($sections as $section)
            <section class="page-section">
                <h2>{{ $section->title }}</h2>
                <x-common.webp-image :mediaObject='$section->mainImage' alt='{{ $section->title }}' />
                <div>{!! Content::inlineStyleToClasses($section->content ?: $section->brief) !!}</div>
            </section>
        @endforeach

    @endsection

</x-layouts.layout>
