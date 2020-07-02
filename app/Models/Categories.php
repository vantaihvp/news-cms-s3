<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Categories extends Model
{
    use SoftDeletes;
    protected $guard_name ='api';
    protected $fillable = [
        'id','title', 'slug', 'description','thumbnail_id','parent_id','taxonomy','seo_id','user_id'
    ];
}
