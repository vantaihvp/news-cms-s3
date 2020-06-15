<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
class Ads_banner extends Model
{
    use SoftDeletes;
    protected $table = "ads_banner";
    protected $guard_name ='api';
    protected $fillable = [
        'title',
        'status',
        'url',
        'target',
        'enable_stats',
        'align',
        'width',
        'height',
        'banner_content',
        'user_id'
    ];
}
