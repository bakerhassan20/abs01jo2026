<x-layouts.layout seoTitle="{{ $targetItem->title }}" seoDescription="{{ $targetItem->brief }}"
    seoImage="{{ $targetItem->mainImage?->url }}">

    @section('content')

        <x-common.header-image :innerItem=$targetItem getFromSpacificLink="/news" :spacificTitle="$targetItem->title" />

        <article class="news-view">
            <x-common.webp-image :mediaObject='$targetItem->mainImage' alt='{{ $targetItem->title }}' />
            <span>{{ $targetItem->category?->title }}</span>
            <time>{{ $targetItem->published_at_normal_name_date }}</time>
            <h1>{{ $targetItem->title }}</h1>
            <div>{!! Content::inlineStyleToClasses($targetItem->content) !!}</div>
        </article>

        @if ($relatedNews->isNotEmpty())
            <section class="related-news">
                <h2>{{ __('site.MORE_NEWS') }}</h2>
                @foreach ($relatedNews as $item)
                    <a href="{{ route('news-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                        <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                        <h3>{{ $item->title }}</h3>
                    </a>
                @endforeach
            </section>
        @endif

    @endsection

</x-layouts.layout>
