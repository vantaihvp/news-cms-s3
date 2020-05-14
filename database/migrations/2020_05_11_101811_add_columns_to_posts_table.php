<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddColumnsToPostsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('posts', function (Blueprint $table) {
            $table->string('slug', 255)->after('title');
            $table->text('excerpt')->nullable()->after('slug');
            $table->boolean('is_featured')->nullable()->default(false)->after('excerpt');
            $table->string('status', 30)->default('publish')->after('is_featured');
            $table->string('format', 50)->default('default')->after('status');
            $table->integer('thumbnail_id')->unsigned()->nullable()->after('format');
            $table->string('author_name')->nullable()->after('thumbnail_id');
            $table->string('design_name')->nullable()->after('author_name');
            $table->string('layout_name',30)->nullable()->after('design_name');
            $table->string('related_posts', 150)->nullable()->after('layout_name');
            $table->dateTime('date')->nullable()->after('related_posts');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('posts', function (Blueprint $table) {
            $table->dropColumn('slug');
            $table->dropColumn('excerpt');
            $table->dropColumn('is_featured');
            $table->dropColumn('status');
            $table->dropColumn('format');
            $table->dropColumn('thumbnail_id');
            $table->dropColumn('author_name');
            $table->dropColumn('design_name');
            $table->dropColumn('layout_name');
            $table->dropColumn('related_posts');
            $table->dropColumn('date');
            $table->dropColumn('user_id');
        });
    }
}
