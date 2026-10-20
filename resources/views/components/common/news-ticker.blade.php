{{-- Header news ticker: Bms category "news-ticker" (title + url) --}}
<div class="news-ticker">
    <ul>
        @foreach ($items as $item)
            <li><a {!! Utility::printAllUrl($item->url) !!}>{{ $item->title }}</a></li>
        @endforeach
    </ul>
</div>
