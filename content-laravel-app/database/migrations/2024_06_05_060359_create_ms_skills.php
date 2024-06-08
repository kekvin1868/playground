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
        Schema::create('ms_skills', function (Blueprint $table) {
            $table->bigIncrements('id_skill');
            $table->string('skill_name');
            $table->text('skill_description')->nullable();
            $table->string('skill_category')->nullable();
            $table->enum('skill_status', [0, 1])->default(0);
            $table->timestamp('skill_created_timestamp')->useCurrent();
            $table->timestamp('skill_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ms_skills');
    }
};
