<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAdsZoneTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ads_zone', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->text('description')->nullable();
            $table->enum('status', ['active','draft','on-hold'])->nullable()->default('draft');
            $table->integer('width')->unsigned()->nullable()->default(300);
            $table->integer('height')->unsigned()->nullable()->default(300);
            $table->json('banner_id')->nullable();
            $table->boolean('random')->nullable()->default(false);
            $table->integer('campaigns_id')->unsigned()->nullable();
            $table->integer('user_id')->unsigned();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ads_zone');
    }
}
