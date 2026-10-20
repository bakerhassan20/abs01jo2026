<?php

namespace App\Http\Controllers;

use App\Filament\Resources\School\Model\School;
use App\Filament\Resources\SchoolSubject\Model\SchoolSubject;
use Illuminate\Support\Facades\Cache;

class SchoolsController extends Controller
{
    public function index()
    {
        $data['schools'] = Cache::rememberForever("schools_index_" . (new School())->getTable(), function () {
            return School::active()
                ->with(['mainImage'])
                ->get();
        });

        return view('schools.index', $data);
    }

    public function view($locale, $slug)
    {
        $targetItem = School::active()
            ->with(['mainImage', 'headImage', 'tabs.subjects.mainImage'])
            ->where('slug', $slug)
            ->first();

        if (! $targetItem) {
            abort(404);
        }

        return view('schools.view', [
            'targetItem' => $targetItem,
        ]);
    }

    public function subject($locale, $schoolSlug, $slug)
    {
        $school = School::active()
            ->where('slug', $schoolSlug)
            ->first();

        if (! $school) {
            abort(404);
        }

        $targetItem = SchoolSubject::active()
            ->with(['mainImage', 'schoolTab'])
            ->where('slug', $slug)
            ->whereHas('schoolTab', function ($query) use ($school) {
                $query->where('school_id', $school->id);
            })
            ->first();

        if (! $targetItem) {
            abort(404);
        }

        return view('schools.subject', [
            'school' => $school,
            'targetItem' => $targetItem,
        ]);
    }
}
