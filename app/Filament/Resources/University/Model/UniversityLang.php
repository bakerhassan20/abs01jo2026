<?php

namespace App\Filament\Resources\University\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class UniversityLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'university_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'brief'];
}
