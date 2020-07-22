<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class CategoriesSlider extends Model
{
    use SoftDeletes;
    protected $table = "categories_slider";
    protected $guard_name ='api';
    protected $fillable = [
        'id','title', 'description'
    ];
}
