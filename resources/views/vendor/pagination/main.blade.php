@if ($paginator->hasPages())
<div class="pagination-wrapper mb-4">
    <div class="container">
        <nav aria-label="Page">
            <ul class="pagination justify-content-center justify-content-sm-start pagination-container mb-0 px-0">

                {{-- Previous Page Link --}}
                <li class="page-item {{ $paginator->onFirstPage() ? 'disabled' : '' }}">
                    <a class="page-link rounded-circle"
                       href="{{ $paginator->previousPageUrl() ?? '#' }}"
                       aria-label="Previous">
                        <i class="fa-solid fa-angle-left"></i>
                    </a>
                </li>

                {{-- Pagination Elements --}}
                @foreach ($elements as $element)

                    {{-- "Three Dots" Separator --}}
                    @if (is_string($element))
                        <li class="page-item disabled">
                            <a class="page-link" href="#">{{ $element }}</a>
                        </li>
                    @endif

                    {{-- Page Numbers --}}
                    @if (is_array($element))
                        @foreach ($element as $page => $url)
                            <li class="page-item {{ $page == $paginator->currentPage() ? 'active' : '' }}">
                                <a class="page-link" href="{{ $url }}">
                                    {{ $page }}
                                </a>
                            </li>
                        @endforeach
                    @endif

                @endforeach

                {{-- Next Page Link --}}
                <li class="page-item {{ $paginator->hasMorePages() ? '' : 'disabled' }}">
                    <a class="page-link rounded-circle"
                       href="{{ $paginator->nextPageUrl() ?? '#' }}"
                       aria-label="Next">
                        <i class="fa-solid fa-angle-right"></i>
                    </a>
                </li>

            </ul>
        </nav>
    </div>
</div>

{{-- Page Info --}}
{{-- <div class="page-info">
    <p>
        {{ __('site.SHOWING') }}
        {{ $paginator->firstItem() }} - {{ $paginator->lastItem() }}
        {{ __('site.OF') }} {{ $paginator->total() }} {{ __('site.NEWS') }}
    </p>
</div> --}}
@endif
