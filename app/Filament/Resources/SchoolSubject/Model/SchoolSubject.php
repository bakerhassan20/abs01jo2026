<?php

namespace App\Filament\Resources\SchoolSubject\Model;

use App\Filament\Resources\SchoolTab\Model\SchoolTab;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use App\Traits\HasSeo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Scout\Searchable;

class SchoolSubject extends BaseTranslationModel
{
    use HasFactory, HasSeo, Searchable;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'school_subject';

    public $translatedAttributes =
        [
            'title',
            'brief',
            'content',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'school_tab_id',
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

    public function schoolTab()
    {
        return $this->belongsTo(SchoolTab::class, 'school_tab_id', 'id');
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
