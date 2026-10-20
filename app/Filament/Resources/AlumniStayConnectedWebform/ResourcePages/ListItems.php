<?php

namespace App\Filament\Resources\AlumniStayConnectedWebform\ResourcePages;

use App\Filament\Resources\AlumniStayConnectedWebform\AlumniStayConnectedWebformResource;
use Filament\Resources\Pages\ListRecords;

class ListItems extends ListRecords
{
    protected static string $resource = AlumniStayConnectedWebformResource::class;

    protected function getHeaderActions(): array
    {
        return [
            //Actions\CreateAction::make(),
        ];
    }
}
