<?php

namespace App\Filament\Resources\Album;

use App\Classes\CustomPackage\CustomComponent\CustomCuratorPicker;
use App\Classes\FilamentUtility;
use App\Filament\Resources\Album\Exports\Exporter;
use App\Filament\Resources\Album\Imports\Importer;
use App\Filament\Resources\Album\Model\Album;
use App\Filament\Resources\Album\ResourcePages\Create;
use App\Filament\Resources\Album\ResourcePages\Edit;
use App\Filament\Resources\Album\ResourcePages\ListItems;
use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Filament\Resources\StudentEngagement\Model\StudentEngagement;
use App\Traits\AllColumnActionVisibility;
use App\Traits\CommonActionButtons;
use Awcodes\Curator\Components\Tables\CuratorColumn;
use Awcodes\Curator\PathGenerators\DatePathGenerator;
use CactusGalaxy\FilamentAstrotomic\Forms\Components\TranslatableTabs;
use CactusGalaxy\FilamentAstrotomic\Resources\Concerns\ResourceTranslatable;
use CactusGalaxy\FilamentAstrotomic\TranslatableTab;
use Carbon\Carbon;
use Filament\Forms;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Section;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Mohamedsabil83\FilamentFormsTinyeditor\Components\TinyEditor;

class AlbumResource extends Resource
{
    use ResourceTranslatable, AllColumnActionVisibility, CommonActionButtons;

    protected static ?string $model = Album::class;

    protected static ?string $navigationIcon = 'heroicon-o-photo';

    public static function getNavigationBadge(): ?string
    {
        return self::$model::count();
    }

    protected static ?int $navigationSort = 2;

    public static function getNavigationLabel(): string
    {
        return __("Albums");
    }

    public static function getModelLabel(): string
    {
        return __("Album");
    }

    public static function getPluralLabel(): ?string
    {
        return __("Albums");
    }

    public static function getPluralModelLabel(): string
    {
        return __("Albums");
    }

    public static function getNavigationGroup(): ?string
    {
        return __("Student Engagement");
    }

