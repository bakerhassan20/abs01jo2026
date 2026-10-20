<?php

namespace App\Filament\Pages\Settings;

use App\Classes\CustomPackage\CustomComponent\CustomCuratorPicker;
use App\Jobs\ClearCaches;
use App\Models\Setting\Setting;
use Awcodes\Curator\PathGenerators\DatePathGenerator;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use CactusGalaxy\FilamentAstrotomic\Forms\Components\TranslatableTabs;
use CactusGalaxy\FilamentAstrotomic\TranslatableTab;
use Closure;
use Filament\Forms\Components\Checkbox;
use Filament\Forms\Components\ColorPicker;
use Filament\Forms\Components\Field;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Tabs;
use Filament\Forms\Components\TextInput;
use Filament\Support\Exceptions\Halt;
use Filament\Support\Facades\FilamentView;
use Illuminate\Support\HtmlString;
use Illuminate\Support\Str;
use Outerweb\FilamentSettings\Filament\Pages\Settings as BaseSettings;

class AllSetting extends BaseSettings
{
    use HasPageShield;

    protected static ?int $navigationSort = 1;

    public static function getNavigationLabel(): string
    {
        return __('admin.All Setting');
    }

    public static function getNavigationGroup(): ?string
    {
        return __('Setting');
    }

    public function schema(): array|Closure
    {
        return [

            TranslatableTabs::make()
                ->columnSpan(2)
                ->localeTabSchema(fn (TranslatableTab $tab) => [

                    Tabs::make('Settings')
                        ->schema([
                            Tabs\Tab::make('General')
                                ->schema([

                                    TextInput::make($tab->makeName('general.title'))
                                        ->label(__('Title['.$tab->getLocale().']'))
                                        ->required()
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->maxLength(255)
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ]),

                                    TextInput::make($tab->makeName('general.description'))
                                        ->label(__('Description['.$tab->getLocale().']'))
                                        ->required()
                                        ->maxLength(255)
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ]),

                                    TextInput::make($tab->makeName('general.keywords'))
                                        ->label(__('Keywords ['.$tab->getLocale().']'))
                                        ->required()
                                        ->maxLength(255)
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ]),

                                    CustomCuratorPicker::make($tab->makeName('general.seo_image'))
                                        ->label(__('Seo Image ['.$tab->getLocale().']'))
                                        ->pathGenerator(DatePathGenerator::class)
                                        ->size(40)
                                        ->color('primary')
                                        ->outlined(true)
                                        ->size('md')
                                        ->constrained(true)
                                        ->orderColumn('order')
                                        ->required(),

                                    Checkbox::make('general.activate_otp'),

                                    Select::make('general.date_format')
                                        ->label(__('Date Format'))
                                        ->required()
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ])
                                        ->options(Setting::getDateFormats())
                                        ->placeholder(__('Select Date Format')),

