{{-- Placeholder markup: replace with the slicing, keep wire:model bindings and names --}}
<div>
<form wire:submit="submit" class="alumni-stay-connected-form">

    @if (Session::has('success'))
        <div class="alert alert-success">{{ Session::get('success') }}</div>
    @endif

    <div class="form-group">
        <label for="first_name">{{ __('site.FIRST_NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="first_name" wire:model.blur="first_name" class="form-control @error('first_name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('first_name')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="middle_name">{{ __('site.MIDDLE_NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="middle_name" wire:model.blur="middle_name" class="form-control @error('middle_name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('middle_name')
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
        <label for="alumni_status">{{ __('site.STATUS') }}</label>
        <select id="alumni_status" wire:model.live="alumni_status" class="form-select @error('alumni_status') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($alumniStatusList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('alumni_status')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="email">{{ __('site.EMAIL_ADDRESS') }} <span class="text-danger">*</span></label>
        <input type="email" id="email" wire:model.blur="email" class="form-control @error('email') is-invalid @enderror" placeholder="{{ __('site.EMAIL_PLACEHOLDER') }}">
        @error('email')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="mobile">{{ __('site.MOBILE_NUMBER') }} <span class="text-danger">*</span></label>
        {{-- internation_phone_country holds the ISO country code (default JO); wire intl-tel-input to it --}}
        <input type="hidden" wire:model="internation_phone_country">
        <input type="tel" id="mobile" wire:model.blur="mobile" class="form-control @error('mobile') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('mobile')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="home_address">{{ __('site.HOME_ADDRESS') }}</label>
        <input type="text" id="home_address" wire:model.blur="home_address" class="form-control @error('home_address') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('home_address')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="is_alumni">{{ __('site.ARE_YOU_AN_ABS_ALUMNI') }}</label>
        <select id="is_alumni" wire:model.live="is_alumni" class="form-select @error('is_alumni') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('is_alumni')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="graduation_year">{{ __('site.CLASS_OF_ABS') }}</label>
        <input type="text" id="graduation_year" wire:model.blur="graduation_year" class="form-control @error('graduation_year') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('graduation_year')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="current_profession">{{ __('site.CURRENT_PROFESSION') }}</label>
        <input type="text" id="current_profession" wire:model.blur="current_profession" class="form-control @error('current_profession') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('current_profession')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="universities_attended">{{ __('site.UNIVERSITIES_ATTENDED') }}</label>
        <input type="text" id="universities_attended" wire:model.blur="universities_attended" class="form-control @error('universities_attended') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('universities_attended')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="degrees_awarded">{{ __('site.DEGREES_AWARDED') }}</label>
        <input type="text" id="degrees_awarded" wire:model.blur="degrees_awarded" class="form-control @error('degrees_awarded') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('degrees_awarded')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="listed_on_linkedin">{{ __('site.ABS_LISTED_ON_LINKEDIN') }}</label>
        <select id="listed_on_linkedin" wire:model.live="listed_on_linkedin" class="form-select @error('listed_on_linkedin') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('listed_on_linkedin')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="share_email">{{ __('site.CAN_ABS_SHARE_YOUR_EMAIL') }}</label>
        <select id="share_email" wire:model.live="share_email" class="form-select @error('share_email') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('share_email')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="is_parent">{{ __('site.ARE_YOU_AN_ABS_PARENT') }}</label>
        <select id="is_parent" wire:model.live="is_parent" class="form-select @error('is_parent') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('is_parent')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="spouse_is_alumni">{{ __('site.IS_YOUR_SPOUSE_AN_ABS_ALUMNUS') }}</label>
        <select id="spouse_is_alumni" wire:model.live="spouse_is_alumni" class="form-select @error('spouse_is_alumni') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('spouse_is_alumni')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="interested_activities">{{ __('site.INTERESTED_ALUMNI_ACTIVITIES') }}</label>
        <select id="interested_activities" wire:model.live="interested_activities" class="form-select @error('interested_activities') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($activitiesList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('interested_activities')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="receive_news">{{ __('site.RECEIVE_ABS_NEWS') }}</label>
        <select id="receive_news" wire:model.live="receive_news" class="form-select @error('receive_news') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ([__('site.YES'), __('site.NO')] as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('receive_news')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="suggestions">{{ __('site.SUGGESTIONS_FEEDBACK') }}</label>
        <textarea id="suggestions" rows="4" wire:model.blur="suggestions" class="form-control @error('suggestions') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}"></textarea>
        @error('suggestions')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>

    @include('livewire.partials.captcha')

    <button type="submit" wire:loading.attr="disabled">{{ __('site.SUBMIT') }}</button>

</form>
</div>
