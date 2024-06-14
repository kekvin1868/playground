<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MsSkillController;
use App\Http\Controllers\MsRoleController;
use App\Http\Controllers\DtUserController;
use App\Http\Controllers\DtAppController;
use App\Http\Controllers\DtEndpointController;
use App\Http\Controllers\DtTalentController;

Route::get('/', function () {
    return view('welcome');
});

// Master
Route::resource('skills', MsSkillController::class);
Route::resource('job-roles', MsRoleController::class);

// Data
Route::resource('users', DtUserController::class);
Route::resource('apps', DtAppController::class);
Route::resource('endpoints', DtEndpointController::class);
Route::resource('talents', DtTalentController::class);
