<?php

namespace App\Filament\Resources\AlumniStayConnectedWebform\Exports;

use App\Filament\Exports\BaseExporter;
use App\Filament\Resources\AlumniStayConnectedWebform\Model\AlumniStayConnectedWebform;
use Filament\Actions\Exports\ExportColumn;
use Filament\Actions\Exports\Models\Export;

class Exporter extends BaseExporter
{
    protected static ?string $model = AlumniStayConnectedWebform::class;

    public static function getColumns(): array
    {
        return [
            ExportColumn::make('id')
                ->label('ID'),
            ExportColumn::make('first_name'),
            ExportColumn::make('middle_name'),
            ExportColumn::make('last_name'),
            ExportColumn::make('alumni_status'),
            ExportColumn::make('email'),
            ExportColumn::make('mobile'),
            ExportColumn::make('home_address'),
            ExportColumn::make('is_alumni'),
            ExportColumn::make('graduation_year'),
            ExportColumn::make('current_profession'),
            ExportColumn::make('universities_attended'),
            ExportColumn::make('degrees_awarded'),
            ExportColumn::make('listed_on_linkedin'),
            ExportColumn::make('share_email'),
            ExportColumn::make('is_parent'),
            ExportColumn::make('spouse_is_alumni'),
            ExportColumn::make('interested_activities'),
            ExportColumn::make('receive_news'),
            ExportColumn::make('suggestions'),
            ExportColumn::make('created_at'),
        ];
    }

    public static function getCompletedNotificationBody(Export $export): string
    {
        $body = 'Your alumni stay connected webform export has completed and ' . number_format($export->successful_rows) . ' ' . str('row')->plural($export->successful_rows) . ' exported.';

        if ($failedRowsCount = $export->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to export.';
        }

        return $body;
    }
}
