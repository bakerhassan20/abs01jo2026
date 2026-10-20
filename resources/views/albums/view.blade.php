<x-layouts.layout seoTitle="{{ $targetItem->title }}" seoDescription="{{ $targetItem->brief }}"
    seoImage="{{ $targetItem->mainImage?->url }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="$targetItem->title" />

        <section class="album-view">
            <h1>{{ $targetItem->title }}</h1>
            <p>{{ $targetItem->brief }}</p>
            @foreach ($targetItem->images as $image)
                <a href="{{ $image->url }}">
                    <x-common.webp-image :mediaObject='$image' alt='{{ $image->alt ?? $targetItem->title }}' />
                </a>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
