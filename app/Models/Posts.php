<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Posts extends Model
{
    protected $table = "posts";
    protected $fillable = [
        'id',
        'title',
        'slug',
        'excerpt',
        'is_featured',
        'status',
        'popular',
        'format',
        'thumbnail_id',
        'thumbnail_highlight',
        'author_name',
        'design_name',
        'layout_name',
        'related_posts',
        'date',
        'url_video',
        'categories_id',
        'tags_id',
        'seo_id',
        'role_id',
        'description',
        'user_id',
    ];
}
