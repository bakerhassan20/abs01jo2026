<?php

namespace App\Http\Controllers;

use App\Filament\Resources\Album\Model\Album;

class AlbumsController extends Controller
{
    public function index()
    {
        $data['albums'] = Album::active()
            ->with(['mainImage'])
            ->withCount('images')
            ->paginate(setting('pagination.default_page_size') ?? 10);

        return view('albums.index', $data);
    }

    public function view($locale, $slug)
    {
        $targetItem = Album::active()
            ->with(['mainImage', 'images'])
            ->where('slug', $slug)
            ->first();

        if (! $targetItem) {
            abort(404);
        }

        return view('albums.view', [
            'targetItem' => $targetItem,
        ]);
    }
}
