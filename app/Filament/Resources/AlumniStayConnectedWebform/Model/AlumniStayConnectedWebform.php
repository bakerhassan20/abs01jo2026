<?php

namespace App\Filament\Resources\AlumniStayConnectedWebform\Model;

use App\Models\Base\BaseModelNotForAdmin;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class AlumniStayConnectedWebform extends BaseModelNotForAdmin
{
    use HasFactory;

    protected $dateFormat = 'U';
    protected $table = 'alumni_stay_connected_webform';

    const UPDATED_AT = null; // to avoid error of not have updated_at

    protected $fillable =
        [
            'first_name',
            'middle_name',
            'last_name',
            'alumni_status',
            'email',
            'mobile',
            'home_address',
            'is_alumni',
            'graduation_year',
            'current_profession',
            'universities_attended',
            'degrees_awarded',
            'listed_on_linkedin',
            'share_email',
            'is_parent',
            'spouse_is_alumni',
            'interested_activities',
            'receive_news',
            'suggestions',
        ];
}
