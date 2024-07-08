<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MsSkillController;
use App\Http\Controllers\MsRoleController;
use App\Http\Controllers\DtTalentController;
use App\Http\Controllers\DtUserController;
use App\Http\Middleware\CheckApiKey;

Route::middleware(['check.api.key'])->group(function () {
    // Master
    Route::resource('skills', MsSkillController::class);
    Route::resource('job-roles', MsRoleController::class);

    // Data
    Route::resource('talents', DtTalentController::class);
});

// User
Route::post('check-email', [DtUserController::class, 'checkEmailUser']);
Route::post('activation', [DtUserController::class, 'activation']);

// Send Email
Route::post('send-email', [DtUserController::class, 'sendEmail']);

?>
