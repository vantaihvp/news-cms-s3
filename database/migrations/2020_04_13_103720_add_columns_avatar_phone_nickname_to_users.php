<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddColumnsAvatarPhoneNicknameToUsers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('pseudonym', 100)->nullable()->after('name');
            $table->string('phone_number', 150)->nullable()->after('pseudonym');
            $table->integer('photo_id')->unsigned()->nullable()->after('phone_number');
            $table->text('description')->nullable()->after('photo_id');
            $table->boolean('is_supperadmin')->nullable()->default(0)->after('description');
            $table->boolean('banned')->nullable()->default(0)->after('is_supperadmin');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('pseudonym');
            $table->dropColumn('phone_number');
            $table->dropColumn('photo_id');
            $table->dropColumn('description');
            $table->dropColumn('is_supperadmin');
            $table->dropColumn('banned');
        });
    }
}
