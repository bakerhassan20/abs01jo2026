<?php

namespace App\Filament\Resources\News\Model;


use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use App\Traits\HasHeaderImage;
use App\Traits\HasSeo;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Collection;
use Laravel\Scout\Searchable;

class News extends BaseTranslationModel
{
    use HasFactory, HasSeo, HasHeaderImage, Searchable;


    protected $translationForeignKey = 'parent_id';

    protected $table = 'news';


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
            'is_campaign',
            'published_at',
            'revision',
            'changed',
            'reject_note',
            'weight_order',
            'image_id',
            'category_id',

        ];



      public function mainImage()
    {
        return $this->belongsTo(Media::class, 'image_id', 'id');
    }

    public function category()
    {
        return $this->belongsTo(DropdownList::class, 'category_id', 'id');
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
