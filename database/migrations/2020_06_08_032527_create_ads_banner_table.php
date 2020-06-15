<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAdsBannerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ads_banner', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->enum('status', ['active', 'expired','draft','review','on-hold'])->nullable()->default('review');
            $table->string('url')->nullable()->default('#');
            $table->enum('target', ['_blank', '_self','_parent','_top'])->nullable()->default('_blank');
            $table->boolean('enable_stats')->nullable()->default(false);
            $table->enum('align', ['left', 'center','right'])->nullable()->default('center');
            $table->integer('width')->unsigned()->nullable()->default(300);
            $table->integer('height')->unsigned()->nullable()->default(300);
            $table->text('banner_content')->nullable();
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
        Schema::dropIfExists('ads_banner');
    }
}
