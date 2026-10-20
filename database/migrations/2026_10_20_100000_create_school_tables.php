<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('school', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('image_id')->nullable();
            $table->unsignedBigInteger('head_image_id')->nullable();
            $table->string('slug', 255)->unique();
            $table->boolean('status')->default(0)->comment('0-pending,1-published');
            $table->unsignedInteger('created_at');
            $table->unsignedInteger('updated_at');
            $table->integer('deleted_at')->nullable();
            $table->integer('published_at')->nullable();
            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('updated_by');
            $table->tinyInteger('weight_order')->default(10);
            $table->unsignedBigInteger('revision')->default(0);
            $table->boolean('changed')->default(0);
            $table->string('reject_note', 255)->nullable();

            $table->index('status');
            $table->index('deleted_at');
            $table->index('published_at');

            // Foreign keys
            $table->foreign('created_by')
                ->references('id')->on('user')
                ->cascadeOnUpdate();

            $table->foreign('updated_by')
                ->references('id')->on('user')
                ->cascadeOnUpdate();
        });

        Schema::create('school_lang', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('parent_id');
            $table->string('language', 6);
            $table->string('title', 255)->nullable();
            $table->string('grades_title', 255)->nullable();
            $table->string('brief', 1000)->nullable();
            $table->string('head_title', 255)->nullable();
            $table->string('head_name', 255)->nullable();
            $table->string('head_position', 255)->nullable();
            $table->text('head_content')->nullable();
            $table->text('content')->nullable();

            $table->index(['language', 'parent_id']);
            $table->index('parent_id');

            // Foreign key
            $table->foreign('parent_id')
                ->references('id')->on('school')
                ->cascadeOnDelete()
                ->cascadeOnUpdate();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('school_lang');
        Schema::dropIfExists('school');
    }
};
