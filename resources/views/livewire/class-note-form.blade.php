{{-- Placeholder markup: replace with the slicing, keep wire:model bindings and names --}}
<div>
<form wire:submit="submit" class="class-note-form">

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
        <label for="last_name">{{ __('site.LAST_NAME') }} <span class="text-danger">*</span></label>
        <input type="text" id="last_name" wire:model.blur="last_name" class="form-control @error('last_name') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('last_name')
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
        <label for="graduation_year">{{ __('site.YEAR_OF_GRADUATION') }} <span class="text-danger">*</span></label>
        <input type="text" id="graduation_year" wire:model.blur="graduation_year" class="form-control @error('graduation_year') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('graduation_year')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="university">{{ __('site.UNIVERSITY_COLLEGE_NAME') }}</label>
        <input type="text" id="university" wire:model.blur="university" class="form-control @error('university') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('university')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="field_of_study">{{ __('site.FIELD_OF_STUDY') }}</label>
        <input type="text" id="field_of_study" wire:model.blur="field_of_study" class="form-control @error('field_of_study') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('field_of_study')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="occupation">{{ __('site.CURRENT_OCCUPATION') }}</label>
        <input type="text" id="occupation" wire:model.blur="occupation" class="form-control @error('occupation') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('occupation')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="location">{{ __('site.LOCATION_CITY_COUNTRY') }} <span class="text-danger">*</span></label>
        <input type="text" id="location" wire:model.blur="location" class="form-control @error('location') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('location')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="note_type">{{ __('site.YOUR_NOTE') }}</label>
        <select id="note_type" wire:model.live="note_type" class="form-select @error('note_type') is-invalid @enderror">
            <option value="">{{ __('site.PLEASE_SELECT') }}</option>
            @foreach ($noteTypeList as $option)
                <option value="{{ $option }}">{{ $option }}</option>
            @endforeach
        </select>
        @error('note_type')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="note">{{ __('site.NOTE_DETAILS') }}</label>
        <textarea id="note" rows="4" wire:model.blur="note" class="form-control @error('note') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}"></textarea>
        @error('note')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="social_media_links">{{ __('site.SOCIAL_MEDIA_LINKS') }}</label>
        <input type="text" id="social_media_links" wire:model.blur="social_media_links" class="form-control @error('social_media_links') is-invalid @enderror" placeholder="{{ __('site.TYPE_HERE') }}">
        @error('social_media_links')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="confirmation_email">{{ __('site.SEND_CONFIRMATION_EMAIL_TO') }} <span class="text-danger">*</span></label>
        <input type="email" id="confirmation_email" wire:model.blur="confirmation_email" class="form-control @error('confirmation_email') is-invalid @enderror" placeholder="{{ __('site.EMAIL_PLACEHOLDER') }}">
        @error('confirmation_email')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-group">
        <label for="photo">{{ __('site.SUBMIT_YOUR_PHOTO') }}</label>
        <input type="file" id="photo" wire:model="photo" accept="image/*" class="form-control @error('photo') is-invalid @enderror">
        <div wire:loading wire:target="photo">{{ __('site.UPLOADING') }}</div>
        @error('photo')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>
    <div class="form-check">
        <input type="checkbox" id="share_permission" wire:model.live="share_permission" class="form-check-input @error('share_permission') is-invalid @enderror">
        <label for="share_permission" class="form-check-label">{{ __('site.PERMISSION_TO_SHARE_CLASS_NOTE') }} <span class="text-danger">*</span></label>
        @error('share_permission')
            <div class="invalid-feedback">{{ $message }}</div>
        @enderror
    </div>

    @include('livewire.partials.captcha')

    <button type="submit" wire:loading.attr="disabled">{{ __('site.SUBMIT') }}</button>

</form>
</div>
