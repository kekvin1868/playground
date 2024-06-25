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
        Schema::create('dt_endpoints', function (Blueprint $table) {
            $table->bigIncrements('id_endpoint');
            $table->string('endpoint_name');
            $table->unsignedBigInteger('app_id');
            $table->enum('endpoint_status', [0, 1])->default(0);
            $table->timestamp('endpoint_created_timestamp')->useCurrent();
            $table->timestamp('endpoint_updated_timestamp')->useCurrent()->useCurrentOnUpdate();

            # Foreign Key to Application Table
            $table->foreign('app_id')->references('id_app')->on('dt_applications')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dt_endpoints');
    }
};
