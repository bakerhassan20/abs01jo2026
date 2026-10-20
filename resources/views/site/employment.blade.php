<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        {{-- Tabs: Bms category = page slug (Employment, Opportunities, Living in Jordan) --}}
        <section class="employment">
            <h1>{{ $taregtPage->title }}</h1>
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>

            <ul role="tablist">
                @foreach ($sections as $section)
                    <li><button type="button" data-tab="employment-{{ $section->id }}">{{ $section->title }}</button></li>
                @endforeach
            </ul>
            @foreach ($sections as $section)
                <div id="employment-{{ $section->id }}" role="tabpanel">
                    <x-common.webp-image :mediaObject='$section->mainImage' alt='{{ $section->title }}' />
                    <div>{!! Content::inlineStyleToClasses($section->content) !!}</div>
                </div>
            @endforeach

            <div class="careers-links">
                @if (setting('site.careers_url'))
                    <a {!! Utility::printAllUrl(setting('site.careers_url')) !!}>{{ __('site.ABS_CAREERS_PAGE') }}</a>
                @endif
                @if (setting('site.tes_jobs_url'))
                    <a {!! Utility::printAllUrl(setting('site.tes_jobs_url')) !!}>{{ __('site.ABS_TES_JOBS') }}</a>
                @endif
            </div>
        </section>

    @endsection

</x-layouts.layout>
