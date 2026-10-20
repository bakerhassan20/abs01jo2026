<x-layouts.layout seoTitle="{{ __('site.TERMS_CONDITIONS') }}" layoutView="main-inner">




    @section('content')
 @php($path = '/terms-conditions')
     <!-- Hero Section -->
            <x-common.header-image :innerItem=null :getFromSpacificLink=$path :breadcrumbItems="[
                ['url' => route('home', ['locale' => $lng]), 'label' => __('site.HOME')],
                ['url' => '', 'label' => __('site.TERMS_CONDITIONS')],
            ]" />


               {!! Content::inlineStyleToClasses($taregtPage->content) !!}

    @endsection

</x-layouts.layout>
