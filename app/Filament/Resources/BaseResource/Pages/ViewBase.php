<?php

namespace App\Filament\Resources\BaseResource\Pages;

use App\Classes\Utility;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;
use Filament\Infolists\Infolist;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\Grid;
use Filament\Infolists\Components\KeyValueEntry;
use Filament\Infolists\Components\ViewEntry;

class ViewBase extends ViewRecord
{
    protected static string $view = 'filament.resources.view-revision';

    public function getTitle(): string
    {
        $record = $this->getRecord();
        
        if ($record->changed == 1 && $record->revision == -1) 
        {
            return "New Item Review: " . ($record->title ?? 'Item #' . $record->id);
        } 
        else 
        {
            return "Revision Comparison: " . ($record->title ?? 'Item #' . $record->id);
        }
    }

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('publish')
                ->label(_('Publish'))
                ->icon('heroicon-o-check-circle')
                ->color('success')
                ->requiresConfirmation()
                ->action(function () {
                    $this->getRecord()->update([
                        'status' =>  $this->getRecord()::STATUS_PUBLISHED,
                        'changed' => 0,
                        'revision' => 0,
                    ]);
                    
                    $this->notify('success', 'Item published successfully.');
                    return redirect()->to(static::$resource::getUrl('edit', ['record' => $this->getRecord()]));
                })
                ->visible(fn () => !$this->getRecord()->is_reviewed),

