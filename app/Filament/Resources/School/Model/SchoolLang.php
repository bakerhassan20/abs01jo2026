<?php

namespace App\Filament\Resources\School\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class SchoolLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'school_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'grades_title', 'brief', 'head_title', 'head_name', 'head_position', 'head_content', 'content'];
}
