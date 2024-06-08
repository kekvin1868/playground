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
        Schema::create('rl_tlskills_roles', function (Blueprint $table) {
            $table->bigIncrements('id_tlskills_roles');
            $table->enum('tlskills_roles_status', [0, 1])->default(0);
            $table->timestamp('tlskills_roles_created_timestamp')->useCurrent();
            $table->timestamp('tlskills_roles_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedBigInteger('tlskill_id');
            $table->unsignedBigInteger('role_id');

            // Foreign key constraints
            $table->foreign('tlskill_id')->references('id_talent_skills')->on('rl_talents_skills_table')->onDelete('cascade');
            $table->foreign('role_id')->references('id_role')->on('ms_job_roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rl_tlskills_roles');
    }
};
