<?php

namespace App\Filament\Resources\GivingWebform;

use App\Filament\Resources\GivingWebform\Exports\Exporter;
use App\Filament\Resources\GivingWebform\Model\GivingWebform;
use App\Filament\Resources\GivingWebform\ResourcePages\ListItems;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Support\Enums\ActionSize;
use Filament\Tables;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ExportBulkAction;
use Filament\Tables\Table;

class GivingWebformResource extends Resource
{
    protected static ?string $model = GivingWebform::class;

    protected static ?string $navigationIcon = 'heroicon-o-gift';

    public static function getNavigationBadge(): ?string
    {
        return self::$model::count();
    }

    protected static ?int $navigationSort = 5;

    public static function getNavigationLabel(): string
    {
        return __("Giving Webform");
    }

    public static function getModelLabel(): string
    {
        return __("Giving Webform");
    }

    public static function getPluralLabel(): ?string
    {
        return __("Giving Webform");
    }

    public static function getPluralModelLabel(): string
    {
        return __("Giving Webform");
    }

    public static function getNavigationGroup(): ?string
    {
        return __("WebForms");
    }

    public static function form(Form $form): Form
    {
        return $form->schema([]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([

                Tables\Columns\TextColumn::make('first_name')
                    ->label(__("first name"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('last_name')
                    ->label(__("last name"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('email')
                    ->label(__("email"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('phone')
                    ->label(__("phone"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('amount')
                    ->label(__("amount"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('other_amount')
                    ->label(__("other amount"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('designation')
                    ->label(__("designation"))
                    ->searchable(),

                \App\Classes\FilamentUtility::createdAtColumn(),

            ])
            ->defaultSort('id', 'desc')
            ->striped()
            ->filters([])

            ->actions([

            ])
            ->headerActions([

                ExportAction::make()
                    ->exporter(Exporter::class)
                    ->chunkSize(500)
                    ->color("success")
                    ->icon("heroicon-o-inbox-arrow-down")
                    ->iconButton()
                    ->size(ActionSize::Large),

            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([

                    ExportBulkAction::make()
                        ->exporter(Exporter::class)
                        ->color("success")
                        ->icon("heroicon-o-inbox-arrow-down")
                        ->label("Export Spacific Columns")
                        ->chunkSize(500),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListItems::route('/'),
        ];
    }
}
