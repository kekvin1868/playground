<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\CheckApiKey;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $router = $this->app['router'];
        $router->aliasMiddleware('check.api.key', CheckApiKey::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Loading API routes
        Route::prefix('api')
            ->middleware('api')
            ->group(base_path('routes/api.php'));

        // Loading web routes
        Route::middleware('web')
            ->group(base_path('routes/web.php'));
    }
}
