<?php

namespace App\Filament\Resources\TeamMember\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class TeamMemberLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'team_member_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'position', 'brief', 'content'];
}
