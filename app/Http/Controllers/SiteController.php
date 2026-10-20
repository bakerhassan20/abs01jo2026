<?php

namespace App\Http\Controllers;

use App\Classes\Utility;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use App\Filament\Resources\Bms\Model\Bms;
use App\Filament\Resources\Menu\Model\Menu;
use App\Filament\Resources\News\Model\News;
use App\Filament\Resources\Page\Model\Page;
use App\Filament\Resources\Button\Model\Button;
use App\Filament\Resources\MenuLink\Model\MenuLink;
use App\Filament\Resources\University\Model\University;
use App\Filament\Resources\Album\Model\Album;

class SiteController extends Controller
{
    public function home($lng)
    {
        $bmsCategories =
        [
            'heroSlides' => 'home-hero',
            'whyAbs' => 'why-abs',
            'whyAbsFeatures' => 'why-abs-features',
            'factsFigures' => 'facts-figures',
            'schools' => 'home-schools',
            'achievements' => 'academic-achievements',
            'accreditations' => 'accreditations',
            'testimonials' => 'testimonials',
            'notableAlumni' => 'notable-alumni',
        ];

        foreach ($bmsCategories as $key => $category) {
            $data[$key] = Cache::rememberForever($category . '_home_' . (new Bms)->getTable(), function () use ($category) {
                return Bms::activeWithCategory($category)->get();
            });
        }

        $data['latestNews'] = Cache::rememberForever('latest_news_home_' . (new News())->getTable(), function () {
            return News::active()
                ->with(['mainImage'])
                ->limit(4)
                ->get();
        });

        $data['universities'] = Cache::rememberForever('universities_home_' . (new University())->getTable(), function () {
            return University::active()
                ->with(['mainImage'])
                ->where('is_featured', true)
                ->get();
        });

        return view('site.home', $data);
    }

    public function changeLanguage(Request $request)
    {
        $currentLocale = app()->getLocale();
        $newLocale = $currentLocale === 'ar' ? 'en' : 'ar';

        // Get the "back" URL from query string OR fallback to referer
        $previousUrl = $request->get('back', $request->headers->get('referer'));

        if ($previousUrl) {
            $urlPath = parse_url($previousUrl, PHP_URL_PATH);
            $segments = explode('/', trim($urlPath, '/'));

            // Replace first segment if it's a valid locale
            if (isset($segments[0]) && in_array($segments[0], config('app.locales'))) {
                $segments[0] = $newLocale;
            } else {
                return redirect()->route('home', ['locale' => $newLocale]);
            }

            $newUrl = '/'.implode('/', $segments);

            // Preserve query string if exists
            if ($query = parse_url($previousUrl, PHP_URL_QUERY)) {
                parse_str($query, $params);
                // sanitize if you have a helper, otherwise just rebuild
                if (class_exists(Utility::class)) {
                    $params = Utility::sanitize($params);
                }
                $newUrl .= '?'.http_build_query($params);
            }

            return redirect($newUrl);
        }

        return redirect()->route('home', ['locale' => $newLocale]);
    }

    public function search(Request $request)
    {
        $data = [];

        if ($request->isMethod('post') && ! $request->ajax()) {
            $searchData = $request->validate([
                'search_word' => 'required|min:1',
            ]);

            return redirect()->route('search', [
                'locale' => app()->getLocale(),
                'search_word' => $searchData['search_word'],
            ]);
        }

        if ($request->ajax()) {
            $dataAjaxRequest = $request->all();
            foreach ($dataAjaxRequest as $key => $requestItem) {
                if ($key == 'query') {
                    $request['search_word'] = $requestItem;
                } elseif ($key != '_token') {
                    $request['model'] = $key;
                    $request['page'] = $requestItem;
                }
            }

            $searchData = $request->validate([
                'search_word' => 'required|min:1',
                'model' => 'nullable',
            ]);

            $params = Utility::sanitize($searchData);
            $data = $this->buildSearchData($params);

            return view('site.search_ajax', $data);
        }

        $searchWord = $request->query('search_word');
        if ($searchWord) {
            $params = Utility::sanitize([
                'search_word' => $searchWord,
                'model' => $request->query('model'),
            ]);

            $data = $this->buildSearchData($params);
            $data['searchWord'] = $searchWord;
        }

        return view('site.search', $data);
    }

