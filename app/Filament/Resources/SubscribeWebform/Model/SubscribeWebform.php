<?php

namespace App\Filament\Resources\SubscribeWebform\Model;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Models\Base\BaseModelNotForAdmin;
use Illuminate\Database\Eloquent\Factories\HasFactory;


class SubscribeWebform extends BaseModelNotForAdmin
{
    use HasFactory;

       protected $dateFormat = 'U';
    protected $table = 'subscribe_webform';

    const UPDATED_AT = null;

    protected $fillable =
        [
            'email',
        ];







}
