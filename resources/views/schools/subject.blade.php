<x-layouts.layout seoTitle="{{ $targetItem->seo?->title ?: $targetItem->title }}" seoDescription="{{ $targetItem->seo?->description ?: strip_tags($targetItem->brief) }}"
    seoImage="{{ $targetItem->mainImage?->url }}">

    @section('content')

        <x-common.header-image :innerItem=$targetItem :spacificTitle="$targetItem->title" />

        <article class="school-subject">
            <a href="{{ route('schools-view', ['locale' => $lng, 'slug' => $school->slug]) }}">{{ $school->title }}</a>
            <h1>{{ $targetItem->title }}</h1>
            <x-common.webp-image :mediaObject='$targetItem->mainImage' alt='{{ $targetItem->title }}' />
            <div>{!! Content::inlineStyleToClasses($targetItem->content) !!}</div>
        </article>

    @endsection

</x-layouts.layout>
