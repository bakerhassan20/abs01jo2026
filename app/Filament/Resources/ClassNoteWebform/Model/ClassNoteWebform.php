<?php

namespace App\Filament\Resources\ClassNoteWebform\Model;

use App\Models\Base\BaseModelNotForAdmin;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ClassNoteWebform extends BaseModelNotForAdmin
{
    use HasFactory;

    protected $dateFormat = 'U';
    protected $table = 'class_note_webform';

    const UPDATED_AT = null; // to avoid error of not have updated_at

    protected $fillable =
        [
            'first_name',
            'last_name',
            'email',
            'graduation_year',
            'university',
            'field_of_study',
            'occupation',
            'location',
            'note_type',
            'note',
            'social_media_links',
            'confirmation_email',
            'photo',
            'share_permission',
        ];
}
