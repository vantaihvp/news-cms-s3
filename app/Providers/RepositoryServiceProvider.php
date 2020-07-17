<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton(
            \App\Repositories\User\UserRepositoryInterface::class,
            \App\Repositories\User\UserRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Post\PostRepositoryInterface::class,
            \App\Repositories\Post\PostRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Post\Revision\PostRevisionRepositoryInterface::class,
            \App\Repositories\Post\Revision\PostRevisionRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Post\Category\CategoryRepositoryInterface::class,
            \App\Repositories\Post\Category\CategoryRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Slider\SliderRepositoryInterface::class,
            \App\Repositories\Slider\SliderRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Photo\PhotoRepositoryInterface::class,
            \App\Repositories\Photo\PhotoRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Seo\SeoRepositoryInterface::class,
            \App\Repositories\Seo\SeoRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Ads\AdsBanner\AdsBannerRepositoryInterface::class,
            \App\Repositories\Ads\AdsBanner\AdsBannerRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Ads\AdsZone\AdsZoneRepositoryInterface::class,
            \App\Repositories\Ads\AdsZone\AdsZoneRepository::class
        );
        $this->app->singleton(
            \App\Repositories\Menu\MenuRepositoryInterface::class,
            \App\Repositories\Menu\MenuRepository::class
        );
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
