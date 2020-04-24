<?php

namespace App\models;

use Illuminate\Database\Eloquent\Model;
use SoftDeletes;

class Slider extends Model
{   
    protected $table = "slider";
    protected $fillable = [
        'title',
        'url',
        'thumbnail_id',
        'slider_category_id',
        'status',
        'user_id',
    ];
}
