<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        <section class="apply-now">
            <h1>{{ $taregtPage->title }}</h1>
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
        </section>

        {{-- One tab per Bms (category = page slug): e.g. Primary School, Secondary School --}}
        <section class="apply-now-tabs">
            <ul role="tablist">
                @foreach ($sections as $section)
                    <li><button type="button" data-tab="apply-{{ $section->id }}">{{ $section->title }}</button></li>
                @endforeach
            </ul>
            @foreach ($sections as $section)
                <div id="apply-{{ $section->id }}" role="tabpanel">
                    <h2>{{ $section->second_title }}</h2>
                    <div>{!! Content::inlineStyleToClasses($section->content) !!}</div>
                </div>
            @endforeach
        </section>

        @include('site.partials.page_buttons')

    @endsection

</x-layouts.layout>
