<?php

namespace App\Filament\Resources\SchoolTab\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class SchoolTabLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'school_tab_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'content'];
}
