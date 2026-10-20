
      <div class="social-links d-inline-flex">
        @foreach ($socialMediaLinks as $socialMediaLink)

              <a {!! Utility::printAllUrl($socialMediaLink->url) !!} aria-label="Facebook">
                <i class="{{ $socialMediaLink->getIcon() }}"></i>
              </a>
        @endforeach
    </div>
