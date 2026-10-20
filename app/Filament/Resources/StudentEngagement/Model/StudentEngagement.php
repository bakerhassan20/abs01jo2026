<?php

namespace App\Filament\Resources\StudentEngagement\Model;

use App\Filament\Resources\Album\Model\Album;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use App\Traits\HasHeaderImage;
use App\Traits\HasSeo;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Laravel\Scout\Searchable;

class StudentEngagement extends BaseTranslationModel
{
    use HasFactory, HasSeo, HasHeaderImage, Searchable;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'student_engagement';

    public $translatedAttributes =
        [
            'title',
            'brief',
            'content',
            'list_title',
            'list_content',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'image_id',
            'second_image_id',
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

    public function secondImage()
    {
        return $this->belongsTo(Media::class, 'second_image_id', 'id');
    }

    public function albums()
    {
        return $this->hasMany(Album::class, 'student_engagement_id')->active();
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
