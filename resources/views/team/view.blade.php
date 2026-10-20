<x-layouts.layout seoTitle="{{ $targetItem->title }}" seoDescription="{{ $targetItem->brief }}"
    seoImage="{{ $targetItem->mainImage?->url }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="$category->title" />

        <article class="team-member">
            <a href="{{ route('team-index', ['locale' => $lng, 'category' => $category->slug]) }}">{{ $category->title }}</a>
            <x-common.webp-image :mediaObject='$targetItem->mainImage' alt='{{ $targetItem->title }}' />
            <h1>{{ $targetItem->title }}</h1>
            <p>{{ $targetItem->position }}</p>
            <div>{!! Content::inlineStyleToClasses($targetItem->content) !!}</div>
            @if ($targetItem->linkedin_url)
                <a {!! Utility::printAllUrl($targetItem->linkedin_url) !!}>LinkedIn</a>
            @endif
        </article>

    @endsection

</x-layouts.layout>
