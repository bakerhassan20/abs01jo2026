<?php

namespace App\Filament\Resources\Bms\Model;

use App\Filament\Resources\Button\Model\Button;
use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class Bms extends BaseTranslationModel
{
    use HasFactory;

    protected $table = 'bms';
    protected $translationForeignKey = 'parent_id';

    public $translatedAttributes =
        [
            'title',
            'second_title',
            'brief',
            'image_id',
            'cover_image_id',
            'video_id',
            'image_responsive_id',
            'button_text_1',
            'content'
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'url',
            'color',
            'code',
            'category',
            'rate',
            'site_id',
            'weight_order',
            'published_at',
            'revision',
            'changed',
            'reject_note',
            'module_class',
            'module_id',
        ];


    public function scopeActiveWithCategory($query, $category)
    {
        return $query->where('status', self::STATUS_PUBLISHED)
            ->where('category', $category)
            ->with("translations")
            ->orderBy("weight_order", "ASC")
            ->orderBy("published_at", "DESC");
    }

    public static function getBmsCategoryList()
    {
        $categories = DropdownList::with('translations')->active()->where("category", DropdownList::BMS_CATEGORY)->get()->mapWithKeys(function ($i) {
            return [$i->slug => $i->title];
        });
        return $categories;
    }

    public static function getCategoryList()
    {
        return [
     /*        'TopSliderHomePage' => __('TopSliderHomePage'),
            'EducationPage' => __('Education Page'),
            'HomePageStatisticsTop' => __('HomePageStatisticsTop'),
            'Block1HomePage' => __('Block1HomePage'),
            'Block2HomePage' => __('Block2HomePage'),
            'AccordionBlocksHomPage' => __('AccordionBlocksHomPage'),
            'Credits' => __('Credits'),
            'Departments' => __('Departments'),
            'Clients' => __('Clients'),
            'homePageVideoStatistic' => __('homePageVideoStatistic'),
            'HomePageVideoDescription' => __('HomePageVideoDescription'),
            'CheckUpPackage' => __('Check Up Package'),
            'ContactIcon1' => __('Contact Icon 1'),
            'ContactIcon2' => __('Contact Icon 2'),
            'ContactIcon3' => __('Contact Icon 3'),
            'ContactIcon4' => __('Contact Icon 4'),
            'irHeader' => __('IR Header'),
            'irOverview' => __('IR Overview'),
            'irActivity' => __('IR Activity'),
            'irExpands' => __('IR expands'),
            'irInformation' => __('IR information'),
            'irhistory' => __('IR History'),
            'IVFHeaderSection' => __('IVF Header Section'),
            'IVFFirstSection' => __('IVF First Section'),
            'IVFMedicalServices' => __('IVF Medical Services'),
            'IVFCounterSection' => __('IVF Counter Section'),
            'IVFTestmonialSection' => __('IVF Testmonial Section'),
            'DiagnoseServices' => __('Diagnose Services'),
            'DiagnoseTreatmentServices' => __('Diagnose Treatment Services'),
            'ContentTaps' => __('Content Taps'),
            'InfoTaps' => __('Info Taps'),
            'ServicesBlock'=>__('Services Block'),
            'PageBms'=>__('Page BMS'),
            'OurPartners'=>__('Our Partners'), */

        ];
    }


    public static function getPageBmsCategoryList()
    {
        $categories = DropdownList::activeWithCategory(DropdownList::PAGE_BMS_CATEGORY)->get()->mapWithKeys(function ($i) {
            return [$i->slug => $i->title];
        });
        return $categories;
    }


    public function category()
    {
        return $this->belongsTo(DropdownList::class, 'category_slug', 'slug');
    }
    public function buttons()
    {
        return $this->hasMany(Button::class, 'category_slug', 'slug');

    }

    public function frontButtons()
    {
        return $this->hasMany(Button::class, 'category_slug', 'slug')->active();
    }

    public function mainImage()
    {
        $locale = app()->getLocale();

        return $this->hasOneThrough(
            Media::class,
            BmsLang::class,
            'parent_id',
            'id',
            'id',
            'image_id'
        )->where('language', $locale);
    }
    public function coverImage()
    {
        $locale = app()->getLocale();

        return $this->hasOneThrough(
            Media::class,
            BmsLang::class,
            'parent_id',
            'id',
            'id',
            'cover_image_id'
        )->where('language', $locale);
    }
    public function mainVideo()
    {
        $locale = app()->getLocale();

        return $this->hasOneThrough(
            Media::class,
            BmsLang::class,
            'parent_id',
            'id',
            'id',
            'video_id'
        )->where('language', $locale);
    }

    public function mainResponsiveImage()
    {
        $locale = app()->getLocale();

        return $this->hasOneThrough(
            Media::class,
            BmsLang::class,
            'parent_id',
            'id',
            'id',
            'image_responsive_id'
        )->where('language', $locale);
    }





}
