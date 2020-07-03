<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Photos extends Model
{
    use SoftDeletes;
    protected $table = "photos";
    protected $fillable = [
        'id',
        'name',
        'alt',
        'title',
        'caption',
        'description',
        'url',
        'size',
        'user_id',
    ];
}
