<?php

namespace App\Filament\Resources\ClassNoteWebform\Exports;

use App\Filament\Exports\BaseExporter;
use App\Filament\Resources\ClassNoteWebform\Model\ClassNoteWebform;
use Filament\Actions\Exports\ExportColumn;
use Filament\Actions\Exports\Models\Export;

class Exporter extends BaseExporter
{
    protected static ?string $model = ClassNoteWebform::class;

    public static function getColumns(): array
    {
        return [
            ExportColumn::make('id')
                ->label('ID'),
            ExportColumn::make('first_name'),
            ExportColumn::make('last_name'),
            ExportColumn::make('email'),
            ExportColumn::make('graduation_year'),
            ExportColumn::make('university'),
            ExportColumn::make('field_of_study'),
            ExportColumn::make('occupation'),
            ExportColumn::make('location'),
            ExportColumn::make('note_type'),
            ExportColumn::make('note'),
            ExportColumn::make('social_media_links'),
            ExportColumn::make('confirmation_email'),
            ExportColumn::make('photo'),
            ExportColumn::make('share_permission'),
            ExportColumn::make('created_at'),
        ];
    }

    public static function getCompletedNotificationBody(Export $export): string
    {
        $body = 'Your class note webform export has completed and ' . number_format($export->successful_rows) . ' ' . str('row')->plural($export->successful_rows) . ' exported.';

        if ($failedRowsCount = $export->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to export.';
        }

        return $body;
    }
}
