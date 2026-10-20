<?php

namespace App\Filament\Resources\GivingWebform\Exports;

use App\Filament\Exports\BaseExporter;
use App\Filament\Resources\GivingWebform\Model\GivingWebform;
use Filament\Actions\Exports\ExportColumn;
use Filament\Actions\Exports\Models\Export;

class Exporter extends BaseExporter
{
    protected static ?string $model = GivingWebform::class;

    public static function getColumns(): array
    {
        return [
            ExportColumn::make('id')
                ->label('ID'),
            ExportColumn::make('amount'),
            ExportColumn::make('other_amount'),
            ExportColumn::make('designation'),
            ExportColumn::make('tribute'),
            ExportColumn::make('on_behalf_of_organization'),
            ExportColumn::make('organization_name'),
            ExportColumn::make('title'),
            ExportColumn::make('first_name'),
            ExportColumn::make('last_name'),
            ExportColumn::make('email'),
            ExportColumn::make('phone'),
            ExportColumn::make('country'),
            ExportColumn::make('address'),
            ExportColumn::make('city'),
            ExportColumn::make('state_zip'),
            ExportColumn::make('is_anonymous'),
            ExportColumn::make('appear_in_donor_report'),
            ExportColumn::make('donor_type'),
            ExportColumn::make('comment'),
            ExportColumn::make('confirmation_email'),
            ExportColumn::make('created_at'),
        ];
    }

    public static function getCompletedNotificationBody(Export $export): string
    {
        $body = 'Your giving webform export has completed and ' . number_format($export->successful_rows) . ' ' . str('row')->plural($export->successful_rows) . ' exported.';

        if ($failedRowsCount = $export->getFailedRowsCount()) {
            $body .= ' ' . number_format($failedRowsCount) . ' ' . str('row')->plural($failedRowsCount) . ' failed to export.';
        }

        return $body;
    }
}
