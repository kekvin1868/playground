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

/*
    TODO:
        - Remove VerifyCsrfToken exception.
        - Only when Frontend is implemented, CSRF can be passed.
*/

Route::middleware(['check.api.key'])->group(function () {
    // Session Data
    Route::resource('users', DtUserController::class);
    Route::resource('apps', DtAppController::class);
    Route::resource('endpoints', DtEndpointController::class);
});

?>
