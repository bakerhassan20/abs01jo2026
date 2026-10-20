<div class="breadcrumb mt-2">
    @foreach($items as $index => $item)
        @if(isset($item['url']) && $item['url'])
            <a href="{{ $item['url'] }}" class="flex items-center">{{ $item['label'] }}</a>
        @else
            <p class="breadcrumb-item">{{ $item['label'] }}</p>
        @endif

        @if(!$loop->last)
            <span class="{{-- breadcrumb-separator --}}">
                <i class="fas fa-chevron-right"></i>
            </span>
        @endif
    @endforeach
</div>
