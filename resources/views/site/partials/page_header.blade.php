{{-- Shared page header for CMS page templates --}}
<x-common.header-image :innerItem=$taregtPage :mainImage='$taregtPage->headerImage' :spacificTitle="$taregtPage->title" :breadcrumbItems="[
    ['url' => route('home', ['locale' => $lng]), 'label' => __('site.HOME')],
    ['url' => '', 'label' => $taregtPage->title],
]" />
