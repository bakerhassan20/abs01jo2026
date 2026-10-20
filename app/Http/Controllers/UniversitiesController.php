<?php

namespace App\Http\Controllers;

use App\Filament\Resources\University\Model\University;

class UniversitiesController extends Controller
{
    public function index()
    {
        $data['universities'] = University::active()
            ->with(['mainImage'])
            ->paginate(setting('pagination.universities_page_size') ?? setting('pagination.default_page_size') ?? 10);

        return view('universities.index', $data);
    }
}
