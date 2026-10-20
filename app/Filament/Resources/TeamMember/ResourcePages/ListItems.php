<?php

namespace App\Filament\Resources\TeamMember\ResourcePages;

use App\Filament\Resources\BaseResource\Pages\ListBase;
use App\Filament\Resources\TeamMember\TeamMemberResource;

class ListItems extends ListBase
{
    protected static string $resource = TeamMemberResource::class;
}
