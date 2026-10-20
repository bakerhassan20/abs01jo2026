<?php

namespace App\Filament\Resources\Faq\ResourcePages;

use App\Filament\Resources\BaseResource\Pages\CreateBase;
use App\Filament\Resources\City\CityResource;
use App\Filament\Resources\Faq\FaqResource;

class Create extends CreateBase
{
    protected static string $resource = FaqResource::class;
}
