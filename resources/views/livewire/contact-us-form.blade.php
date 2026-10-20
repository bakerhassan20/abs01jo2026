{{-- Placeholder markup: replace with the slicing, keep wire:model bindings and names --}}
<div>
<form wire:submit="submit" class="contact-us-form">

    @if (Session::has('success'))
        <div class="alert alert-success">{{ Session::get('success') }}</div>
    @endif

    <div class="form-group">
        <label for="name">{{ __('site.NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="name" wire:model.blur="name" class="form-control @error('name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('name')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="email">{{ __('site.EMAIL') }} <span class="text-danger">*</span></label>
        <input type="email" id="email" wire:model.blur="email" class="form-control @error('email') is-invalid @enderror" placeholder="{{ __('site.EMAIL_PLACEHOLDER') }}">
        @error('email')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="phone">{{ __('site.MOBILE_NUMBER') }} <span class="text-danger">*</span></label>
        {{-- internation_phone_country holds the ISO country code (default JO); wire intl-tel-input to it --}}
        <input type="hidden" wire:model="internation_phone_country">
        <input type="tel" id="phone" wire:model.blur="phone" class="form-control @error('phone') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('phone')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="company">{{ __('site.COMPANY') }}</label>
        <input type="text" id="company" wire:model.blur="company" class="form-control @error('company') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('company')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="department">{{ __('site.SUBJECT') }} <span class="text-danger">*</span></label>
        <select id="department" wire:model.live="department" class="form-select @error('department') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($subs as $sub)
                <option value="{{ $sub->title }}">{{ $sub->title }}</option>
            @endforeach
        </select>
        @error('department')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="message">{{ __('site.MESSAGE') }}</label>
        <textarea id="message" rows="4" wire:model.blur="message" class="form-control @error('message') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}"></textarea>
        @error('message')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>

    @include('livewire.partials.captcha')

    <button type="submit" wire:loading.attr="disabled">{{ __('site.SUBMIT') }}</button>

</form>
</div>
