<x-layouts.layout seoTitle="{{ $targetItem->seo?->title ?: $targetItem->title }}" seoDescription="{{ $targetItem->seo?->description ?: $targetItem->brief }}"
    seoImage="{{ $targetItem->mainImage?->url }}">

    @section('content')

        <x-common.header-image :innerItem=$targetItem :mainImage='$targetItem->mainImage' :spacificTitle="$targetItem->title" />

        {{-- Welcome from head of school --}}
        <section class="school-welcome">
            <h2>{{ $targetItem->head_title }}</h2>
            <div>{!! Content::inlineStyleToClasses($targetItem->head_content) !!}</div>
            <h4>{{ $targetItem->head_name }}</h4>
            <p>{{ $targetItem->head_position }}</p>
            <x-common.webp-image :mediaObject='$targetItem->headImage' alt='{{ $targetItem->head_name }}' />
        </section>

        @if ($targetItem->content)
            <section class="school-content">{!! Content::inlineStyleToClasses($targetItem->content) !!}</section>
        @endif

        {{-- Tabs (SchoolTab), each with an accordion of subjects (SchoolSubject) --}}
        <section class="school-tabs">
            <h2>{{ $targetItem->grades_title }}</h2>

            <ul role="tablist">
                @foreach ($targetItem->tabs as $tab)
                    <li><button type="button" data-tab="tab-{{ $tab->id }}">{{ $tab->title }}</button></li>
                @endforeach
            </ul>

            @foreach ($targetItem->tabs as $tab)
                <div id="tab-{{ $tab->id }}" role="tabpanel">
                    @if ($tab->content)
                        <div>{!! Content::inlineStyleToClasses($tab->content) !!}</div>
                    @endif
                    <x-common.webp-image :mediaObject='$tab->mainImage' alt='{{ $tab->title }}' />

                    @foreach ($tab->subjects as $subject)
                        <details>
                            <summary>{{ $subject->title }}</summary>
                            <div>{!! Content::inlineStyleToClasses($subject->brief) !!}</div>
                            <x-common.webp-image :mediaObject='$subject->mainImage' alt='{{ $subject->title }}' />
                            @if ($subject->content)
                                <a href="{{ route('schools-subject-view', ['locale' => $lng, 'schoolSlug' => $targetItem->slug, 'slug' => $subject->slug]) }}">{{ __('site.CLICK_HERE_TO_READ_MORE') }}</a>
                            @endif
                        </details>
                    @endforeach
                </div>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
