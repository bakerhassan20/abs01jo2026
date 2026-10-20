<x-layouts.layout seoTitle="{{ __('site.SEARCH') }}" layoutView="main-inner">

    @section('content')

        <x-common.header-image :innerItem=null getFromSpacificLink="/search" :spacificTitle="__('site.SEARCH')" />

        <section class="search">
            <form method="post" action="{{ route('search', ['locale' => app()->getLocale()]) }}">
                @csrf
                <input type="text" name="search_word" value="{{ $searchWord ?? '' }}" placeholder="{{ __('site.SEARCH') }}" required>
                <button type="submit">{{ __('site.SEARCH') }}</button>
            </form>

            @if (!isset($searchWord))
                <p>{{ __('site.SEARCH_HINT') }}</p>
            @elseif (isset($searchSections) && collect($searchSections)->every(fn($section) => $section['items']->isEmpty()))
                <p>{{ __('site.NO_RESULTS_FOUND') }}</p>
            @elseif (isset($searchSections))
                @include('site.search_ajax')
            @endif
        </section>

    @endsection

</x-layouts.layout>
