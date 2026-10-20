<?php

namespace App\Filament\Resources\Faq\Model;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Filament\Resources\FaqCategory\Model\FaqCategory;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Faq extends BaseTranslationModel
{
    use HasFactory;


    protected $translationForeignKey = 'parent_id';

    protected $table = 'faq';


    public $translatedAttributes =
        [
            'title',
            'brief',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'module_id',
            'module_class',
            'published_at',
            'revision',
            'changed',
            'reject_note',
            'weight_order',
        ];


}
