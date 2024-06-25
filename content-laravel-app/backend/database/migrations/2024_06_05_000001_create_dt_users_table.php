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
        Schema::create('dt_users', function (Blueprint $table) {
            $table->bigIncrements('id_user');
            $table->enum('user_status', [0, 1])->default(0);
            $table->timestamp('user_created_timestamp')->useCurrent();
            $table->timestamp('user_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
            $table->string('user_mail')->unique();
            $table->string('user_pass');
            $table->string('user_fullname');
            $table->enum('user_agree_to_ToS', [0, 1])->default(0);
            $table->enum('user_agree_to_PP', [0, 1])->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dt_users');
    }
};
