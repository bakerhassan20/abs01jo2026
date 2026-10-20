<x-layouts.layout seoTitle="{{ __('site.CONTACT_US') }}" seoDescription="{{ __('site.CONTACT_US_BRIEF') }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="__('site.CONTACT_US')" />

        <section class="webform">
            <h1>{{ __('site.CONTACT_US') }}</h1>
            <p>{{ __('site.CONTACT_US_BRIEF') }}</p>

            @livewire('contact-us-form')
        </section>

    @endsection

</x-layouts.layout>
