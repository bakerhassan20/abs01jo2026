<x-layouts.layout seoTitle="{{ $taregtPage?->title ?? __('site.ALUMNI') }}" seoDescription="{{ $taregtPage?->brief }}">

    @section('content')

        <x-common.header-image :innerItem=$taregtPage getFromSpacificLink="/alumni" :spacificTitle="$taregtPage?->title ?? __('site.ALUMNI')" />

        {{-- Intro: Page "alumni" --}}
        @if ($taregtPage)
            <section class="alumni-intro">
                <x-common.webp-image :mediaObject='$taregtPage->mainImage' alt='{{ $taregtPage->title }}' />
                <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
            </section>
        @endif

        <section class="alumni-links">
            <a href="{{ route('alumni-stay-connected', ['locale' => $lng]) }}">{{ __('site.STAY_CONNECTED_FORM') }}</a>
            <a href="{{ route('class-note', ['locale' => $lng]) }}">{{ __('site.SUBMIT_A_CLASS_NOTE') }}</a>
            <a href="{{ route('giving', ['locale' => $lng]) }}">{{ __('site.SUPPORT_YOUR_ALMA_MATER') }}</a>
        </section>

        <section class="alumni-news">
            <h2>{{ __('site.ALUMNI_NEWS') }}</h2>
            @foreach ($news as $item)
                <a href="{{ route('news-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                    <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                    <h3>{{ $item->title }}</h3>
                </a>
            @endforeach
            <a href="{{ route('alumni-news-index', ['locale' => $lng]) }}">{{ __('site.EXPLORE_MORE') }}</a>
        </section>

    @endsection

</x-layouts.layout>
