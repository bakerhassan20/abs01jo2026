<?php

namespace App\Filament\Resources\Faq\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class FaqLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'faq_lang';
    public $timestamps = false;
    protected $fillable = ['title','brief'];


}
