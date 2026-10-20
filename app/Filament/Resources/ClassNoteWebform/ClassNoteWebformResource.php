<?php

namespace App\Filament\Resources\ClassNoteWebform;

use App\Filament\Resources\ClassNoteWebform\Exports\Exporter;
use App\Filament\Resources\ClassNoteWebform\Model\ClassNoteWebform;
use App\Filament\Resources\ClassNoteWebform\ResourcePages\ListItems;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Support\Enums\ActionSize;
use Filament\Tables;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Actions\ExportBulkAction;
use Filament\Tables\Table;

class ClassNoteWebformResource extends Resource
{
    protected static ?string $model = ClassNoteWebform::class;

    protected static ?string $navigationIcon = 'heroicon-o-pencil-square';

    public static function getNavigationBadge(): ?string
    {
        return self::$model::count();
    }

    protected static ?int $navigationSort = 4;

    public static function getNavigationLabel(): string
    {
        return __("Class Note Webform");
    }

    public static function getModelLabel(): string
    {
        return __("Class Note Webform");
    }

    public static function getPluralLabel(): ?string
    {
        return __("Class Note Webform");
    }

    public static function getPluralModelLabel(): string
    {
        return __("Class Note Webform");
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

                Tables\Columns\TextColumn::make('graduation_year')
                    ->label(__("graduation year"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('note_type')
                    ->label(__("note type"))
                    ->searchable(),

                Tables\Columns\TextColumn::make('location')
                    ->label(__("location"))
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
