<x-layouts.layout seoTitle="{{ __('site.PRIVACY') }}" layoutView="main-inner">




    @section('content')
 @php($path = '/terms-of-use-and-privacy-policy')
     <!-- Hero Section -->
            <x-common.header-image :innerItem=null :getFromSpacificLink=$path :breadcrumbItems="[
                ['url' => route('home', ['locale' => $lng]), 'label' => __('site.HOME')],
                ['url' => '', 'label' => __('site.PRIVACY_POLICY')],
            ]" />


               {!! Content::inlineStyleToClasses($taregtPage->content) !!}

    @endsection

</x-layouts.layout>
