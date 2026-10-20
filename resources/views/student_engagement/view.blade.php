<x-layouts.layout seoTitle="{{ $targetItem->seo?->title ?: $targetItem->title }}" seoDescription="{{ $targetItem->seo?->description ?: $targetItem->brief }}"
    seoImage="{{ $targetItem->mainImage?->url }}">

    @section('content')

        <x-common.header-image :innerItem=$targetItem :spacificTitle="$targetItem->title" />

        {{-- "What are Co-curricular Activities?": Bms "student-engagement-intro" --}}
        @if ($intro)
            <section class="student-engagement-intro">
                <h2>{{ $intro->title }}</h2>
                <p>{{ $intro->brief }}</p>
                @if ($intro->url)
                    <a {!! Utility::printAllUrl($intro->url) !!}>{{ __('site.READ_MORE') }}</a>
                @endif
            </section>
        @endif

        <section class="student-engagement-content">
            <div>{!! Content::inlineStyleToClasses($targetItem->content) !!}</div>
            <x-common.webp-image :mediaObject='$targetItem->mainImage' alt='{{ $targetItem->title }}' />

            <h3>{{ $targetItem->list_title }}</h3>
            <div>{!! Content::inlineStyleToClasses($targetItem->list_content) !!}</div>
            <x-common.webp-image :mediaObject='$targetItem->secondImage' alt='{{ $targetItem->list_title }}' />
        </section>

        @if ($targetItem->albums->isNotEmpty())
            <section class="student-engagement-albums">
                <h2>{{ __('site.STUDENT_ENGAGEMENT_ALBUMS') }}</h2>
                @foreach ($targetItem->albums as $album)
                    <a href="{{ route('albums-view', ['locale' => $lng, 'slug' => $album->slug]) }}">
                        <x-common.webp-image :mediaObject='$album->mainImage' alt='{{ $album->title }}' />
                        <span>+{{ $album->images->count() }}</span>
                    </a>
                @endforeach
            </section>
        @endif

        @if ($moreEngagements->isNotEmpty())
            <section class="more-student-engagement">
                <h2>{{ __('site.MORE_STUDENT_ENGAGEMENT') }}</h2>
                @foreach ($moreEngagements as $item)
                    <a href="{{ route('student-engagement-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                        <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                        <h3>{{ $item->title }}</h3>
                    </a>
                @endforeach
            </section>
        @endif

    @endsection

</x-layouts.layout>
