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
        Schema::create('dt_talents', function (Blueprint $table) {
            $table->bigIncrements('id_talent');
            $table->enum('talent_status', [0, 1])->default(0);
            $table->timestamp('talent_created_timestamp')->useCurrent();
            $table->timestamp('talent_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedBigInteger('user_id');
            $table->float('talent_score');

            $table->foreign('user_id')->references('id_user')->on('dt_users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dt_talents');
    }
};
