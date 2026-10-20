<?php

namespace App\Filament\Resources\Page\Model;

use App\Filament\Resources\Bms\Model\Bms;
use App\Filament\Resources\Button\Model\Button;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use App\Traits\HasHeaderImage;
use App\Traits\HasSeo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Scout\Searchable;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Artisan;
use Carbon\Carbon;

class Page extends BaseTranslationModel
{
    use HasFactory, HasSeo, HasHeaderImage, Searchable;


    protected $table = 'page';
    protected $translationForeignKey = 'parent_id';

        protected $dateFormat = 'U';


    public $translatedAttributes =
        [
            'title',
            'brief',
            'content',
            'image_id'
        ];

    protected $fillable =
        [
            'slug',
            'bms_category_id',
            'view',
            'layout',
            'image_header_id',
            'status',
            'weight_order',
            'published_at',
            'revision',
            'changed',
            'reject_note',
        ];


    /**
     * getViewList
     * @return array
     */
    public static function getViewList()
    {
        return
            [
                'page' => __('Default Page'),
                'letter' => __('Letter Page'),
                'guiding_statement' => __('Guiding Statement Page'),
                'campus' => __('Campus Page'),
                'admissions_procedure' => __('Admissions Procedure Page'),
                'apply_now' => __('Apply Now Page'),
                'development_department' => __('Development Department Page'),
                'employment' => __('Employment Page'),
                // 'page_with_collapse' => __('Page With Collapse'),
                // 'page_with_tabs' => __('Page With Tabs'),
            ];
    }

    // const MAIN_LAYOUT = 'main-inner';
    // const BUSINESS_LAYOUT = 'business';
    // const LOGIN_LAYOUT = 'login';
    // /**
    //  * getViewList
    //  * @return array
    //  */
    // public static function getLayoutList()
    // {
    //     return
    //         [
    //             self::MAIN_LAYOUT => __('Main Layout'),
    //             self::BUSINESS_LAYOUT => __('Business Layout'),
    //             self::LOGIN_LAYOUT => __('Logoin Layout'),
    //         ];
    // }



    public function mainImage()
    {
        return $this->translate()->mainImage();
    }
    public function headerImage()
    {
        return $this->belongsTo(Media::class, 'image_header_id', 'id');
    }

    public function buttons()
    {
        return $this->hasMany(Button::class, 'category_slug', 'slug');

    }

    public function frontButtons()
    {
        return $this->hasMany(Button::class, 'category_slug', 'slug')->active();
    }


    public function bmses()
    {
        return $this->hasMany(Bms::class, 'module_id')
            ->where('module_class', self::class)
            ->orderBy('category_slug')
            ->orderBy('weight_order');
    }

    public function firstSections()
    {
        return $this->hasMany(Bms::class, 'module_id')
            ->where('module_class', self::class)
            ->where('category_slug', 'first-section')
            ->where('status', true)
            ->with("translations")
            ->orderBy('weight_order');
    }




    public function makeSearchableUsing(Collection $models): Collection
    {
        return $models->load('translations');
    }

    public function toSearchableArray()
    {
        return
            [
                'title' => $this->title,
                'brief' => $this->brief,
            ];
    }

}
