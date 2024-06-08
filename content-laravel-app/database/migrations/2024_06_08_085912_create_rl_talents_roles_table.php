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
        Schema::create('rl_talents_roles', function (Blueprint $table) {
            $table->bigIncrements('id_talent_role');
            $table->unsignedBigInteger('talent_id');
            $table->unsignedBigInteger('role_id');
            $table->text('job_position')->nullable();
            $table->enum('talent_role_status', [0, 1])->default(0);
            $table->timestamp('talent_role_created_timestamp')->useCurrent();
            $table->timestamp('talent_role_updated_timestamp')->useCurrent()->useCurrentOnUpdate();

            // Foreign key constraints
            $table->foreign('talent_id')->references('id_talent')->on('dt_talents')->onDelete('cascade');
            $table->foreign('role_id')->references('id_role')->on('ms_job_roles')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rl_talents_roles');
    }
};
