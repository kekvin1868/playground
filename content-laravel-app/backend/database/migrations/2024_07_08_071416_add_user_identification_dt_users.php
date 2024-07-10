<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('dt_users', function (Blueprint $table) {
            $table->string('user_ktp_image')->nullable();
            $table->string('user_photo_image')->nullable();
            $table->string('user_ktp_number')->nullable();
            $table->string('user_npwp_number')->nullable();
            $table->string('user_bank_number')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('dt_users', function (Blueprint $table) {
            $table->dropColumn('user_ktp_image');
            $table->dropColumn('user_photo_image');
            $table->dropColumn('user_ktp_number');
            $table->dropColumn('user_npwp_number');
            $table->dropColumn('user_bank_number');
        });
    }
};
