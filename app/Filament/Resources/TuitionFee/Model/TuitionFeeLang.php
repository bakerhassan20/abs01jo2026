<?php

namespace App\Filament\Resources\TuitionFee\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TuitionFeeLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'tuition_fee_lang';
    public $timestamps = false;
    protected $fillable = ['title'];
}
