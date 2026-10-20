<x-layouts.layout seoTitle="{{ __('site.ALUMNI_NEWS') }}" seoDescription="{{ __('site.ALUMNI_NEWS') }}">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/alumni/news" :spacificTitle="__('site.ALUMNI_NEWS')" />

        <section class="news-list">
            {{-- "Filter By" links to the main news list filtered by category --}}
            <span>{{ __('site.FILTER_BY') }}</span>
            @foreach ($categories as $category)
                <a href="{{ route('news-index', ['locale' => $lng, 'category' => $category->slug]) }}">{{ $category->title }}</a>
            @endforeach

            @foreach ($news as $item)
                <a href="{{ route('news-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                    <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                    <h3>{{ $item->title }}</h3>
                    <p>{{ $item->brief }}</p>
                </a>
            @endforeach

            {{ $news->links() }}
        </section>

    @endsection

</x-layouts.layout>
