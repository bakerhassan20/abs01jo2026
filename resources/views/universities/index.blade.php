<x-layouts.layout seoTitle="{{ __('site.UNIVERSITY_DESTINATIONS') }}" seoDescription="{{ __('site.UNIVERSITY_DESTINATIONS_BRIEF') }}">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/universities" :spacificTitle="__('site.UNIVERSITY_DESTINATIONS')" />

        <section class="universities-list">
            <p>{{ __('site.UNIVERSITY_DESTINATIONS_BRIEF') }}</p>
            @foreach ($universities as $university)
                <a {!! Utility::printAllUrl($university->url) !!}>
                    <x-common.webp-image :mediaObject='$university->mainImage' alt='{{ $university->title }}' />
                    <h3>{{ $university->title }}</h3>
                    <p>{{ $university->brief }}</p>
                </a>
            @endforeach

            {{ $universities->links() }}
        </section>

    @endsection

</x-layouts.layout>
