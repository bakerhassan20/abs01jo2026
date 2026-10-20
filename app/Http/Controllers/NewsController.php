<?php

namespace App\Http\Controllers;

use App\Classes\Utility;
use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Filament\Resources\News\Model\News;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class NewsController extends Controller
{
    public function index(Request $request)
    {
        $params = Utility::sanitize($request->only('category'));

        $data['categories'] = Cache::rememberForever(DropdownList::NEWS_CATEGORY . "_" . (new DropdownList())->getTable(), function () {
            return DropdownList::activeWithCategory(DropdownList::NEWS_CATEGORY)->get();
        });

        $data['selectedCategory'] = $params['category'] ?? null;

        $data['news'] = News::active()
            ->with(['mainImage', 'category'])
            ->when($data['selectedCategory'], function ($query, $category) {
                $query->whereHas('category', function ($query) use ($category) {
                    $query->where('slug', $category);
                });
            })
            ->paginate(setting('pagination.news_page_size') ?? setting('pagination.default_page_size') ?? 10)
            ->withQueryString();

        return view('news.index', $data);
    }

    public function view($locale, $slug)
    {
        $targetItem = News::active()
            ->with(['mainImage', 'category'])
            ->where('slug', $slug)
            ->first();

        if (! $targetItem) {
            abort(404);
        }

        $relatedNews = News::active()
            ->with(['mainImage'])
            ->where('slug', '!=', $slug)
            ->limit(3)
            ->get();

        return view('news.view', [
            'targetItem' => $targetItem,
            'relatedNews' => $relatedNews,
        ]);
    }
}
