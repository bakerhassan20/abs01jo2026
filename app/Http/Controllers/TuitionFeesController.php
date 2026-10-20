<?php

namespace App\Http\Controllers;

use App\Filament\Resources\Bms\Model\Bms;
use App\Filament\Resources\Page\Model\Page;
use App\Filament\Resources\School\Model\School;
use Illuminate\Support\Facades\Cache;

class TuitionFeesController extends Controller
{
    public function index()
    {
        $data['taregtPage'] = Cache::rememberForever('tuition-fees_page_' . (new Page)->getTable(), function () {
            return Page::onlyActive()
                ->where('slug', 'tuition-fees')
                ->first();
        });

        $data['schools'] = Cache::rememberForever("tuition_fees_" . (new School())->getTable(), function () {
            return School::active()
                ->with(['tuitionFees'])
                ->whereHas('tuitionFees')
                ->get();
        });

        $data['registrationFees'] = Cache::rememberForever('tuition_registration_fees' . (new Bms)->getTable(), function () {
            return Bms::activeWithCategory('tuition-registration-fees')->get();
        });

        $data['transportFees'] = Cache::rememberForever('tuition_transport' . (new Bms)->getTable(), function () {
            return Bms::activeWithCategory('tuition-transport')->get();
        });

        $data['policies'] = Cache::rememberForever('tuition_policies' . (new Bms)->getTable(), function () {
            return Bms::activeWithCategory('tuition-policies')->get();
        });

        return view('tuition_fees.index', $data);
    }
}
