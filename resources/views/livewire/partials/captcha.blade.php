{{-- Google reCAPTCHA v2 (explicit render). Site key from settings general.google_recaptcha_site_key --}}
<div>
    <div id="captcha-{{ $this->getId() }}" wire:ignore></div>
    @error('captcha')
        <div class="invalid-feedback d-block">{{ $message }}</div>
    @enderror
</div>

@push('js')
    <script nonce="{{ $jsNonce }}">
        window.recaptchaWidgets = window.recaptchaWidgets || [];
        window.recaptchaWidgets.push({
            element: 'captcha-{{ $this->getId() }}',
            component: '{{ $this->getId() }}'
        });

        window.renderRecaptchaWidgets = window.renderRecaptchaWidgets || function () {
            window.recaptchaWidgets.forEach(function (widget) {
                if (widget.rendered || !document.getElementById(widget.element)) {
                    return;
                }
                widget.rendered = true;
                grecaptcha.render(widget.element, {
                    'sitekey': '{{ setting('general.google_recaptcha_site_key') }}',
                    'callback': function (response) {
                        Livewire.find(widget.component).set('captcha', response);
                    }
                });
            });
        };
    </script>
    @once
        <script src="https://www.google.com/recaptcha/api.js?onload=renderRecaptchaWidgets&render=explicit" async defer nonce="{{ $jsNonce }}"></script>
    @endonce
@endpush
