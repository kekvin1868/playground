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
        Schema::create('rl_appkeys_endpoints', function (Blueprint $table) {
            $table->bigIncrements('id_appkey_endpoint');
            $table->unsignedBigInteger('appkey_id');
            $table->unsignedBigInteger('endpoint_id');
            $table->enum('appkey_endpoint_status', [0, 1])->default(0);
            $table->timestamp('appkey_endpoint_created_timestamp')->useCurrent();
            $table->timestamp('appkey_endpoint_updated_timestamp')->useCurrent()->useCurrentOnUpdate();

            // Foreign key constraints
            $table->foreign('appkey_id')->references('id_app')->on('dt_applications')->onDelete('cascade');
            $table->foreign('endpoint_id')->references('id_endpoint')->on('dt_endpoints')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rl_appkeys_endpoints');
    }
};
