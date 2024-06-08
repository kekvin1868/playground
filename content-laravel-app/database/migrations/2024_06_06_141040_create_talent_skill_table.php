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
        Schema::create('talent_skill', function (Blueprint $table) {

            $table->bigIncrements('talent_skill_id');
            $table->enum('talent_skill_status', [0, 1])->default(0);
            $table->timestamp('talent_skill_created_timestamp')->useCurrent();
            $table->timestamp('talent_skill_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedBigInteger('talent_id');
            $table->unsignedBigInteger('skill_id');
            $table->enum('talent_skill_test_status', [0, 1])->default(0);
            $table->float('talent_skill_score');

            // Foreign key constraints
            $table->foreign('talent_id')->references('talent_id')->on('talent')->onDelete('cascade');
            $table->foreign('skill_id')->references('id')->on('master_skill')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('talent_skill');
    }
};

//master_role
