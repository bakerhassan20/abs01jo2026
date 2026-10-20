<x-layouts.layout seoTitle="{{ __('site.SCHOOLS') }}" seoDescription="{{ __('site.SCHOOLS') }}">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/schools" :spacificTitle="__('site.SCHOOLS')" />

        <section class="schools-list">
            @foreach ($schools as $school)
                <a href="{{ route('schools-view', ['locale' => $lng, 'slug' => $school->slug]) }}">
                    <x-common.webp-image :mediaObject='$school->mainImage' alt='{{ $school->title }}' />
                    <h3>{{ $school->title }}</h3>
                    <span>{{ $school->grades_title }}</span>
                </a>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
