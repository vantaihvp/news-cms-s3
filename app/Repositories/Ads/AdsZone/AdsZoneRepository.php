<?php
namespace App\Repositories\Ads\AdsZone;

use App\Repositories\EloquentRepository;
use Hash;
class AdsZoneRepository extends EloquentRepository implements AdsZoneRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Ads_zone::class;
    } 
    public function getWithPaginate($attributes){
        $s  = !empty($attributes['s']) ? $attributes['s'] : '';
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 20;
        $rs = $this->_model->orderBy('id','DESC');
        if($s){
            $rs->where('title','LIKE',"%$s%");
        }
        $rs = $rs->paginate($per_page);
    }
}