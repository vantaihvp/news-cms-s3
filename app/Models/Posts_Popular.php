<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Posts_Popular extends Model
{
    protected $table = "posts_popular";
    protected $fillable = [
        'id',
        'post_id',
        'user_id',
    ];
}
