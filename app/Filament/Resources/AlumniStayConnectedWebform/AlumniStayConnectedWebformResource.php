<?php

namespace App\Filament\Resources\AlumniStayConnectedWebform;

use App\Filament\Resources\AlumniStayConnectedWebform\Exports\Exporter;
use App\Filament\Resources\AlumniStayConnectedWebform\Model\AlumniStayConnectedWebform;
use App\Filament\Resources\AlumniStayConnectedWebform\ResourcePages\ListItems;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Support\Enums\ActionSize;
use Filament\Tables;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ExportBulkAction;
use Filament\Tables\Table;

class AlumniStayConnectedWebformResource extends Resource
{
    protected static ?string $model = AlumniStayConnectedWebform::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';

    public static function getNavigationBadge(): ?string
    {
        return self::$model::count();
    }

    protected static ?int $navigationSort = 3;

    public static function getNavigationLabel(): string
    {
        return __("Alumni Stay Connected Webform");
    }

    public static function getModelLabel(): string
    {
        return __("Alumni Stay Connected Webform");
    }

    public static function getPluralLabel(): ?string
    {
        return __("Alumni Stay Connected Webform");
    }

    public static function getPluralModelLabel(): string
    {
        return __("Alumni Stay Connected Webform");
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

                Tables\Columns\TextColumn::make('mobile')
                    ->label(__("mobile"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('graduation_year')
                    ->label(__("graduation year"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('alumni_status')
                    ->label(__("alumni status"))
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
