<?php

namespace App\Http\Controllers;

use App\Filament\Resources\Bms\Model\Bms;
use App\Filament\Resources\StudentEngagement\Model\StudentEngagement;
use Illuminate\Support\Facades\Cache;

class StudentEngagementController extends Controller
{
    public function index()
    {
        $data['intro'] = $this->intro();

        $data['engagements'] = Cache::rememberForever("student_engagement_index_" . (new StudentEngagement())->getTable(), function () {
            return StudentEngagement::active()
                ->with(['mainImage'])
                ->get();
        });

        return view('student_engagement.index', $data);
    }

    public function view($locale, $slug)
    {
        $targetItem = StudentEngagement::active()
            ->with(['mainImage', 'secondImage', 'albums.mainImage', 'albums.images'])
            ->where('slug', $slug)
            ->first();

        if (! $targetItem) {
            abort(404);
        }

        $moreEngagements = StudentEngagement::active()
            ->with(['mainImage'])
            ->where('slug', '!=', $slug)
            ->get();

        return view('student_engagement.view', [
            'intro' => $this->intro(),
            'targetItem' => $targetItem,
            'moreEngagements' => $moreEngagements,
        ]);
    }

    private function intro()
    {
        return Cache::rememberForever("student_engagement_intro_" . (new Bms())->getTable(), function () {
            return Bms::activeWithCategory('student-engagement-intro')->first();
        });
    }
}
