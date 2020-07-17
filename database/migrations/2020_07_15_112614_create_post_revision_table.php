<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePostRevisionTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('post_revision', function (Blueprint $table) {
            $table->id();
            $table->integer('post_id')->unsigned();
            $table->text('title');
            $table->string('slug', 255);
            $table->text('excerpt')->nullable();
            $table->boolean('is_featured')->nullable()->default(false);
             $table->boolean('popular')->nullable()->default(false);
            $table->string('status', 30)->default('publish');
            $table->string('format', 50)->default('default');
            $table->integer('thumbnail_id')->unsigned()->nullable();
            $table->integer('thumbnail_highlight')->unsigned()->nullable();
            $table->string('author_name')->nullable();
            $table->string('design_name')->nullable();
            $table->string('layout_name',30)->nullable();
            $table->string('related_posts', 150)->nullable();
            $table->dateTime('date')->nullable();
            $table->longText('description');
            $table->string('url_video')->nullable();
            $table->json('categories_id')->nullable();
            $table->json('tags_id')->nullable();
            $table->integer('seo_id')->unsigned()->nullable();
            $table->integer('user_id')->default(1);
            $table->integer('role_id')->unsigned()->nullable();
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
        Schema::dropIfExists('post_revision');
    }
}
