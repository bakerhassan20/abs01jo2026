<?php

namespace App\Filament\Resources\SubscribeWebform;



use CactusGalaxy\FilamentAstrotomic\Resources\Concerns\ResourceTranslatable;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Support\Enums\ActionSize;
use Filament\Tables\Actions\ExportBulkAction;
use Filament\Tables\Actions\ExportAction;
use App\Filament\Resources\SubscribeWebform\Exports\Exporter;
use App\Filament\Resources\SubscribeWebform\Model\SubscribeWebform;
use App\Filament\Resources\SubscribeWebform\ResourcePages\ListItems;
use Filament\Tables;
use Filament\Tables\Table;


class SubscribeWebformResource extends Resource
{
    use ResourceTranslatable;

    protected static ?string $model = SubscribeWebform::class;

    protected static ?string $navigationIcon = 'heroicon-s-phone';

    public static function getNavigationBadge(): ?string
    {
        return self::$model::count();
    }

    protected static ?int $navigationSort = 1;

    public static function getNavigationLabel(): string
    {
        return __("Subscribe Webform");
    }

    public static function getModelLabel(): string
    {
        return __("Subscribe Webform");
    }

    public static function getPluralLabel(): ?string
    {
        return __("Subscribe Webform");
    }

    public static function getPluralModelLabel(): string
    {
        return __("Subscribe Webform");
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

                Tables\Columns\TextColumn::make('email')
                    ->label(__("email"))
                    ->searchable(),

                \App\Classes\FilamentUtility::createdAtColumn(),



            ])
            ->defaultSort('id','desc')
            ->striped()
            ->filters([
               
            ])

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
