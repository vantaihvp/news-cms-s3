<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class SliderBanner extends Model
{
    use SoftDeletes;
    protected $table = "slider";
    protected $guard_name ='api';
    protected $fillable = [
        'id','title','url','thumbanail_id','slider_category_id', 'status'
    ];
}
