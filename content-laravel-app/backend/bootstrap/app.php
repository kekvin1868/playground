<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->validateCsrfTokens(except: [
            'http://localhost:8000/api/check-email*',
            'http://localhost:8000/api/activation*',
            'http://localhost:8000/users*',
            'http://localhost:8000/uuid',

            // 'https://backend.pakar.diawan.id/api/check-email*',
            // 'https://backend.pakar.diawan.id/api/activation*',
            // 'https://backend.pakar.diawan.id/users*',
            // 'https://backend.pakar.diawan.id/uuid',
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();
