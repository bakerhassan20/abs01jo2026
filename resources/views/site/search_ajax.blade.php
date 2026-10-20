@if (isset($searchSections))
    @foreach ($searchSections as $searchSection)
        @if ($searchSection['items']->count())
            <div class="search-section" data-section="{{ $searchSection['pagination_name'] }}">
                <h2>{{ $searchSection['title'] }}</h2>
                @foreach ($searchSection['items'] as $item)
                    @php($title = $searchSection['item_title'])
                    @php($brief = $searchSection['item_brief'])
                    <a href="{{ route($searchSection['item_url'], ['slug' => $item->slug, 'locale' => app()->getLocale()]) }}">
                        <h3>{{ $item->$title }}</h3>
                        <p>{{ $item->$brief }}</p>
                    </a>
                @endforeach

                @if ($searchSection['items']->hasMorePages())
                    <a class="load-more" href="{{ $searchSection['items']->nextPageUrl() }}" data-section="{{ $searchSection['pagination_name'] }}">
                        {{ __('site.LOAD_MORE') }}
                    </a>
                @endif
            </div>
        @endif
    @endforeach
@endif
