<?php

namespace App\Filament\Resources\Album\Model;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Filament\Resources\StudentEngagement\Model\StudentEngagement;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Album extends BaseTranslationModel
{
    use HasFactory;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'album';

    public $translatedAttributes =
        [
            'title',
            'brief',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'category_id',
            'student_engagement_id',
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

    public function images()
    {
        return $this->belongsToMany(Media::class, 'album_image', 'album_id', 'media_id')
            ->withPivot('order')
            ->orderBy('order');
    }

    public function category()
    {
        return $this->belongsTo(DropdownList::class, 'category_id', 'id');
    }

    public function studentEngagement()
    {
        return $this->belongsTo(StudentEngagement::class, 'student_engagement_id', 'id');
    }

}
