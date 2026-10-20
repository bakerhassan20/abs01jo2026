<x-layouts.layout seoTitle="{{ __('site.SITE_MAP') }}" layoutView="main-inner">




    @section('content')
        @php($path = '/site-map')
        <!-- Hero Section -->
        <x-common.header-image :innerItem=null :getFromSpacificLink=$path :breadcrumbItems="[
            ['url' => route('home', ['locale' => $lng]), 'label' => __('site.HOME')],
            ['url' => '', 'label' => __('site.SITE_MAP')],
        ]" />


        <div class="links-section">
            <div class="container">
                <div class="row">


                    @if (isset($menuParents) && $menuParents)
                        @foreach ($menuParents as $index => $footerItem)
                            <div class="col-md-4">
                                <h3><a {!! Utility::printAllUrl($footerItem->link) !!}>{{ $footerItem->title }}</a></h3>
                                <ul>
                                    @foreach ($footerItem->childs as $item)
                                        <li>
                                            <a {!! Utility::printAllUrl($item->link) !!}>{{ $item->title }}</a>
                                            {{-- Only show nested items if they exist --}}
                                            @if (isset($item->childs) && count($item->childs) > 0)
                                                <ul>
                                                    @foreach ($item->childs as $childItem)
                                                        <li><a {!! Utility::printAllUrl($childItem->link) !!}>{{ $childItem->title }}</a></li>
                                                    @endforeach
                                                </ul>
                                            @endif
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        @endforeach
                    @endif

                </div>
            </div>
        </div>
    @endsection

</x-layouts.layout>
