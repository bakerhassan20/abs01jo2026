<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('class_note_webform', function (Blueprint $table) {
            $table->id();
            $table->string('first_name')->nullable();
            $table->string('last_name')->nullable();
            $table->string('email')->nullable();
            $table->string('graduation_year')->nullable();
            $table->string('university')->nullable();
            $table->string('field_of_study')->nullable();
            $table->string('occupation')->nullable();
            $table->string('location')->nullable();
            $table->string('note_type')->nullable();
            $table->text('note')->nullable();
            $table->string('social_media_links')->nullable();
            $table->string('confirmation_email')->nullable();
            $table->string('photo')->nullable();
            $table->boolean('share_permission')->nullable();
            $table->integer('created_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('class_note_webform');
    }
};