                                    Select::make('general.time_format')
                                        ->label(__('Time Format'))
                                        ->required()
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ])
                                        ->options(Setting::getTimeFormats())
                                        ->placeholder(__('Select Time Format')),

                                    Select::make('general.time_zone')
                                        ->label(__('Time Zone'))
                                        ->required()
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ])
                                        ->options(Setting::getTimezones())
                                        ->placeholder(__('Select Time Zone'))
                                        ->searchable(),

                                    TextInput::make('general.google_site_verification')
                                        ->maxLength(255)
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ]),

                                    TextInput::make('general.filament_id')
                                        ->required()
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->maxLength(255)
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ]),

                                    TextInput::make('general.filament_path')
                                        ->required()
                                        ->notRegex('/<[^b][^r][^>]*>/')
                                        ->maxLength(255)
                                        ->validationMessages([
                                            'not_regex' => 'HTML is invalid',
                                        ]),

                                    Section::make('Google Recaptcha')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('general.google_recaptcha_site_key')
                                                ->label(__('Google Recaptcha Site Key'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.google_recaptcha_secret')
                                                ->label(__('Google Recaptcha Secret'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                    Section::make('SMTP Setting')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('general.smtp_host')
                                                ->label(__('SMTP Host'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.smtp_port')
                                                ->label(__('SMTP PORT'))
                                                ->integer()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.smtp_encryption')
                                                ->label(__('SMTP Encryption'))
                                                ->maxLength(5)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.smtp_username')
                                                ->label(__('SMTP User Name'))
                                                ->maxLength(255)
                                                ->email()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.smtp_password')
                                                ->label(__('SMTP Password'))
                                                ->password()
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                    Section::make('Relate Your site with External Analytics')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('general.google_analytics_code')
                                                ->label(__('Google Analytics Code'))
                                                ->maxLength(255)
                                                ->helperText(new HtmlString('<p> For More Info  <a style="color:rgb(var(--primary-600));" href="https://chartio.com/learn/marketing-analytics/how-to-add-google-analytics-tracking-to-a-website/#google-analytics-tracking-code" target="blank" rel="noopener noreferrer nofollow" > Click Here</a> </p>'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.google_tag_code')
                                                ->label(__('Google Tag Code'))
                                                ->maxLength(255)
                                                ->helperText(new HtmlString('<p> For More Info  <a style="color:rgb(var(--primary-600));" href="https://chartio.com/learn/marketing-analytics/how-to-add-google-analytics-tracking-to-a-website/#google-tag-manager" target="blank" rel="noopener noreferrer nofollow" > Click Here</a> </p>'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.meta_pixel_code')
                                                ->label(__('Meta Pixel Code'))
                                                ->maxLength(255)
                                                ->helperText(new HtmlString('<p> For More Info  <a style="color:rgb(var(--primary-600));" href="https://disruptiveadvertising.com/blog/social-media/how-to-set-up-install-meta-pixel/" target="blank" rel="noopener noreferrer nofollow" > Click Here</a> </p>'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.clarity_code')
                                                ->label(__('Clarity Code'))
                                                ->maxLength(255)
                                                ->helperText(new HtmlString('<p> For More Info  <a style="color:rgb(var(--primary-600));" href="https://learn.microsoft.com/en-us/clarity/setup-and-installation/about-clarity" target="blank" rel="noopener noreferrer nofollow" > Click Here</a> </p>'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('general.hotjar_code')
                                                ->label(__('Hot Jar Code'))
                                                ->maxLength(255)
                                                ->helperText(new HtmlString('<p> For More Info  <a style="color:rgb(var(--primary-600));" href="https://www.hotjar.com/" target="blank" rel="noopener noreferrer nofollow" > Click Here</a> </p>'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                ]),
                            Tabs\Tab::make('Site')
                                ->schema([
                                    Section::make('Logo, Favicon and Main Color')
                                        ->collapsed()
                                        ->schema([

                                            CustomCuratorPicker::make($tab->makeName('site.logo'))
                                                ->label(__('Logo['.$tab->getLocale().']'))
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order')
                                                ->required(),

                                            CustomCuratorPicker::make($tab->makeName('site.footer_background'))
                                                ->label(__('Footer Background Image['.$tab->getLocale().']'))
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order'),
                                            // ->required()

                                            CustomCuratorPicker::make($tab->makeName('site.icon'))
                                                ->label(__('Icon['.$tab->getLocale().']'))
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order')
                                                ->required(),

                                            CustomCuratorPicker::make($tab->makeName('site.alternative_news_blog'))
                                                ->label(__('Alternative News Image').'['.$tab->getLocale().']')
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order'),

                                            CustomCuratorPicker::make($tab->makeName('site.alternative_header_image'))
                                                ->label(__('Alternative Header Image['.$tab->getLocale().']'))
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order'),
                                            // ->required(),
                                            CustomCuratorPicker::make($tab->makeName('site.alternative_news_header_image'))
                                                ->label(__('Alternative News Header Image['.$tab->getLocale().']'))
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order'),

                                            ColorPicker::make('site.admin_panel_color')
                                                ->label(__('Admin Panel Color'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                    Section::make('Pagination')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('pagination.default_page_size')
                                                ->label(__('Defaultl'))
                                                ->integer()
                                                ->minValue(1)
                                                ->default(10)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            // TextInput::make('pagination.category_page_size')
                                            // ->label(__("Paginatoin Article at category pages"))
                                            // ->integer()
                                            // ->minValue(1)
                                            // ->default(10)
                                            // ->notRegex('/<[^b][^r][^>]*>/')
                                            // ->validationMessages([
                                            //     'not_regex' => 'HTML is invalid',
                                            // ]),

                                            // TextInput::make('pagination.article_page_size')
                                            // ->label(__("Paginatoin Article Page"))
                                            // ->integer()
                                            // ->minValue(1)
                                            // ->default(10)
                                            // ->notRegex('/<[^b][^r][^>]*>/')
                                            // ->validationMessages([
                                            //     'not_regex' => 'HTML is invalid',
                                            // ]),

                                            // TextInput::make('pagination.gallery_page_size')
                                            // ->label(__("Paginatoin Gallery Page"))
                                            // ->integer()
                                            // ->minValue(1)
                                            // ->default(10)
                                            // ->notRegex('/<[^b][^r][^>]*>/')
                                            // ->validationMessages([
                                            //     'not_regex' => 'HTML is invalid',
                                            // ]),

                                            TextInput::make('pagination.news_page_size')
                                                ->label(__('News'))
                                                ->integer()
                                                ->minValue(1)
                                                ->default(10)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('pagination.universities_page_size')
                                                ->label(__('Universities'))
                                                ->integer()
                                                ->minValue(1)
                                                ->default(10)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('pagination.search_page_size')
                                                ->label(__('Search'))
                                                ->integer()
                                                ->minValue(1)
                                                ->default(10)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                    Section::make('Webform Email List')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('site.contact_us_email_list')
                                                ->label(__('Contact Us Email List'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.subscribe_email_list')
                                                ->label(__('Subscribe Email List'))
                                                ->maxLength(255)
                                                ->helperText(__('Comma separated emails'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.alumni_stay_connected_email_list')
                                                ->label(__('Alumni Stay Connected Email List'))
                                                ->maxLength(255)
                                                ->helperText(__('Comma separated emails'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.class_note_email_list')
                                                ->label(__('Class Note Email List'))
                                                ->maxLength(255)
                                                ->helperText(__('Comma separated emails'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.giving_email_list')
                                                ->label(__('Giving Email List'))
                                                ->maxLength(255)
                                                ->helperText(__('Comma separated emails'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                    Section::make('Header & External Links')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('site.portal_url')
                                                ->label(__('ABS Portal URL'))
                                                ->maxLength(500)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.apply_now_url')
                                                ->label(__('Apply Now URL'))
                                                ->maxLength(500)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.calendar_url')
                                                ->label(__('Calendar URL'))
                                                ->maxLength(500)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.book_tour_url')
                                                ->label(__('Book A Tour URL'))
                                                ->maxLength(500)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.careers_url')
                                                ->label(__('Careers Page URL'))
                                                ->maxLength(500)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.tes_jobs_url')
                                                ->label(__('Tes Jobs URL'))
                                                ->maxLength(500)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                    Section::make('Contact Information')
                                        ->collapsed()
                                        ->schema([

                                            TextInput::make('site.main_phone')
                                                ->label(__('Main Phone'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.second_phone')
                                                ->label(__('Second Phone'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.main_email')
                                                ->label(__('Main Email'))
                                                ->maxLength(255)
                                                ->email()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.second_email')
                                                ->label(__('Second Email'))
                                                ->maxLength(255)
                                                ->email()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make($tab->makeName('site.location'))
                                                ->label(__('Location['.$tab->getLocale().']'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make($tab->makeName('site.mailbox'))
                                                ->label(__('Mailbox['.$tab->getLocale().']'))
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            Placeholder::make('business_hours_label')
                                                ->label(__('Business Hours'))
                                                ->columnSpan('full'),

                                            Grid::make()
                                                ->schema([
                                                    TextInput::make($tab->makeName('site.business_hours_from'))
                                                        ->label(__('From['.$tab->getLocale().']'))
                                                        ->maxLength(255)
                                                        ->notRegex('/<[^b][^r][^>]*>/')
                                                        ->validationMessages(['not_regex' => 'HTML is invalid']),

                                                    TextInput::make($tab->makeName('site.business_hours_to'))
                                                        ->label(__('To['.$tab->getLocale().']'))
                                                        ->maxLength(255)
                                                        ->notRegex('/<[^b][^r][^>]*>/')
                                                        ->validationMessages(['not_regex' => 'HTML is invalid']),
                                                ])->columns(2),

                                            TextInput::make($tab->makeName('site.location_url'))
                                                ->label(__('Location Url ['.$tab->getLocale().']'))
                                                ->maxLength(300)
                                               // ->activeUrl()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.whatsApp')
                                                ->label(__('WhatsApp URL'))
                                                ->placeholder('https://wa.me/9665xxxxxxx')
                                                ->maxLength(300)
                                                ->url()
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'url' => 'Invalid WhatsApp URL',
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            TextInput::make('site.youtube')
                                                ->label(__('YouTube URL'))
                                                ->placeholder('https://youtube.com/@channel')
                                                ->maxLength(300)
                                                ->url(),
                                            TextInput::make('site.linkedin')
                                                ->label(__('LinkedIn URL'))
                                                ->placeholder('https://linkedin.com/company/your-company')
                                                ->maxLength(300)
                                                ->url(),

                                            TextInput::make('site.instagram')
                                                ->label(__('Instagram URL'))
                                                ->placeholder('https://instagram.com/username')
                                                ->maxLength(300)
                                                ->url(),

                                            TextInput::make('site.facebook')
                                                ->label(__('Facebook URL'))
                                                ->placeholder('https://facebook.com/page')
                                                ->maxLength(300)
                                                ->url(),
                                            TextInput::make('site.twitter')
                                                ->label(__('X (Twitter) URL'))
                                                ->placeholder('https://x.com/username')
                                                ->maxLength(300)
                                                ->url(),

                                        ])->columns(2),

                                    Section::make('Default Header Image')
                                        ->collapsed()
                                        ->schema([

                                            CustomCuratorPicker::make($tab->makeName('site.default_header_image'))
                                                ->label(__('Default Header Image['.$tab->getLocale().']'))
                                                ->pathGenerator(DatePathGenerator::class)
                                                ->size(40)
                                                ->color('primary')
                                                ->outlined(true)
                                                ->size('md')
                                                ->constrained(true)
                                                ->orderColumn('order')
                                                ->required(),

                                            TextInput::make($tab->makeName('site.default_header_image_title'))
                                                ->label(__('Default Header Image Title['.$tab->getLocale().']'))
                                                ->required()
                                                ->maxLength(255)
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                            ColorPicker::make($tab->makeName('site.default_header_image_title_color'))
                                                ->label(__('Header Image Title Color['.$tab->getLocale().']'))
                                                ->notRegex('/<[^b][^r][^>]*>/')
                                                ->validationMessages([
                                                    'not_regex' => 'HTML is invalid',
                                                ]),

                                        ])->columns(2),

                                ]),
                        ]),

                ]),

        ];
    }

    protected function fillForm(): void
    {
        $data = Setting::get();

        $this->callHook('beforeFill');

        $this->form->fill($data);

        $this->callHook('afterFill');
    }

    public function save(): void
    {
        try {
            $this->callHook('beforeValidate');

            $settings = Setting::all()->mapWithKeys(function ($i) {
                return [$i->key => $i->value];
            })->toArray();

            $fields = collect($this->form->getFlatFields(true));
            $fieldsWithNestedFields = $fields->filter(fn (Field $field) => count($field->getChildComponents()) > 0);

            $fieldsWithNestedFields->each(function (Field $fieldWithNestedFields, string $fieldWithNestedFieldsKey) use (&$fields) {
                $fields = $fields->reject(function (Field $field, string $fieldKey) use ($fieldWithNestedFieldsKey) {
                    return Str::startsWith($fieldKey, $fieldWithNestedFieldsKey.'.');
                });
            });

            $data = $fields->mapWithKeys(function (Field $field, string $fieldKey) {
                return [$fieldKey => data_get($this->form->getState(), $fieldKey)];
            })->toArray();

            $data = array_diff_assoc($data, $settings);

            $this->callHook('afterValidate');

            $this->callHook('beforeSave');

            foreach ($data as $key => $value) {
                Setting::set($key, $value);
            }

            dispatch(new ClearCaches);

            $this->callHook('afterSave');
        } catch (Halt $exception) {
            return;
        }

        $this->getSavedNotification()?->send();

        if ($redirectUrl = $this->getRedirectUrl()) {
            $this->redirect($redirectUrl, navigate: FilamentView::hasSpaMode() && is_app_url($redirectUrl));
        }
    }
}
