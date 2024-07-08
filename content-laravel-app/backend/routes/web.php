<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DtUserController;
use App\Http\Controllers\DtAppController;
use App\Http\Controllers\DtEndpointController;
use App\Http\Middleware\CheckApiKey;

//Naming Convention

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['check.api.key'])->group(function () {
    // User Calls
    Route::resource('users', DtUserController::class);

    // App Calls
    Route::resource('apps', DtAppController::class);

    // Endpoint Calls
    Route::resource('endpoints', DtEndpointController::class);

    // Sign-In Calls
    Route::get('get-csrf', [DtAppController::class, 'getCsrfToken']);
});
?>
