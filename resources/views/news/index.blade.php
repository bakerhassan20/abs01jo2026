<x-layouts.layout seoTitle="{{ __('site.NEWS') }}" seoDescription="{{ __('site.NEWS_BRIEF') }}">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/news" :spacificTitle="__('site.NEWS')" />

        <section class="news-list">
            {{-- Filter by category (?category=slug) --}}
            <form method="get" action="{{ route('news-index', ['locale' => $lng]) }}">
                <label for="category">{{ __('site.FILTER_BY') }}</label>
                <select name="category" id="category">
                    <option value="">{{ __('site.ALL') }}</option>
                    @foreach ($categories as $category)
                        <option value="{{ $category->slug }}" @selected($selectedCategory == $category->slug)>{{ $category->title }}</option>
                    @endforeach
                </select>
                <button type="submit">{{ __('site.FILTER') }}</button>
            </form>

            @foreach ($news as $item)
                <a href="{{ route('news-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                    <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                    <span>{{ $item->category?->title }}</span>
                    <h3>{{ $item->title }}</h3>
                    <p>{{ $item->brief }}</p>
                    <time>{{ $item->published_at_normal_name_date }}</time>
                </a>
            @endforeach

            {{ $news->links() }}
        </section>

    @endsection

</x-layouts.layout>
