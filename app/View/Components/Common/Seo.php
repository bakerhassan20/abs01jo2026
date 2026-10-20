<?php

namespace App\View\Components\Common;

use App\Filament\Resources\Seo\Model\Seo as ModelSeo;
use App\Models\Media\Media;
use Closure;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Lang;
use Illuminate\Support\Facades\Request;
use Illuminate\View\Component;

class Seo extends Component
{
    /**
     * Create a new component instance.
     */
    public function __construct(

        public $seoTitle = null,
        public $seoDescription = null,
        public $seoKeywords = null,
        public $seoAuther = null,
        public $seoImage = null,
        public $seoOGType = null,
        public $seoTwitterType = null,
        public $seoSchema = [],
    ) {}

    /**
     * Get the view / contents that represent the component.
     */
    public function render(): View|Closure|string
    {
        $path = "/" . str_replace( Lang::locale() , "", Request::path() );

        $lng = Lang::locale();

        $seoItem =  Cache::rememberForever( $path."_seo_item". (new ModelSeo())->getTable(), function () use($path) {
                        return ModelSeo::where("path", $path)->first();
                    });
        if ($seoItem)
        {
            $this->seoTitle = $seoItem->title ?? $this->seoTitle;
            $this->seoDescription = $seoItem->description ?? $this->seoDescription;
            $this->seoKeywords = $seoItem->keywords ?? $this->seoKeywords;
            $this->seoAuther = $seoItem->author ?? $this->seoAuther;
            $this->seoImage = $seoItem->image ?? $this->seoImage;
        }

        $seoImage = Cache::rememberForever( "seo_image". (new Media())->getTable(), function () use($lng) {
                        return Media::where("id", setting("{$lng}.general.seo_image"))->first();
                    });

        $data["title"]       =   $this->seoTitle ?? setting("{$lng}.general.title");
        $data["brief"]       =   $this->seoDescription ?? setting("{$lng}.general.description");
        $data["author"]      =   $this->seoAuther ?? "dotjo";
        $data["keyword"]     =   $this->seoKeywords ?? setting("{$lng}.general.keywords");
        $data["image"]       =   $this->seoImage ?? $seoImage?->url ;
        $data["ogType"]      =   $this->seoOGType ?? "website";
        $data["twitterType"] =   $this->seoTwitterType ?? "summary";
        $data["schema"]      =   $this->seoSchema;

        return view('components.common.seo', $data);
    }
}
