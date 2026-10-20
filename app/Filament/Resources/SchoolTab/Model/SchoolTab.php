<?php

namespace App\Filament\Resources\SchoolTab\Model;

use App\Filament\Resources\SchoolSubject\Model\SchoolSubject;
use App\Filament\Resources\School\Model\School;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class SchoolTab extends BaseTranslationModel
{
    use HasFactory;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'school_tab';

    public $translatedAttributes =
        [
            'title',
            'content',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'school_id',
            'image_id',
            'published_at',
            'revision',
            'changed',
            'reject_note',
            'weight_order',
        ];

    public function mainImage()
    {
        return $this->belongsTo(Media::class, 'image_id', 'id');
    }

    public function school()
    {
        return $this->belongsTo(School::class, 'school_id', 'id');
    }

    public function subjects()
    {
        return $this->hasMany(SchoolSubject::class, 'school_tab_id')->active();
    }

    public static function getTabList()
    {
        return self::with(['translations', 'school.translations'])->get()->mapWithKeys(function ($i) {
            return [$i->id => $i->school?->title . ' / ' . $i->title];
        });
    }

}
