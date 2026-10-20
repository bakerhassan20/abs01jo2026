<?php

namespace App\Filament\Resources\TuitionFee\Model;

use App\Filament\Resources\School\Model\School;
use App\Models\Base\BaseTranslationModel;
use App\Models\Media\Media;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TuitionFee extends BaseTranslationModel
{
    use HasFactory;

    protected $translationForeignKey = 'parent_id';

    protected $table = 'tuition_fee';

    public $translatedAttributes =
        [
            'title',
        ];

    protected $fillable =
        [
            'slug',
            'status',
            'school_id',
            'academic_year',
            'amount',
            'published_at',
            'revision',
            'changed',
            'reject_note',
            'weight_order',
        ];

    public function school()
    {
        return $this->belongsTo(School::class, 'school_id', 'id');
    }

}
