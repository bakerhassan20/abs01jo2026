<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="icon" href="{{ $favIcon?->largeUrl }}">

    @php
        $seoDescription = strip_tags($seoDescription);
        $seoDescription = trim(preg_replace('/\s+/', ' ', $seoDescription));
    @endphp
    <x-common.seo :seoTitle="$seoTitle" :seoDescription="$seoDescription" :seoKeywords="$seoKeywords" :seoAuther="$seoAuther" :seoImage="$seoImage"
        :seoOGType="$seoOGType" :seoTwitterType="$seoTwitterType" :seoSchema="$seoSchema" />


    {{-- Styles: add the slicing css files here (public/css), each with nonce="{{ $cssNonce }}" --}}

    @stack('css')

    @livewireStyles(['nonce' => $cssNonce])


    <x-common.external-analytics />

</head>
