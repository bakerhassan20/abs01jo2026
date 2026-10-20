<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('message_lang', function (Blueprint $table) {
            $table->string('translation_value', 550)->nullable()->change();
        });
    }

    public function down(): void
    {
        Schema::table('message_lang', function (Blueprint $table) {
            $table->string('translation_value', 255)->nullable()->change();
        });
    }
};
