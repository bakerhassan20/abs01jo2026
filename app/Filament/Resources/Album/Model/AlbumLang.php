<?php

namespace App\Filament\Resources\Album\Model;

use App\Models\Base\BaseLangModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class AlbumLang extends BaseLangModel
{
    use HasFactory;

    protected $table = 'album_lang';
    public $timestamps = false;
    protected $fillable = ['title', 'brief'];
}
