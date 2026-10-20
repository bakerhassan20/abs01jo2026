<?php


use Illuminate\Support\Facades\Route;



Route::prefix('{locale}')
    ->middleware([
        \App\Http\Middleware\SetLocale::class,
    ])
    ->group(function () {


        Route::controller(\App\Http\Controllers\NewsController::class)
            ->prefix('/news')
            ->group(function () {
                Route::get('/', 'index')->name('news-index');
                Route::get('/{slug}', 'view')->name('news-view');
            });

        Route::controller(\App\Http\Controllers\SchoolsController::class)
            ->prefix('/schools')
            ->group(function () {
                Route::get('/', 'index')->name('schools-index');
                Route::get('/{slug}', 'view')->name('schools-view');
                Route::get('/{schoolSlug}/{slug}', 'subject')->name('schools-subject-view');
            });

        Route::controller(\App\Http\Controllers\TeamController::class)
            ->prefix('/team')
            ->group(function () {
                Route::get('/{category}', 'index')->name('team-index');
                Route::get('/{category}/{slug}', 'view')->name('team-view');
            });

        Route::controller(\App\Http\Controllers\UniversitiesController::class)
            ->prefix('/universities')
            ->group(function () {
                Route::get('/', 'index')->name('universities-index');
            });

        Route::controller(\App\Http\Controllers\StudentEngagementController::class)
            ->prefix('/student-engagement')
            ->group(function () {
                Route::get('/', 'index')->name('student-engagement-index');
                Route::get('/{slug}', 'view')->name('student-engagement-view');
            });

        Route::controller(\App\Http\Controllers\AlbumsController::class)
            ->prefix('/albums')
            ->group(function () {
                Route::get('/', 'index')->name('albums-index');
                Route::get('/{slug}', 'view')->name('albums-view');
            });

        Route::controller(\App\Http\Controllers\TuitionFeesController::class)
            ->group(function () {
                Route::get('/tuition-fees', 'index')->name('tuition-fees-index');
            });

        Route::controller(\App\Http\Controllers\AlumniController::class)
            ->prefix('/alumni')
            ->group(function () {
                Route::get('/', 'index')->name('alumni-index');
                Route::get('/news', 'news')->name('alumni-news-index');
            });


        Route::controller(\App\Http\Controllers\WebformsController::class)
            ->group(function () {
                Route::get('/contact-us', 'contactUs')->name('contact-us');
                Route::get('/alumni-stay-connected', 'alumniStayConnected')->name('alumni-stay-connected');
                Route::get('/submit-a-class-note', 'classNote')->name('class-note');
                Route::get('/giving', 'giving')->name('giving');
            });


        Route::controller(\App\Http\Controllers\SiteController::class)
            ->group(function () {
                Route::get('/', 'home')->name('home');
                Route::get('/change-language','changeLanguage')->name('change-language');
                Route::any('/search', 'search')->name('search');
                Route::get('/site-map', 'siteMap')->name('site-map');
                Route::get('/privacy-policy', 'privacyPolicy')->name('privacy-policy');
                Route::get('/terms-conditions', 'termsConditions')->name('terms-conditions');
                Route::get('/{slug}', 'index')->name('page-view');
            });




    });

Route::get('/', function () {
    return redirect()->route('home', ['locale' => config('app.locale')]);
});
