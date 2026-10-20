<?php

namespace App\Filament\Resources\StudentEngagement\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StudentEngagementLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'student_engagement_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'brief', 'content', 'list_title', 'list_content'];
}
