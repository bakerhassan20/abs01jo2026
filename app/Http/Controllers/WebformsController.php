<?php

namespace App\Http\Controllers;

use Illuminate\View\View;

class WebformsController extends Controller
{
    public function contactUs(): View
    {
        return view('webforms.contact_us');
    }

    public function alumniStayConnected(): View
    {
        return view('webforms.alumni_stay_connected');
    }

    public function classNote(): View
    {
        return view('webforms.class_note');
    }

    public function giving(): View
    {
        return view('webforms.giving');
    }
}