            Actions\EditAction::make()
                ->label('Edit Item')
                ->url(fn () => static::$resource::getUrl('edit', ['record' => $this->getRecord()])),
        ];
    }

    protected function getViewData(): array
    {
        $record = $this->getRecord();
        
        return [
            'record' => $record,
            'allAttributes' => $this->getFlattenedAttributes($this->loadRelation($record)),
            'viewType' => $this->getViewType($record),
            'translatableColumns' => $this->getTranslatableColumns(),
            'columnDifferences' => $this->getColumnDifferences($record),
        ];
    }

    protected function getViewType($record): string
    {
        if ( $record->isNewItemNotReviewed() ) 
        {
            return 'new_item';
        } 
        elseif ( $record->isUpdatedItemNotReviewed() ) 
        {
            return 'revision_comparison';
        }
        
        return 'unknown';
    }

    protected function getOriginalRecord($record)
    {
        if ($record->isUpdatedItemNotReviewed()) 
        {
            $originalRecord = static::$resource::getModel()::find($record->revision);
            
            // Load the same relations that exist on the current record
            if ($originalRecord) 
            {
                $this->loadRelation($originalRecord);
            }
            
            return $originalRecord;
        }
        
        return null;
    }

    protected function loadRelation(&$record)
    {
        $model = static::$resource::getModel();
        if (method_exists($model, 'translations')) 
        {
            $record->load("translations");
        }
        $record->load("creator");
        $record->load("updater");

        $relationNames = $this->getModelRelationNames($record);
        foreach ($relationNames as $relationName) {
            try {
                $record->load($relationName);
            } catch (\Exception $e) {
                // Skip relations that can't be loaded
                continue;
            }
        }
        return $record;
        
    }
    
    protected function getTranslatableColumns(): array
    {
        return $this->getRecord()->translatedAttributes??[];
    }

    protected function getColumnDifferences($record): array
    {
        if (!$record->isUpdatedItemNotReviewed()) {
            return [];
        }

        $this->loadRelation($record);
        $originalRecord = $this->getOriginalRecord($record);
        if (!$originalRecord) {
            return [];
        }
        

        $differences = [];
        
        // Get current record's flattened attributes (including translations)
        $currentFlattenedData = $this->getFlattenedAttributes($record);
        
        // Get original record's flattened attributes (including translations)
        $originalFlattenedData = $this->getFlattenedAttributes($originalRecord);
        
        //dd($currentFlattenedData, $originalFlattenedData);
        // Compare all attributes
        $allKeys = array_unique(array_merge(
            array_keys($currentFlattenedData),
            array_keys($originalFlattenedData)
        ));

        foreach ($allKeys as $key) {
            if ( in_array($key, $this->getExcludeFields()) ) {
                continue;
            }

            $currentValue = $currentFlattenedData[$key] ?? null;
            $originalValue = $originalFlattenedData[$key] ?? null;
            
            // Compare values (handle different types properly)
            if (!$this->valuesAreEqual($originalValue, $currentValue)) {
                $differences[$key] = [
                    'original' => $originalValue,
                    'new' => $currentValue,
                    'is_translatable' => $this->isTranslatableField($key, $record),
                    'is_relation' => $this->isRelationField($key),
                    'label' => $this->getColumnLabel($key, $record),
                    'type' => $this->getFieldType($key, $currentValue, $originalValue),
                ];
            }
        }
        return $differences;
    }

    protected function getModelRelationNames($record): array
    {
        $relations = [];
        $reflectionClass = new \ReflectionClass($record);
        

        foreach ($reflectionClass->getMethods(\ReflectionMethod::IS_PUBLIC) as $method) {
            if ($method->class === get_class($record) && 
                !$method->isStatic() && 
                $method->getNumberOfParameters() === 0 &&
                !in_array($method->getName(), $this->getExcludeMethods())) {
                
                try {
                    $return = $method->invoke($record);
                    if ($return instanceof \Illuminate\Database\Eloquent\Relations\Relation) {
                        $relations[] = $method->getName();
                    }
                } catch (\Exception $e) {
                    // Skip methods that throw exceptions
                    continue;
                }
            }
        }
        
        return $relations;
    }

    protected function getFlattenedAttributes($record): array
    {
        $flattened = [];
        
        // Add main model attributes
        foreach ($record->getAttributes() as $key => $value) {
            if (!in_array($key, $this->getExcludeFields())) {
                $flattened[$key] = $value;
            }
        }
        
        // Add translations if they exist
        if ($record->relationLoaded('translations') && $record->translations) {
            foreach ($record->translations as $translation) {
                $language = $translation->language ?? $translation->locale ?? 'unknown';
                
                foreach ($translation->getAttributes() as $key => $value) {
                    if (!in_array($key, $this->getExcludeFields() )) {
                        $flattened["{$key}.{$language}"] = $value;
                    }
                }
            }
        }
        
        // Add loaded relations
        $relationNames = array_keys($record->getRelations());
        $relationNames = array_diff($relationNames, ['translations']);
        foreach ($relationNames as $relationName) {
            if ($record->relationLoaded($relationName)) {
                $relationData = $record->getRelation($relationName);
                $flattened["relation.{$relationName}"] = $this->formatRelationForComparison($relationData);
            }
        }
        
        return $flattened;
    }

    public function getExcludeFields()
    {
        $defaultExcludeFields = [
            'id', 'parent_id', 'language', 'created_at', 'updated_at',
            'created_by', 'updated_by', 'status',
            'revision', 'changed', 'reject_note'
        ];

        return array_merge($defaultExcludeFields, static::$resource::getModel()::getExcludeFields() ?? []);
    }

    public function getExcludeMethods()
    {
        $defaultExcludeMethods = ['getKey', 'getTable', 'getKeyName', 'getKeyType'];

        return array_merge($defaultExcludeMethods, static::$resource::getModel()::getExcludeMethods() ?? []);
    }

    protected function formatRelationForComparison($relationData)
    {
        if ($relationData === null) {
            return null;
        }
        
        if ($relationData instanceof \Illuminate\Database\Eloquent\Collection) {
            // For collections, return array of IDs or titles
            $array= $relationData->map(function ($item) {
                return $item->title ?? $item->name ?? $item->id;
            })->toArray();
            if (!empty($array)) {
                return implode(',', $array );
            }
            return $array;
        }
        
        if ($relationData instanceof \Illuminate\Database\Eloquent\Model) {
            // For single models, return ID and title
            return $relationData->title ?? $relationData->name ?? $relationData->id;
        }
        
        return $relationData;
    }

    protected function valuesAreEqual($value1, $value2): bool
    {
        // Handle null comparisons
        if ($value1 === null && $value2 === null) {
            return true;
        }
        
        if ($value1 === null || $value2 === null) {
            return false;
        }
        
        // Handle array/object comparisons
        if (is_array($value1) && is_array($value2)) {
            return json_encode($value1) === json_encode($value2);
        }
        
        // Handle string comparisons (trim whitespace)
        if (is_string($value1) && is_string($value2)) {
            return trim($value1) === trim($value2);
        }
        
        // Default comparison
        return $value1 == $value2;
    }

    protected function isTranslatableField($key, $record): bool
    {
        // Check if the field is translatable
        if (method_exists($record, 'getTranslatableAttributes')) {
            $translatableAttributes = $record->getTranslatableAttributes();
            
            // Check if it's a direct translatable field
            if (in_array($key, $translatableAttributes)) {
                return true;
            }
            
            // Check if it's a translated field (format: field.language)
            if (strpos($key, '.') !== false) {
                $fieldName = explode('.', $key)[0];
                return in_array($fieldName, $translatableAttributes);
            }
        }
        
        return false;
    }

    protected function isRelationField($key): bool
    {
        return strpos($key, 'relation.') === 0;
    }

    protected function getFieldType($key, $newValue, $originalValue): string
    {
        if ($this->isRelationField($key)) {
            return 'relation';
        }
        
        if (strpos($key, '.') !== false) {
            return 'translation';
        }
        
        if (is_bool($newValue) || is_bool($originalValue)) {
            return 'boolean';
        }
        
        if (is_array($newValue) || is_array($originalValue)) {
            return 'array';
        }
        
        if (is_numeric($newValue) || is_numeric($originalValue)) {
            return 'numeric';
        }
        
        return 'text';
    }

    protected function getColumnLabel($key, $record): string
    {
        // Handle relation labels
        if (strpos($key, 'relation.') === 0) {
            $relationName = str_replace('relation.', '', $key);
            return ucwords(str_replace('_', ' ', $relationName)) . ' (Relation)';
        }
        
        // Handle translation labels
        if (strpos($key, '.') !== false) {
            $parts = explode('.', $key);
            $fieldName = $parts[0];
            $language = $parts[1] ?? 'unknown';
            
            return ucwords(str_replace('_', ' ', $fieldName)) . " ({$language})";
        }
        
        // Handle regular fields
        $translatableColumns = $this->getTranslatableColumns();
        if (isset($translatableColumns[$key])) {
            return $translatableColumns[$key];
        }
        
        return ucwords(str_replace('_', ' ', $key));
    }




    

}
