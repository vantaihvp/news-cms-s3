<?php
namespace App\Repositories\Seo;

use App\Repositories\EloquentRepository;
use Hash;
class SeoRepository extends EloquentRepository implements SeoRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Seo::class;
    }  
}