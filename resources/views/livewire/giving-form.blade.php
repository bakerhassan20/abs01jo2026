{{-- Placeholder markup: replace with the slicing, keep wire:model bindings and names --}}
<div>
<form wire:submit="submit" class="giving-form">

    @if (Session::has('success'))
        <div class="alert alert-success">{{ Session::get('success') }}</div>
    @endif

    <div class="form-group">
        <span>{{ __('site.GIFT_AMOUNT') }} <span class="text-danger">*</span></span>
        @foreach ($amountList as $option)
            <label>
                <input type="radio" wire:model.live="amount" value="{{ $option }}">
                {{ $option == 'other' ? __('site.OTHER') : $option . ' ' . __('site.JOD') }}
            </label>
        @endforeach
        @error('amount')
            <div class="invalid-feedback d-block">{{ $message }}</div>
        @enderror
    </div>

    @if ($amount == 'other')
    <div class="form-group">
        <label for="other_amount">{{ __('site.AMOUNT_JOD') }} <span class="text-danger">*</span></label>
        <input type="number" id="other_amount" wire:model.blur="other_amount" class="form-control @error('other_amount') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('other_amount')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    @endif
    <div class="form-group">
        <label for="designation">{{ __('site.DESIGNATION') }}</label>
        <select id="designation" wire:model.live="designation" class="form-select @error('designation') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($designationList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('designation')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="tribute">{{ __('site.TRIBUTE') }}</label>
        <select id="tribute" wire:model.live="tribute" class="form-select @error('tribute') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($tributeList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('tribute')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-check">
        <input type="checkbox" id="on_behalf_of_organization" wire:model.live="on_behalf_of_organization" class="form-check-input @error('on_behalf_of_organization') is-invalid @enderror">
        <label for="on_behalf_of_organization" class="form-check-label">{{ __('site.GIFT_ON_BEHALF_OF_ORGANIZATION') }}</label>
        @error('on_behalf_of_organization')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>

    @if ($on_behalf_of_organization)
    <div class="form-group">
        <label for="organization_name">{{ __('site.ORGANIZATION_NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="organization_name" wire:model.blur="organization_name" class="form-control @error('organization_name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('organization_name')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    @endif
    <div class="form-group">
        <label for="title">{{ __('site.NAME_TITLE') }} <span class="text-danger">*</span></label>
        <select id="title" wire:model.live="title" class="form-select @error('title') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($titleList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('title')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="first_name">{{ __('site.FIRST_NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="first_name" wire:model.blur="first_name" class="form-control @error('first_name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('first_name')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="last_name">{{ __('site.LAST_NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="last_name" wire:model.blur="last_name" class="form-control @error('last_name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('last_name')
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
        <label for="phone">{{ __('site.PHONE') }} <span class="text-danger">*</span></label>
        {{-- internation_phone_country holds the ISO country code (default JO); wire intl-tel-input to it --}}
        <input type="hidden" wire:model="internation_phone_country">
        <input type="tel" id="phone" wire:model.blur="phone" class="form-control @error('phone') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('phone')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="country">{{ __('site.COUNTRY') }} <span class="text-danger">*</span></label>
        <input type="text" id="country" wire:model.blur="country" class="form-control @error('country') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('country')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="address">{{ __('site.ADDRESS') }} <span class="text-danger">*</span></label>
        <input type="text" id="address" wire:model.blur="address" class="form-control @error('address') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('address')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="city">{{ __('site.CITY') }} <span class="text-danger">*</span></label>
        <input type="text" id="city" wire:model.blur="city" class="form-control @error('city') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('city')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="state_zip">{{ __('site.STATE_ZIP') }}</label>
        <input type="text" id="state_zip" wire:model.blur="state_zip" class="form-control @error('state_zip') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('state_zip')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-check">
        <input type="checkbox" id="is_anonymous" wire:model.live="is_anonymous" class="form-check-input @error('is_anonymous') is-invalid @enderror">
        <label for="is_anonymous" class="form-check-label">{{ __('site.GIFT_REMAIN_ANONYMOUS') }}</label>
        @error('is_anonymous')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="appear_in_donor_report">{{ __('site.APPEAR_IN_DONOR_REPORT') }}</label>
        <select id="appear_in_donor_report" wire:model.live="appear_in_donor_report" class="form-select @error('appear_in_donor_report') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('appear_in_donor_report')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="donor_type">{{ __('site.I_AM_A') }} <span class="text-danger">*</span></label>
        <select id="donor_type" wire:model.live="donor_type" class="form-select @error('donor_type') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($donorTypeList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('donor_type')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="comment">{{ __('site.LEAVE_A_COMMENT') }}</label>
        <textarea id="comment" rows="4" wire:model.blur="comment" class="form-control @error('comment') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}"></textarea>
        @error('comment')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="confirmation_email">{{ __('site.SEND_CONFIRMATION_EMAIL_TO') }}</label>
        <input type="email" id="confirmation_email" wire:model.blur="confirmation_email" class="form-control @error('confirmation_email') is-invalid @enderror" placeholder="{{ __('site.EMAIL_PLACEHOLDER') }}">
        @error('confirmation_email')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>

    @include('livewire.partials.captcha')

    <button type="submit" wire:loading.attr="disabled">{{ __('site.SUBMIT') }}</button>

</form>
</div>
