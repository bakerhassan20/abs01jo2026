<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('album', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('category_id')->nullable();
            $table->unsignedBigInteger('student_engagement_id')->nullable();
            $table->unsignedBigInteger('image_id')->nullable();
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

            $table->foreign('student_engagement_id')
                ->references('id')->on('student_engagement')
                ->nullOnDelete()
                ->cascadeOnUpdate();
        });

        Schema::create('album_lang', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('parent_id');
            $table->string('language', 6);
            $table->string('title', 255)->nullable();
            $table->string('brief', 1000)->nullable();

            $table->index(['language', 'parent_id']);
            $table->index('parent_id');

            // Foreign key
            $table->foreign('parent_id')
                ->references('id')->on('album')
                ->cascadeOnDelete()
                ->cascadeOnUpdate();
        });

        Schema::create('album_image', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('album_id');
            $table->unsignedBigInteger('media_id');
            $table->integer('order')->default(0);

            $table->index('album_id');

            $table->foreign('album_id')
                ->references('id')->on('album')
                ->cascadeOnDelete()
                ->cascadeOnUpdate();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('album_image');
        Schema::dropIfExists('album_lang');
        Schema::dropIfExists('album');
    }
};
