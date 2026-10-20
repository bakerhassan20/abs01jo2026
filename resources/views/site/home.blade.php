<x-layouts.layout seoTitle="{{ setting($lng . '.general.title') }}" seoDescription="{{ setting($lng . '.general.description') }}"
    seoKeywords="{{ setting($lng . '.general.keywords') }}">

    @section('content')

        {{-- Hero: Bms "home-hero" --}}
        <section class="home-hero">
            @foreach ($heroSlides as $slide)
                <div>
                    <x-common.webp-image :mediaObject='$slide->mainImage' alt='{{ $slide->title }}' />
                    <h1>{{ $slide->title }}</h1>
                    <p>{{ $slide->brief }}</p>
                </div>
            @endforeach
        </section>

        {{-- Why ABS: Bms "why-abs" (first item) + "why-abs-features" --}}
        @if ($whyAbs->isNotEmpty())
            @php($whyAbsItem = $whyAbs->first())
            <section class="why-abs">
                <x-common.webp-image :mediaObject='$whyAbsItem->mainImage' alt='{{ $whyAbsItem->title }}' />
                <h2>{{ $whyAbsItem->title }}</h2>
                <div>{!! Content::inlineStyleToClasses($whyAbsItem->content ?: $whyAbsItem->brief) !!}</div>
                @if ($whyAbsItem->url)
                    <a {!! Utility::printAllUrl($whyAbsItem->url) !!}>{{ __('site.READ_MORE') }}</a>
                @endif
                <ul>
                    @foreach ($whyAbsFeatures as $feature)
                        <li>
                            <x-common.webp-image :mediaObject='$feature->mainImage' alt='{{ $feature->title }}' />
                            <h3>{{ $feature->title }}</h3>
                            <p>{{ $feature->brief }}</p>
                        </li>
                    @endforeach
                </ul>
            </section>
        @endif

        {{-- Facts & Figures: Bms "facts-figures" (title = number, second_title = unit, brief = label) --}}
        <section class="facts-figures">
            <h2>{{ __('site.ABS_FACTS_FIGURES') }}</h2>
            <ul>
                @foreach ($factsFigures as $fact)
                    <li>
                        <x-common.webp-image :mediaObject='$fact->mainImage' alt='{{ $fact->brief }}' />
                        <strong>{{ $fact->title }}</strong> <span>{{ $fact->second_title }}</span>
                        <p>{{ $fact->brief }}</p>
                    </li>
                @endforeach
            </ul>
        </section>

        {{-- Schools cards: Bms "home-schools" (title = grades, second_title = school, url) --}}
        <section class="home-schools">
            <h2>{{ __('site.SCHOOLS') }}</h2>
            @foreach ($schools as $school)
                <a {!! Utility::printAllUrl($school->url) !!}>
                    <x-common.webp-image :mediaObject='$school->mainImage' alt='{{ $school->title }}' />
                    <span>{{ $school->second_title }}</span>
                    <h3>{{ $school->title }}</h3>
                </a>
            @endforeach
        </section>

        {{-- Academic Achievements: Bms "academic-achievements" (title = value, brief = label) --}}
        <section class="academic-achievements">
            <h2>{{ __('site.ACADEMIC_ACHIEVEMENTS') }}</h2>
            <p>{{ __('site.ACADEMIC_ACHIEVEMENTS_BRIEF') }}</p>
            <ul>
                @foreach ($achievements as $achievement)
                    <li>
                        <x-common.webp-image :mediaObject='$achievement->mainImage' alt='{{ $achievement->brief }}' />
                        <strong>{{ $achievement->title }}</strong>
                        <p>{{ $achievement->brief }}</p>
                    </li>
                @endforeach
            </ul>
        </section>

        {{-- Accreditations & Recognitions: Bms "accreditations" (logo + url) --}}
        <section class="accreditations">
            <h2>{{ __('site.ACCREDITATIONS_RECOGNITIONS') }}</h2>
            <p>{{ __('site.ACCREDITATIONS_RECOGNITIONS_BRIEF') }}</p>
            @foreach ($accreditations as $accreditation)
                <a {!! Utility::printAllUrl($accreditation->url) !!}>
                    <x-common.webp-image :mediaObject='$accreditation->mainImage' alt='{{ $accreditation->title }}' />
                </a>
            @endforeach
        </section>

        {{-- Latest Stories: News (facebook / instagram tabs use site.facebook / site.instagram settings) --}}
        <section class="latest-stories">
            <h2>{{ __('site.LATEST_STORIES') }}</h2>
            @foreach ($latestNews as $item)
                <a href="{{ route('news-view', ['locale' => $lng, 'slug' => $item->slug]) }}">
                    <x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' />
                    <h3>{{ $item->title }}</h3>
                </a>
            @endforeach
            <a href="{{ route('news-index', ['locale' => $lng]) }}">{{ __('site.EXPLORE_MORE') }}</a>
        </section>

        {{-- Voices of ABS: Bms "testimonials" (brief = quote, title = name, second_title = role) --}}
        <section class="testimonials">
            <h2>{{ __('site.VOICES_OF_ABS') }}</h2>
            <p>{{ __('site.VOICES_OF_ABS_BRIEF') }}</p>
            @foreach ($testimonials as $testimonial)
                <blockquote>
                    <p>{{ $testimonial->brief }}</p>
                    <footer>{{ $testimonial->title }} - {{ $testimonial->second_title }}</footer>
                </blockquote>
            @endforeach
        </section>

        {{-- Notable alumni: Bms "notable-alumni" (title = name, brief = description, image) --}}
        <section class="notable-alumni">
            <p>{{ __('site.NOTABLE_ALUMNI_BRIEF') }}</p>
            @foreach ($notableAlumni as $alumnus)
                <div>
                    <x-common.webp-image :mediaObject='$alumnus->mainImage' alt='{{ $alumnus->title }}' />
                    <h3>{{ $alumnus->title }}</h3>
                    <p>{{ $alumnus->brief }}</p>
                </div>
            @endforeach
        </section>

        {{-- University Destinations: University (is_featured) --}}
        <section class="university-destinations">
            <h2>{{ __('site.UNIVERSITY_DESTINATIONS') }}</h2>
            <p>{{ __('site.UNIVERSITY_DESTINATIONS_BRIEF') }}</p>
            @foreach ($universities as $university)
                <a {!! Utility::printAllUrl($university->url) !!}>
                    <x-common.webp-image :mediaObject='$university->mainImage' alt='{{ $university->title }}' />
                </a>
            @endforeach
            <a href="{{ route('universities-index', ['locale' => $lng]) }}">{{ __('site.VIEW_ALL_UNIVERSITIES') }}</a>
        </section>

    @endsection

</x-layouts.layout>
