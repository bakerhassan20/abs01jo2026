<x-layouts.layout seoTitle="{{ $taregtPage->seo?->title ?: $taregtPage->title }}" seoDescription="{{ $taregtPage->seo?->description ?: $taregtPage->brief }}"
    seoKeywords="{{ $taregtPage->seo?->keywords }}" seoImage="{{ $taregtPage->mainImage?->url }}">

    @section('content')

        @include('site.partials.page_header')

        <section class="admissions-intro">
            <h1>{{ $taregtPage->title }}</h1>
            <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
        </section>

        {{-- Steps: Bms category = page slug (second_title = "STEP ONE", title, brief, url) --}}
        <section class="admissions-steps">
            <h2>{{ __('site.YOUR_ABS_JOURNEY_STARTS_HERE') }}</h2>
            <p>{{ __('site.YOUR_ABS_JOURNEY_STARTS_HERE_BRIEF') }}</p>
            <ol>
                @foreach ($sections as $step)
                    <li>
                        <span>{{ $step->second_title }}</span>
                        <x-common.webp-image :mediaObject='$step->mainImage' alt='{{ $step->title }}' />
                        <h3>{{ $step->title }}</h3>
                        <div>{!! Content::inlineStyleToClasses($step->content ?: $step->brief) !!}</div>
                        @if ($step->url)
                            <a {!! Utility::printAllUrl($step->url) !!}>{{ $step->button_text_1 ?: __('site.READ_MORE') }}</a>
                        @endif
                    </li>
                @endforeach
            </ol>
        </section>

        {{-- Call to action --}}
        <section class="admissions-cta">
            <h2>{{ __('site.READY_TO_BEGIN_YOUR_ABS_JOURNEY') }}</h2>
            <p>{{ __('site.READY_TO_BEGIN_YOUR_ABS_JOURNEY_BRIEF') }}</p>
            @if (setting('site.book_tour_url'))
                <a {!! Utility::printAllUrl(setting('site.book_tour_url')) !!}>{{ __('site.BOOK_A_CAMPUS_TOUR') }}</a>
            @endif
            @if (setting('site.apply_now_url'))
                <a {!! Utility::printAllUrl(setting('site.apply_now_url')) !!}>{{ __('site.APPLY_NOW') }}</a>
            @endif
            <a href="mailto:{{ setting('site.second_email') }}">{{ setting('site.second_email') }}</a>
            <a href="tel:{{ setting('site.second_phone') }}">{{ setting('site.second_phone') }}</a>
        </section>

    @endsection

</x-layouts.layout>