    public static function form(Form $form): Form
    {
        return $form->schema([

            TranslatableTabs::make()
                ->columnSpan(2)
                ->localeTabSchema(fn(TranslatableTab $tab) => [

                    Grid::make(3)->schema([
                        Section::make()
                            ->columnSpan(2)
                            ->schema([

                                Forms\Components\TextInput::make($tab->makeName('title'))
                                    ->label(__("Title" . "[" . $tab->getLocale() . "]"))
                                    ->required()
                                    ->maxLength(255)
                                    ->notRegex('/<[^b][^r][^>]*>/')
                                    ->validationMessages([
                                        'not_regex' => 'HTML is invalid',
                                    ]),

                                Forms\Components\TextInput::make('slug')
                                    ->label(__("Slug"))
                                    ->unique(ignoreRecord: true)
                                    ->helperText('Generated Automatically')
                                    ->maxLength(255)
                                    ->readOnly()
                                    ->notRegex('/<[^b][^r][^>]*>/')
                                    ->validationMessages([
                                        'not_regex' => 'HTML is invalid',
                                    ]),

                                Forms\Components\Textarea::make($tab->makeName('brief'))
                                    ->label(__("Brief" . "[" . $tab->getLocale() . "]"))
                                    ->maxLength(1000)
                                    ->rows(4)
                                    ->notRegex('/<[^b][^r][^>]*>/')
                                    ->validationMessages([
                                        'not_regex' => 'HTML is invalid',
                                    ]),

                                CustomCuratorPicker::make('images')
                                    ->label(__("Images"))
                                    ->relationship('images', 'id')
                                    ->pathGenerator(DatePathGenerator::class)
                                    ->color('primary')
                                    ->outlined(true)
                                    ->size('md')
                                    ->constrained(true)
                                    ->orderColumn('order')
                                    ->multiple(),

                            ]),

                        Section::make()
                            ->columnSpan(1)
                            ->schema([

                                Forms\Components\DatePicker::make('published_at')
                                    ->label(__("Published At"))
                                    ->rules(['date_format:Y-m-d', 'regex:/^\d{4}-\d{2}-\d{2}$/'])
                                    ->default(Carbon::now())
                                    ->required()
                                    ->notRegex('/<[^b][^r][^>]*>/')
                                    ->validationMessages([
                                        'not_regex' => 'HTML is invalid',
                                    ]),

                                Forms\Components\Select::make('status')
                                    ->label(__("Status"))
                                    ->required()
                                    ->options(self::$model::getStatusList())
                                    ->default(self::$model::STATUS_PUBLISHED)
                                    ->native(false)
                                    ->selectablePlaceholder(false)
                                    ->notRegex('/<[^b][^r][^>]*>/')
                                    ->validationMessages([
                                        'not_regex' => 'HTML is invalid',
                                    ]),

                                Forms\Components\TextInput::make('weight_order')
                                    ->label(__("Weight Order"))
                                    ->required()
                                    ->integer()
                                    ->default(10)
                                    ->notRegex('/<[^b][^r][^>]*>/')
                                    ->validationMessages([
                                        'not_regex' => 'HTML is invalid',
                                    ]),

                                Forms\Components\Select::make('category_id')
                                    ->label(__("Category"))
                                    ->options(DropdownList::activeWithCategory(DropdownList::ALBUM_CATEGORY)->get()->pluck('title', 'id'))
                                    ->native(false)
                                    ->searchable(),

                                Forms\Components\Select::make('student_engagement_id')
                                    ->label(__("Student Engagement"))
                                    ->options(StudentEngagement::getAllItemList())
                                    ->native(false)
                                    ->searchable(),

                                CustomCuratorPicker::make('image_id')
                                    ->label(__("Cover Image"))
                                    ->pathGenerator(DatePathGenerator::class)
                                    ->size(40)
                                    ->color('primary')
                                    ->outlined(true)
                                    ->size('md')
                                    ->constrained(true)
                                    ->listDisplay(false)
                                    ->orderColumn('order')
                                    ->multiple(false),

                            ]),
                    ])
                ])

        ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([

                Tables\Columns\TextColumn::make('title')
                    ->label(__("title"))
                    ->searchable(
                        isIndividual: false,
                        query: function (Builder $query, string $search): Builder {
                            return $query
                                ->whereHas("translations", function ($query) use ($search) {
                                    $query->where('title', 'like', "%{$search}%")
                                        ->where("language", "en");
                                });
                        }
                    ),

                CuratorColumn::make('image_id')
                    ->label(__("Image"))
                    ->size(40),

                Tables\Columns\TextColumn::make('category.title')
                    ->label(__("Category")),

                Tables\Columns\TextColumn::make('studentEngagement.title')
                    ->label(__("Student Engagement")),

                \App\Classes\FilamentUtility::statusColumn(static::$model),
                \App\Classes\FilamentUtility::createdAtColumn(),
                \App\Classes\FilamentUtility::updatedAtColumn(),

                \App\Classes\FilamentUtility::creatorColumn(),
                \App\Classes\FilamentUtility::updaterColumn(),

            ])
            ->defaultSort(function (Builder $query): Builder {
                return $query
                    ->orderBy('weight_order', 'asc')
                    ->orderBy('published_at', 'desc');
            })
            ->striped()

            ->filters(
                static::renderFilterActions([
                    Tables\Filters\SelectFilter::make('category_id')
                        ->label(__("Category"))
                        ->options(fn () => DropdownList::activeWithCategory(DropdownList::ALBUM_CATEGORY)->get()->pluck('title', 'id')),
                ]),
            )

            ->actions(
                static::renderTableActions(),
            )

            ->headerActions(
                static::renderHeaderActions(Importer::class, Exporter::class),
            )

            ->bulkActions([
                Tables\Actions\BulkActionGroup::make(
                    static::renderBulkActions(Exporter::class)
                ),
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
            'create' => Create::route('/create'),
            'edit' => Edit::route('/{record}/edit'),
        ];
    }
}
