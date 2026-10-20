{{-- Page buttons: Button category = page slug --}}
@if (isset($buttons) && $buttons->isNotEmpty())
    <div class="page-buttons">
        @foreach ($buttons as $button)
            <a {!! Utility::printAllUrl($button->url) !!}>{{ $button->label ?? $button->title }}</a>
        @endforeach
    </div>
@endif
