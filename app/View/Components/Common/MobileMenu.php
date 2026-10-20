<?php

namespace App\View\Components\Common;

use App\Filament\Resources\Menu\Model\Menu;
use App\Filament\Resources\MenuLink\Model\MenuLink;
use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\View\Component;
use Illuminate\Support\Facades\Cache;

class MobileMenu extends Component
{

    public function render(): View|Closure|string
    {

       $data = [];





        $menu = Cache::rememberForever( "general_mobile". (new Menu())->getTable(), function () {
            return Menu::active()
                        ->with("translation")
                        ->where("category_slug","mega-menu")
                        ->first();
        });

        
        if(isset($menu) && $menu)
        {
            $data['menuParents'] =  Cache::rememberForever( "general_". (new MenuLink())->getTable(), function () use($menu) {
                                        return MenuLink::active()
                                                    ->where("menu_id",$menu->id)
                                                    ->where("self_parent_id", -1)
                                                    ->with("translation")
                                                    ->with("childs")
                                                    ->get();
                                    });


             return view('components.common.mobile-menu', $data);
        }



        return "";

    }
}
