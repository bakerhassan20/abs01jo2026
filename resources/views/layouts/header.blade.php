{{-- Header placeholder: replace markup with the slicing, keep the data bindings --}}
<header class="site-header">

    <a href="{{ route('home', ['locale' => $lng]) }}" class="logo">
        <x-common.webp-image :mediaObject='$logo' alt='{{ setting("{$lng}.general.title") }}' />
    </a>

    <div class="header-actions">
        <a href="{{ route('search', ['locale' => $lng]) }}">{{ __('site.SEARCH') }}</a>

        @foreach (config('app.locales') as $locale)
            @if ($locale != $lng)
                <a href="{{ route('change-language', ['locale' => $lng, 'back' => url()->full()]) }}">{{ $locale == 'ar' ? 'ع' : strtoupper($locale) }}</a>
            @else
                <span>{{ $locale == 'ar' ? 'ع' : strtoupper($locale) }}</span>
            @endif
        @endforeach

        @if (setting('site.portal_url'))
            <a {!! Utility::printAllUrl(setting('site.portal_url')) !!}>{{ __('site.ABS_PORTAL') }}</a>
        @endif
        @if (setting('site.apply_now_url'))
            <a {!! Utility::printAllUrl(setting('site.apply_now_url')) !!}>{{ __('site.APPLY_NOW') }}</a>
        @endif
        @if (setting('site.calendar_url'))
            <a {!! Utility::printAllUrl(setting('site.calendar_url')) !!}>{{ __('site.CALENDAR') }}</a>
        @endif
    </div>

    <x-common.general-menu />

    <x-common.news-ticker />

</header>
