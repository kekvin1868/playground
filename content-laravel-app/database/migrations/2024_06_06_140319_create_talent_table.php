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
        Schema::create('talent', function (Blueprint $table) {
            $table->bigIncrements('talent_id');
            $table->enum('talent_status', [0, 1])->default(0);
            $table->timestamp('talent_created_timestamp')->useCurrent();
            $table->timestamp('talent_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedBigInteger('user_id');
            $table->float('talent_score');

            $table->foreign('user_id')->references('user_id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('talent');
    }
};
