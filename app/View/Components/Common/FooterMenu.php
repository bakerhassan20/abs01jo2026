<?php

namespace App\View\Components\Common;

use App\Filament\Resources\Menu\Model\Menu;
use App\Filament\Resources\MenuLink\Model\MenuLink;
use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;
use Illuminate\Support\Facades\Cache;

class FooterMenu extends Component
{


    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        $data = [];





        $menu = Cache::rememberForever("footer_". (new Menu())->getTable(), function () {
            return Menu::active()
                        ->with("translation")
                        ->where("category_slug",'footer-menu')
                        ->first();
        });

        if(isset($menu) && $menu)
        {
            $data['menu'] = $menu;
            $data['menuParents'] =  Cache::rememberForever( "footer_". (new MenuLink())->getTable(), function () use($menu) {
                                        return MenuLink::active()
                                                    ->where("menu_id",$menu->id)
                                                    ->where("self_parent_id", -1)
                                                    ->with("translation")
                                                    ->with("childs")
                                                    ->get();
                                    });


            return view('components.common.footer-menu', $data);
        }

        return "";


    }
}
