<x-layouts.layout seoTitle="{{ __('site.STAY_CONNECTED_TITLE') }}" seoDescription="{{ __('site.STAY_CONNECTED_BRIEF') }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="__('site.STAY_CONNECTED_TITLE')" />

        <section class="webform">
            <h1>{{ __('site.STAY_CONNECTED_TITLE') }}</h1>
            <p>{{ __('site.STAY_CONNECTED_BRIEF') }}</p>

            @livewire('alumni-stay-connected-form')
        </section>

    @endsection

</x-layouts.layout>
