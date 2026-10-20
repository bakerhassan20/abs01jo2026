<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('giving_webform', function (Blueprint $table) {
            $table->id();
            $table->string('amount')->nullable();
            $table->string('other_amount')->nullable();
            $table->string('designation')->nullable();
            $table->string('tribute')->nullable();
            $table->boolean('on_behalf_of_organization')->nullable();
            $table->string('organization_name')->nullable();
            $table->string('title')->nullable();
            $table->string('first_name')->nullable();
            $table->string('last_name')->nullable();
            $table->string('email')->nullable();
            $table->string('phone')->nullable();
            $table->string('country')->nullable();
            $table->string('address')->nullable();
            $table->string('city')->nullable();
            $table->string('state_zip')->nullable();
            $table->boolean('is_anonymous')->nullable();
            $table->string('appear_in_donor_report')->nullable();
            $table->string('donor_type')->nullable();
            $table->text('comment')->nullable();
            $table->string('confirmation_email')->nullable();
            $table->integer('created_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('giving_webform');
    }
};
