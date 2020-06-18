<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateMenuDetailTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('menu_detail', function (Blueprint $table) {
            $table->id();
            $table->integer('menu_id')->unsigned();
            $table->string('title');
            $table->string('url')->nullable()->default('#');
            $table->string('type')->nullable()->default('custom');
            $table->integer('parent_id')->unsigned()->nullable()->default(0);
            $table->integer('position')->unsigned()->nullable()->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('menu_detail');
    }
}
