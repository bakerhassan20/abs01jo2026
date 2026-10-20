<?php

namespace App\Filament\Resources\School\Model;

use App\Filament\Resources\SchoolTab\Model\SchoolTab;
use App\Filament\Resources\TuitionFee\Model\TuitionFee;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use App\Traits\HasSeo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Scout\Searchable;

class School extends BaseTranslationModel
{
    use HasFactory, HasSeo, Searchable;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'school';

    public $translatedAttributes =
        [
            'title',
            'grades_title',
            'brief',
            'head_title',
            'head_name',
            'head_position',
            'head_content',
            'content',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'image_id',
            'head_image_id',
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

    public function headImage()
    {
        return $this->belongsTo(Media::class, 'head_image_id', 'id');
    }

    public function tabs()
    {
        return $this->hasMany(SchoolTab::class, 'school_id')->active();
    }

    public function tuitionFees()
    {
        return $this->hasMany(TuitionFee::class, 'school_id')->active();
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
