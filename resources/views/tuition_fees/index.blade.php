<x-layouts.layout seoTitle="{{ $taregtPage?->title ?? __('site.TUITION_FEES') }}" seoDescription="{{ $taregtPage?->brief }}">

    @section('content')

        <x-common.header-image :innerItem=$taregtPage getFromSpacificLink="/tuition-fees" :spacificTitle="$taregtPage?->title ?? __('site.TUITION_FEES')" />

        {{-- Intro: Page "tuition-fees" --}}
        @if ($taregtPage)
            <section class="tuition-intro">
                <h2>{{ $taregtPage->brief }}</h2>
                <div>{!! Content::inlineStyleToClasses($taregtPage->content) !!}</div>
            </section>
        @endif

        {{-- Initial registration fees: Bms "tuition-registration-fees" (title, brief, second_title = amount) --}}
        <section class="tuition-registration-fees">
            <h3>{{ __('site.INITIAL_REGISTRATION') }}</h3>
            @foreach ($registrationFees as $fee)
                <div>
                    <h4>{{ $fee->title }}</h4>
                    <p>{{ $fee->brief }}</p>
                    <strong>{{ $fee->second_title }}</strong>
                </div>
            @endforeach
        </section>

        {{-- Annual tuition: TuitionFee grouped by School --}}
        <section class="tuition-annual">
            <h2>{{ __('site.ANNUAL_TUITION_FEES') }}</h2>
            <p>{{ __('site.ANNUAL_TUITION_FEES_BRIEF') }}</p>
            <table>
                <thead>
                    <tr>
                        <th>{{ __('site.DIVISION') }}</th>
                        <th>{{ __('site.GRADE') }}</th>
                        <th>{{ __('site.ANNUAL_TUITION_JOD') }}</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($schools as $school)
                        @foreach ($school->tuitionFees as $fee)
                            <tr>
                                @if ($loop->first)
                                    <td rowspan="{{ $school->tuitionFees->count() }}">{{ $school->title }}</td>
                                @endif
                                <td>{{ $fee->title }}</td>
                                <td>{{ number_format($fee->amount) }}</td>
                            </tr>
                        @endforeach
                    @endforeach
                </tbody>
            </table>
        </section>

        {{-- Transport: Bms "tuition-transport" --}}
        <section class="tuition-transport">
            <h3>{{ __('site.TRANSPORT_BUS_FEES') }}</h3>
            @foreach ($transportFees as $fee)
                <div>
                    <h4>{{ $fee->title }}</h4>
                    <p>{{ $fee->brief }}</p>
                </div>
            @endforeach
        </section>

        {{-- Payment & withdrawal policies: Bms "tuition-policies" --}}
        <section class="tuition-policies">
            <h2>{{ __('site.PAYMENT_WITHDRAWAL_POLICIES') }}</h2>
            @foreach ($policies as $policy)
                <div>
                    <h4>{{ $policy->title }}</h4>
                    <div>{!! Content::inlineStyleToClasses($policy->content ?: $policy->brief) !!}</div>
                </div>
            @endforeach
        </section>

    @endsection

</x-layouts.layout>
