<?php

namespace App\Http\Controllers;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Filament\Resources\News\Model\News;
use App\Filament\Resources\Page\Model\Page;
use Illuminate\Support\Facades\Cache;

class AlumniController extends Controller
{
    const ALUMNI_NEWS_CATEGORY = 'alumni-news';

    public function index()
    {
        $data['taregtPage'] = Cache::rememberForever('alumni_page_' . (new Page)->getTable(), function () {
            return Page::onlyActive()
                ->where('slug', 'alumni')
                ->first();
        });

        $data['news'] = News::active()
            ->with(['mainImage'])
            ->whereHas('category', function ($query) {
                $query->where('slug', self::ALUMNI_NEWS_CATEGORY);
            })
            ->limit(3)
            ->get();

        return view('alumni.index', $data);
    }

    public function news()
    {
        $data['categories'] = Cache::rememberForever(DropdownList::NEWS_CATEGORY . "_" . (new DropdownList())->getTable(), function () {
            return DropdownList::activeWithCategory(DropdownList::NEWS_CATEGORY)->get();
        });

        $data['news'] = News::active()
            ->with(['mainImage'])
            ->whereHas('category', function ($query) {
                $query->where('slug', self::ALUMNI_NEWS_CATEGORY);
            })
            ->paginate(setting('pagination.news_page_size') ?? setting('pagination.default_page_size') ?? 10);

        return view('alumni.news', $data);
    }
}
