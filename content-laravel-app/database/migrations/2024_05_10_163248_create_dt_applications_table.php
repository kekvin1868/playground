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
        Schema::create('dt_applications', function (Blueprint $table) {
            $table->bigIncrements('id_app');
            $table->string('app_key');
            $table->enum('app_status', [0, 1])->default(0);
            $table->timestamp('app_created_timestamp')->useCurrent();
            $table->timestamp('app_updated_timestamp')->useCurrent()->useCurrentOnUpdate();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dt_applications');
    }
};
