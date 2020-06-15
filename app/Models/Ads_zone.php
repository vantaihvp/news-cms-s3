<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Ads_zone extends Model
{
    use SoftDeletes;
    protected $table = "ads_zone";
    protected $guard_name ='api';
    protected $fillable = [
        'title',
        'description',
        'status',
        'width',
        'height',
        'banner_id',
        'random',
        'campaigns_id',
        'user_id'
    ];

}
