<?php

namespace App\Filament\Resources\DropdownList\Model;

use App\Models\Base\BaseTranslationModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class DropdownList extends BaseTranslationModel
{
    use HasFactory;


    protected $table = 'dropdown_list';
    protected $translationForeignKey = 'parent_id';
    protected $dateFormat = "U";


    public $translatedAttributes =
        [
            'title',
            'second_title',
            'content',
            'image_id',

        ];

    protected $fillable =
        [
            'slug',
            'status',
            'category',
            'published_at',
            'weight_order',
            'changed',
            'reject_note',
            'revision'
        ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'published_at' => 'datetime',
    ];

    public function scopeActiveWithCategory($query, $slug)
    {
        return $query->where('status', self::STATUS_PUBLISHED)
            ->where('category', $slug)
            ->with("translations")
            ->orderBy("weight_order", "ASC")
            ->orderBy("published_at", "DESC");
    }


    const MENU_CATEGORY = 'Menu Category';
    const BMS_CATEGORY = "Bms Category";
    const BUTTON_CATEGORY = "Button Category";
    const DEPARTMENTS = 'Departments';
    const PAGE_BMS_CATEGORY = "Page Bms Category";
    const SUBJECTS = "Subjects";
    const NEWS_CATEGORY = "News Category";
    const TEAM_CATEGORY = "Team Category";
    const ALBUM_CATEGORY = "Album Category";

    // WEB FORMS //
    const ALUMNI_STATUS = "Alumni Status";
    const ALUMNI_ACTIVITIES = "Alumni Activities";
    const CLASS_NOTE_TYPE = "Class Note Type";
    const GIVING_DESIGNATION = "Giving Designation";
    const GIVING_TRIBUTE = "Giving Tribute";
    const NAME_TITLE = "Name Title";
    const DONOR_TYPE = "Donor Type";








    /**
     * getTypeList
     * @return array
     */
    public static function getCategoryList()
    {
        return
            [
                self::MENU_CATEGORY => __('Menu Category'),
                self::BUTTON_CATEGORY => __('Button Category'),
                self::BMS_CATEGORY => __("Bms Category"),
                self::DEPARTMENTS => __('Departments'),
                self::PAGE_BMS_CATEGORY => __("Page Bms Category"),
                self::SUBJECTS => __("Subjects"),
                self::NEWS_CATEGORY => __("News Category"),
                self::TEAM_CATEGORY => __("Team Category"),
                self::ALBUM_CATEGORY => __("Album Category"),
                self::ALUMNI_STATUS => __("Alumni Status"),
                self::ALUMNI_ACTIVITIES => __("Alumni Activities"),
                self::CLASS_NOTE_TYPE => __("Class Note Type"),
                self::GIVING_DESIGNATION => __("Giving Designation"),
                self::GIVING_TRIBUTE => __("Giving Tribute"),
                self::NAME_TITLE => __("Name Title"),
                self::DONOR_TYPE => __("Donor Type"),

        
            ];
    }






    public function mainImage()
    {
        return $this->translate()->mainImage();
    }

  
}
