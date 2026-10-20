<x-layouts.layout seoTitle="{{ __('site.STUDENT_ENGAGEMENT') }}" seoDescription="{{ $intro?->brief }}">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/student-engagement" :spacificTitle="__('site.STUDENT_ENGAGEMENT')" />

        {{-- Intro: Bms "student-engagement-intro" --}}
        @if ($intro)
            <section class="student-engagement-intro">
                <h2>{{ $intro->title }}</h2>
                <div>{!! Content::inlineStyleToClasses($intro->content ?: $intro->brief) !!}</div>
            </section>
        @endif

        <section class="student-engagement-types">
            <h2>{{ __('site.STUDENT_ENGAGEMENT_TYPES') }}</h2>
            @foreach ($engagements as $item)
                <a href="{{ route('student-engagement-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                    <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                    <h3>{{ $item->title }}</h3>
                </a>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
