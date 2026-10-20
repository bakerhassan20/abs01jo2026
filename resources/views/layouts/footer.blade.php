{{-- Footer placeholder: replace markup with the slicing, keep the data bindings --}}
<footer class="site-footer">

    <div class="footer-top">
        <a href="{{ route('home', ['locale' => $lng]) }}" class="logo">
            <x-common.webp-image :mediaObject='$logo' alt='{{ setting("{$lng}.general.title") }}' />
        </a>
        <h4>{{ __('site.FOOTER_SLOGAN') }}</h4>
        <x-common.social-media-links />
    </div>

    <div class="footer-columns">

        <x-common.footer-menu />

        <div class="footer-column">
            <h5>{{ __('site.CONTACT_US') }}</h5>
            <ul>
                <li>{{ setting("{$lng}.site.location") }}</li>
                <li><a href="tel:{{ setting('site.main_phone') }}">{{ setting('site.main_phone') }}</a></li>
                <li><a href="mailto:{{ setting('site.main_email') }}">{{ setting('site.main_email') }}</a></li>
                <li>{{ setting("{$lng}.site.business_hours_from") }} - {{ setting("{$lng}.site.business_hours_to") }}</li>
                @if (setting("{$lng}.site.location_url"))
                    <li><a {!! Utility::printAllUrl(setting("{$lng}.site.location_url")) !!}>{{ __('site.GET_DIRECTIONS') }}</a></li>
                @endif
            </ul>
        </div>

        <div class="footer-column">
            <h5>{{ __('site.STAY_UPDATED') }}</h5>
            <p>{{ __('site.STAY_UPDATED_BRIEF') }}</p>
            @livewire('subscribe-form')
        </div>

    </div>

    <div class="footer-bottom">
        <p>
            © {{ date('Y') }} {{ __('site.DEVELOPED_BY') }}
            <a target="_blank" rel="noopener noreferrer nofollow" href="https://dot.jo/">dot.jo</a>
            {{ __('site.ALL_RIGHTS_RESERVED') }}
        </p>
        <a href="{{ route('privacy-policy', ['locale' => $lng]) }}">{{ __('site.PRIVACY_POLICY') }}</a>
        <a href="{{ route('terms-conditions', ['locale' => $lng]) }}">{{ __('site.TERMS_AND_CONDITIONS') }}</a>
    </div>

    <a href="{{ route('contact-us', ['locale' => $lng]) }}" class="enquire-now">{{ __('site.ENQUIRE_NOW') }}</a>

</footer>

{{-- Scripts: add the slicing js files here (public/js), each with nonce="{{ $jsNonce }}" --}}

@livewireScripts(['nonce' => $jsNonce])
@stack('js')
