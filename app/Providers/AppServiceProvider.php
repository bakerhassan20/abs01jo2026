<?php

namespace App\Providers;


use App\Models\Media\Media;
use App\Models\User;
use Filament\Actions\CreateAction;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\ServiceProvider;

use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\Request;



class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {


        //filament
        Gate::define('use-translation-manager', function (?User $user) {
            // Your authorization logic
            return $user !== null;
        });
        Gate::before(function ($user, $ability) {
            if ($user->superadmin) {
                return true; // Grant all abilities to super admins
            }
        });
        Gate::policy(\Spatie\Permission\Models\Role::class, \App\Policies\RolePolicy::class);

        // disable create another action
        \Filament\Resources\Pages\CreateRecord::disableCreateAnother();
        \Filament\Actions\CreateAction::configureUsing(fn(CreateAction $action) => $action->createAnother(false));



        //configuations
        Config::set('app.name', setting("general.title", env("APP_NAME")) ?? env("APP_NAME"));

        //smtp
        Config::set('mail.mailers.smtp.host', setting("general.smtp_host", env("MAIL_HOST")) ?? env("MAIL_HOST"));
        Config::set('mail.mailers.smtp.port', setting("general.smtp_port", env("MAIL_PORT")) ?? env("MAIL_PORT"));
        Config::set('mail.mailers.smtp.encryption', setting("general.smtp_encryption", env("MAIL_ENCRYPTION")) ?? env("MAIL_ENCRYPTION"));
        Config::set('mail.mailers.smtp.username', setting("general.smtp_username", env("MAIL_USERNAME")) ?? env("MAIL_USERNAME"));
        Config::set('mail.from.address', setting("general.smtp_username", env("MAIL_FROM_ADDRESS")) ?? env("MAIL_FROM_ADDRESS"));
        Config::set('mail.mailers.smtp.password', setting("general.smtp_password", env("MAIL_PASSWORD")) ?? env("MAIL_PASSWORD"));


        //frontend

        $lang = Request::segment(1);
        if (in_array($lang, config('app.locales'))) {
            app()->setlocale($lang);
        }


        $lng = app()->getlocale();
        $cssNonce = csp_nonce('style');
        $jsNonce = csp_nonce('script');



        $logo = Cache::rememberForever("logo" . (new Media())->getTable(), function () use ($lng) {
            return Media::find(setting("{$lng}.site.logo"));
        });



        $alternativeHeaderImage = Cache::rememberForever("alternative_header_image" . (new Media())->getTable(), function () use ($lng) {
            return Media::find(setting("{$lng}.site.alternative_header_image"));
        });
        $favicon = Cache::rememberForever("favicon" . (new Media())->getTable(), function () use ($lng) {
            return Media::find(setting("{$lng}.site.icon"));
        });




        view()->share("lng", $lng);
        view()->share("cssNonce", $cssNonce);
        view()->share("jsNonce", $jsNonce);
        App::instance("cssNonce", $cssNonce);
        App::instance("jsNonce", $jsNonce);
        view()->share("logo", $logo);
        view()->share("favIcon", $favicon);
        view()->share("alternativeHeaderImage", $alternativeHeaderImage);

        Paginator::defaultView('vendor.pagination.default');
    }
}
