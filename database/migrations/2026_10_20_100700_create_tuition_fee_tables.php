<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tuition_fee', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('school_id');
            $table->string('academic_year', 20)->nullable();
            $table->decimal('amount', 10, 2)->nullable();
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

            $table->foreign('school_id')
                ->references('id')->on('school')
                ->cascadeOnDelete()
                ->cascadeOnUpdate();
        });

        Schema::create('tuition_fee_lang', function (Blueprint $table) {
            $table->unsignedBigInteger('id')->autoIncrement();
            $table->unsignedBigInteger('parent_id');
            $table->string('language', 6);
            $table->string('title', 255)->nullable();

            $table->index(['language', 'parent_id']);
            $table->index('parent_id');

            // Foreign key
            $table->foreign('parent_id')
                ->references('id')->on('tuition_fee')
                ->cascadeOnDelete()
                ->cascadeOnUpdate();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tuition_fee_lang');
        Schema::dropIfExists('tuition_fee');
    }
};
