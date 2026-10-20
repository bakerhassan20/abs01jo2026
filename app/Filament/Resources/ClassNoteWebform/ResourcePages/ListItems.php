<?php

namespace App\Filament\Resources\ClassNoteWebform\ResourcePages;

use App\Filament\Resources\ClassNoteWebform\ClassNoteWebformResource;
use Filament\Resources\Pages\ListRecords;

class ListItems extends ListRecords
{
    protected static string $resource = ClassNoteWebformResource::class;

    protected function getHeaderActions(): array
    {
        return [
            //Actions\CreateAction::make(),
        ];
    }
}
