{{-- Placeholder markup: replace with the slicing, keep wire:model bindings and names --}}
<div>
<form wire:submit="submit" class="subscribe-form">

    @if (Session::has('success'))
        <div class="alert alert-success">{{ Session::get('success') }}</div>
    @endif

    <div class="form-group">
        <label for="email">{{ __('site.EMAIL') }} <span class="text-danger">*</span></label>
        <input type="email" id="email" wire:model.blur="email" class="form-control @error('email') is-invalid @enderror" placeholder="{{ __('site.EMAIL_PLACEHOLDER') }}">
        @error('email')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>

    <button type="submit" wire:loading.attr="disabled">{{ __('site.SUBSCRIBE') }}</button>

</form>
</div>
