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
        Schema::create('rl_skills_roles', function (Blueprint $table) {
            $table->bigIncrements('id_skill_role');
            $table->unsignedBigInteger('skill_id');
            $table->unsignedBigInteger('role_id');
            $table->enum('skill_role_status', [0, 1])->default(0);
            $table->timestamp('skill_role_created_timestamp')->useCurrent();
            $table->timestamp('skill_role_updated_timestamp')->useCurrent()->useCurrentOnUpdate();

            // Foreign key constraints
            $table->foreign('skill_id')->references('id_skill')->on('ms_skills')->onDelete('cascade');
            $table->foreign('role_id')->references('id_role')->on('ms_job_roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rl_skills_roles');
    }
};
