<?php

namespace App\View\Components\Common;

use App\Filament\Resources\Bms\Model\Bms;
use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Cache;
use Illuminate\View\Component;

class NewsTicker extends Component
{
    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        $data['items'] = Cache::rememberForever("news_ticker_" . (new Bms())->getTable(), function () {
            return Bms::activeWithCategory('news-ticker')->get();
        });

        if ($data['items']->isEmpty()) {
            return "";
        }

        return view('components.common.news-ticker', $data);
    }
}
