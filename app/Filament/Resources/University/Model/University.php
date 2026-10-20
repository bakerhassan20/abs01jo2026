<?php

namespace App\Filament\Resources\University\Model;

use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class University extends BaseTranslationModel
{
    use HasFactory;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'university';

    public $translatedAttributes =
        [
            'title',
            'brief',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'image_id',
            'url',
            'is_featured',
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

}
