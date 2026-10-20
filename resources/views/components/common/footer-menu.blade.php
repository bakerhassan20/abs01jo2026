{{-- Footer menu: Menu "footer-menu", each parent is a column (Schools, Quick Links) --}}
@if (isset($menuParents) && $menuParents)
    @foreach ($menuParents as $footerItem)
        <div class="footer-column">
            <h5>{{ $footerItem->title }}</h5>
            <ul>
                @foreach ($footerItem->childs as $item)
                    <li><a {!! Utility::printAllUrl($item->link) !!}>{{ $item->title }}</a></li>
                @endforeach
            </ul>
        </div>
    @endforeach
@endif
