<x-layouts.layout seoTitle="{{ $category->title }}" seoDescription="{{ $category->second_title }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="$category->title" />

        {{-- Category intro: DropdownList (Team Category) title / second_title / content --}}
        <section class="team-intro">
            <h2>{{ $category->second_title }}</h2>
            <div>{!! Content::inlineStyleToClasses($category->content) !!}</div>
        </section>

        {{-- Featured members (e.g. Chair of the Board) --}}
        @foreach ($featuredMembers as $member)
            <section class="team-featured">
                <x-common.webp-image :mediaObject='$member->mainImage' alt='{{ $member->title }}' />
                <h3>{{ $member->title }}</h3>
                <p>{{ $member->position }}</p>
                <div>{!! Content::inlineStyleToClasses($member->content) !!}</div>
            </section>
        @endforeach

        <section class="team-list">
            @foreach ($otherMembers as $member)
                <div>
                    <x-common.webp-image :mediaObject='$member->mainImage' alt='{{ $member->title }}' />
                    <span>{{ $member->position }}</span>
                    <h3>{{ $member->title }}</h3>
                    <p>{{ $member->brief }}</p>
                    <a href="{{ route('team-view', ['locale' => $lng, 'category' => $category->slug, 'slug' => $member->slug]) }}">{{ __('site.READ_MORE') }}</a>
                </div>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
