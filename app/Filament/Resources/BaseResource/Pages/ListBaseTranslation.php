<?php

namespace App\Filament\Resources\BaseResource\Pages;

use CactusGalaxy\FilamentAstrotomic\Resources\Pages\Record\ListTranslatable;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Illuminate\Support\Facades\Cache;

class ListBaseTranslation extends ListRecords
{
    use ListTranslatable;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }



    public function getTabs(): array
    {
        $resource = static::getResource();

        return
        [
            'all' => \Filament\Resources\Components\Tab::make('All')
                    ->icon('fas-globe')
                    ->badge(Cache::rememberForever("admin_".$resource::getModelLang() . '_count', fn () => $resource::getModelLang()::query()->count()) ),

            'active' => \Filament\Resources\Components\Tab::make('Published')
                        ->icon('fas-toggle-on')
                        ->modifyQueryUsing(function (\Illuminate\Database\Eloquent\Builder $query) {
                            return $query->joinRelationship('translations')
                                ->where("status", $this->getModel()::STATUS_PUBLISHED);
                        })
                        ->badge(Cache::rememberForever("published_admin_".$resource::getModelLang() . '_count', fn () => $resource::getModelLang()::query()->where("status", $this->getModel()::STATUS_PUBLISHED)->count()) )
                        ->badgeColor('success'),

            'inactive' => \Filament\Resources\Components\Tab::make('Pending')
                        ->icon('fas-toggle-off')
                        ->modifyQueryUsing(function (\Illuminate\Database\Eloquent\Builder $query) {
                            return $query->joinRelationship('translations')
                                ->where("status", $this->getModel()::STATUS_PUBLISHED);
                        })
                        ->badge(Cache::rememberForever("pending_admin_".$resource::getModelLang() . '_count', fn () => $resource::getModelLang()::query()->where("status", $this->getModel()::STATUS_PENDING)->count()) )
                        ->badgeColor('danger'),
        ];
    }


    
}
