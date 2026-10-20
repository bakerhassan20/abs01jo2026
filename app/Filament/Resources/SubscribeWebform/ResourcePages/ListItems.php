<?php

namespace App\Filament\Resources\SubscribeWebform\ResourcePages;

use App\Filament\Resources\SubscribeWebform\SubscribeWebformResource;
use Filament\Resources\Pages\ListRecords;

class ListItems extends ListRecords
{
    protected static string $resource = SubscribeWebformResource::class;

    protected function getHeaderActions(): array
    {
        return [
            //Actions\CreateAction::make(),
        ];
    }


}
