<x-layouts.layout seoTitle="{{ __('site.ALBUMS') }}" seoDescription="{{ __('site.ALBUMS') }}">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/albums" :spacificTitle="__('site.ALBUMS')" />

        <section class="albums-list">
            @foreach ($albums as $album)
                <a href="{{ route('albums-view', ['locale' => $lng, 'slug' => $album->slug]) }}">
                    <x-common.webp-image :mediaObject='$album->mainImage' alt='{{ $album->title }}' />
                    <h3>{{ $album->title }}</h3>
                    <span>+{{ $album->images_count }}</span>
                </a>
            @endforeach

            {{ $albums->links() }}
        </section>

    @endsection

</x-layouts.layout>
