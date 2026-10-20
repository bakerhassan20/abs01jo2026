<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        {{-- Letter (e.g. Principal & CEO): title, brief = greeting, content = letter, image = signatory photo --}}
        <section class="letter">
            <h1>{{ $taregtPage->title }}</h1>
            <h2>{{ $taregtPage->brief }}</h2>
            <x-common.webp-image :mediaObject='$taregtPage->mainImage' alt='{{ $taregtPage->title }}' />
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
        </section>

    @endsection

</x-layouts.layout>
