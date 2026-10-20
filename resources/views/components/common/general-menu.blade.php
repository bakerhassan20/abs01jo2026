{{-- Main (mega) menu: Menu "mega-menu", up to 3 levels --}}
@if (isset($menuParents) && $menuParents)
    <nav class="main-menu">
        <ul>
            @foreach ($menuParents as $item)
                <li>
                    <a {!! Utility::printAllUrl($item->link) !!}>{{ $item->title }}</a>
                    @if ($item->childs->isNotEmpty())
                        <ul>
                            @foreach ($item->childs as $child)
                                <li>
                                    <a {!! Utility::printAllUrl($child->link) !!}>{{ $child->title }}</a>
                                    @if ($child->childs->isNotEmpty())
                                        <ul>
                                            @foreach ($child->childs as $subChild)
                                                <li><a {!! Utility::printAllUrl($subChild->link) !!}>{{ $subChild->title }}</a></li>
                                            @endforeach
                                        </ul>
                                    @endif
                                </li>
                            @endforeach
                        </ul>
                    @endif
                </li>
            @endforeach
        </ul>
    </nav>
@endif
