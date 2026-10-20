<?php

namespace App\Filament\Resources\GivingWebform\Model;

use App\Models\Base\BaseModelNotForAdmin;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class GivingWebform extends BaseModelNotForAdmin
{
    use HasFactory;

    protected $dateFormat = 'U';
    protected $table = 'giving_webform';

    const UPDATED_AT = null; // to avoid error of not have updated_at

    protected $fillable =
        [
            'amount',
            'other_amount',
            'designation',
            'tribute',
            'on_behalf_of_organization',
            'organization_name',
            'title',
            'first_name',
            'last_name',
            'email',
            'phone',
            'country',
            'address',
            'city',
            'state_zip',
            'is_anonymous',
            'appear_in_donor_report',
            'donor_type',
            'comment',
            'confirmation_email',
        ];
}
