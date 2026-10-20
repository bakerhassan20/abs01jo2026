<?php

namespace App\Filament\Resources\TeamMember\Model;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TeamMember extends BaseTranslationModel
{
    use HasFactory;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'team_member';

    public $translatedAttributes =
        [
            'title',
            'position',
            'brief',
            'content',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'category_id',
            'image_id',
            'email',
            'linkedin_url',
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

    public function category()
    {
        return $this->belongsTo(DropdownList::class, 'category_id', 'id');
    }

}
