<x-layouts.layout seoTitle="{{ __('site.GIVING_FORM_TITLE') }}" seoDescription="{{ __('site.GIVING_FORM_BRIEF') }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="__('site.GIVING_FORM_TITLE')" />

        <section class="webform">
            <h1>{{ __('site.GIVING_FORM_TITLE') }}</h1>
            <p>{{ __('site.GIVING_FORM_BRIEF') }}</p>

            @livewire('giving-form')
        </section>

    @endsection

</x-layouts.layout>
