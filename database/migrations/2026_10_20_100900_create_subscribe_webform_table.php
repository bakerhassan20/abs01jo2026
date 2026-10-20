<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('subscribe_webform', function (Blueprint $table) {
            $table->id();
            $table->string('email')->nullable();
            $table->integer('created_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('subscribe_webform');
    }
};
