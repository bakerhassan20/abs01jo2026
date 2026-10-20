<?php

namespace App\Filament\Resources\GivingWebform\ResourcePages;

use App\Filament\Resources\GivingWebform\GivingWebformResource;
use Filament\Resources\Pages\ListRecords;

class ListItems extends ListRecords
{
    protected static string $resource = GivingWebformResource::class;

    protected function getHeaderActions(): array
    {
        return [
            //Actions\CreateAction::make(),
        ];
    }
}
