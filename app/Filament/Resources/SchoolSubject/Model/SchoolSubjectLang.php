<?php

namespace App\Filament\Resources\SchoolSubject\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class SchoolSubjectLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'school_subject_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'brief', 'content'];
}
