<x-layouts.layout seoTitle="{{ __('site.SUBMIT_A_CLASS_NOTE') }}" seoDescription="{{ __('site.CLASS_NOTE_BRIEF') }}">

    @section('content')

        <x-common.header-image :innerItem=null :spacificTitle="__('site.SUBMIT_A_CLASS_NOTE')" />

        <section class="webform">
            <h1>{{ __('site.SUBMIT_A_CLASS_NOTE') }}</h1>
            <p>{{ __('site.CLASS_NOTE_BRIEF') }}</p>

            @livewire('class-note-form')
        </section>

    @endsection

</x-layouts.layout>
