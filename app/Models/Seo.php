<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Seo extends Model
{
    use SoftDeletes;
    protected $guard_name ='api';
    protected $table = "seo";
    protected $fillable = [
        'title',
        'slug',
        'description',
        'synonyms',
        'keyword',
    ];
}
