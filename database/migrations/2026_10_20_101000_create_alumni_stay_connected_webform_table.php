<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('alumni_stay_connected_webform', function (Blueprint $table) {
            $table->id();
            $table->string('first_name')->nullable();
            $table->string('middle_name')->nullable();
            $table->string('last_name')->nullable();
            $table->string('alumni_status')->nullable();
            $table->string('email')->nullable();
            $table->string('mobile')->nullable();
            $table->string('home_address')->nullable();
            $table->string('is_alumni')->nullable();
            $table->string('graduation_year')->nullable();
            $table->string('current_profession')->nullable();
            $table->string('universities_attended')->nullable();
            $table->string('degrees_awarded')->nullable();
            $table->string('listed_on_linkedin')->nullable();
            $table->string('share_email')->nullable();
            $table->string('is_parent')->nullable();
            $table->string('spouse_is_alumni')->nullable();
            $table->string('interested_activities')->nullable();
            $table->string('receive_news')->nullable();
            $table->text('suggestions')->nullable();
            $table->integer('created_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('alumni_stay_connected_webform');
    }
};
