<?php

namespace App\Filament\Resources\ContactUsWebform\Model;

use App\Models\Base\BaseModelNotForAdmin;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class ContactUsWebform extends BaseModelNotForAdmin
{
    use HasFactory;

       protected $dateFormat = 'U';
    protected $table = 'contact_us_webform';

    const UPDATED_AT = null; // to avoid error of not have updated_at

    protected $fillable =
        [
            'name',
            'email',
            'phone',
            'department',
            'message',
            'company',
        ];






}
