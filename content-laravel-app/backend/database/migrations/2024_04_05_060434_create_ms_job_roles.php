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
        Schema::create('ms_job_roles', function (Blueprint $table) {
            $table->bigIncrements('id_role');
            $table->string('role_name');
            $table->text('role_description')->nullable;
            $table->enum('role_status', [0, 1])->default(0);
            $table->timestamp('role_created_timestamp')->useCurrent();
            $table->timestamp('role_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ms_job_roles');
    }
};