    private function buildSearchData(array $params): array
    {
        $data = [];
        $searchModels = Utility::getSearchModels();

        foreach ($searchModels as $key => $searchModel) {
            if (isset($params['model']) && $params['model'] != $searchModel['pagination_name']) {
                continue;
            }

            $data['searchSections'][$key]['title'] = $searchModel['title'];
            $data['searchSections'][$key]['items'] = $searchModel['model']::search($params['search_word'])
                ->query(function ($builder) use ($searchModel) {
                    $builder->active();

                    foreach ($searchModel['extra_search'] as $condation) {
                        if (is_array($condation) && count($condation) === 3) {
                            $builder->where($condation[0], $condation[1], $condation[2]);
                        }
                    }
                })
                ->paginate(setting('pagination.search') ?? setting('pagination.default'), $searchModel['pagination_name']);
               //->paginate(1, $searchModel['pagination_name']);

            $data['searchSections'][$key]['item_title'] = $searchModel['item_title'];
            $data['searchSections'][$key]['item_brief'] = $searchModel['item_brief'];
            $data['searchSections'][$key]['item_url'] = $searchModel['item_url'];
            $data['searchSections'][$key]['main_item_url'] = $searchModel['main_item_url'];
            $data['searchSections'][$key]['pagination_name'] = $searchModel['pagination_name'];
        }

        return $data;
    }

    public function index($locale, $slug)
    {

        $data['taregtPage'] = Cache::rememberForever($slug.'_page_'.(new Page)->getTable(), function () use ($slug) {
            return Page::onlyActive()
                ->where('slug', $slug)
                ->with('firstSections')
                ->first();
        });


        if (isset($data['taregtPage'])) {
            $targetPageSlug = $data['taregtPage']->slug;
            $data['buttons'] = Cache::rememberForever('pages_button'.$targetPageSlug.(new Button)->getTable(), function () use ($targetPageSlug) {
                return Button::ActiveWithCategory($targetPageSlug)->get();
            });

            // page sections are Bms items whose category slug equals the page slug
            $data['sections'] = Cache::rememberForever('pages_bms'.$targetPageSlug.(new Bms)->getTable(), function () use ($targetPageSlug) {
                return Bms::activeWithCategory($targetPageSlug)->get();
            });

            if ($data['taregtPage']->view == 'campus') {
                $data['albums'] = Cache::rememberForever('pages_albums'.$targetPageSlug.(new Album)->getTable(), function () use ($targetPageSlug) {
                    return Album::active()
                        ->with(['mainImage'])
                        ->withCount('images')
                        ->whereHas('category', function ($query) use ($targetPageSlug) {
                            $query->where('slug', $targetPageSlug);
                        })
                        ->get();
                });
            }

            return view('site.'.$data['taregtPage']->view, $data);
        }

        abort(404);
    }

    public function siteMap(){
        $slug = 'site-map';
            $data['taregtPage'] = Cache::rememberForever($slug.'_page_'.(new Page)->getTable(), function () use ($slug) {
            return Page::onlyActive()
                ->where('slug', $slug)
                ->with('firstSections')
                ->first();
        });

        if (isset($data['taregtPage'])) {
            $targetPageSlug = $data['taregtPage']->slug;
            $data['buttons'] = Cache::rememberForever('pages_button'.$targetPageSlug.(new Button)->getTable(), function () use ($targetPageSlug) {
                return Button::ActiveWithCategory($targetPageSlug)->get();
            });


        $menu = Cache::rememberForever( "sitemap_". (new Menu())->getTable(), function () {
            return Menu::active()
                        ->with("translation")
                        ->where("category_slug","site-map-menu")
                        ->first();
        });

        // var_dump($menu);
        // die;
        if(isset($menu) && $menu)
        {
            $data['menuParents'] =  Cache::rememberForever( "sitemap_". (new MenuLink())->getTable(), function () use($menu) {
                                        return MenuLink::active()
                                                    ->where("menu_id",$menu->id)
                                                    ->where("self_parent_id", -1)
                                                    ->with("translation")
                                                    ->with("childs")
                                                    ->get();
                                    });


        }

            return view('site.site_map', $data);
        }

        abort(404);
    }

    public function privacyPolicy(){

       $slug = 'privacy-policy';
            $data['taregtPage'] = Cache::rememberForever($slug.'_page_'.(new Page)->getTable(), function () use ($slug) {
            return Page::onlyActive()
                ->where('slug', $slug)
                ->with('firstSections')
                ->first();
        });

        if (isset($data['taregtPage'])) {
            $targetPageSlug = $data['taregtPage']->slug;
            $data['buttons'] = Cache::rememberForever('pages_button'.$targetPageSlug.(new Button)->getTable(), function () use ($targetPageSlug) {
                return Button::ActiveWithCategory($targetPageSlug)->get();
            });

            return view('site.privacy_policy', $data);
        }

        abort(404);
    }

    public function termsConditions(){


       $slug = 'terms-conditions';
            $data['taregtPage'] = Cache::rememberForever($slug.'_page_'.(new Page)->getTable(), function () use ($slug) {
            return Page::onlyActive()
                ->where('slug', $slug)
                ->with('firstSections')
                ->first();
        });

        if (isset($data['taregtPage'])) {
            $targetPageSlug = $data['taregtPage']->slug;
            $data['buttons'] = Cache::rememberForever('pages_button'.$targetPageSlug.(new Button)->getTable(), function () use ($targetPageSlug) {
                return Button::ActiveWithCategory($targetPageSlug)->get();
            });

            return view('site.terms_conditions', $data);
        }

        abort(404);
    }
}
