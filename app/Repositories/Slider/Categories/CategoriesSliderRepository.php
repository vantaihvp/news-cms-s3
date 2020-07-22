<?php
namespace App\Repositories\Slider\Categories;

use App\Repositories\EloquentRepository;

class CategoriesSliderRepository extends EloquentRepository implements CategoriesSliderRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\CategoriesSlider::class;
    }
    public function index($attributes){
        $s  = !empty($attributes['s']) ? $attributes['s'] : '';
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 10;        
        $rs = $this->_model->orderBy('id','DESC');
        if($s){
            $rs->where('title','LIKE',"%$s%");
        }
        if($attributes->filled('paginate')){
            $rs = $rs->paginate($per_page);            
        }else{
            $rs = $rs->get();
        }
        return $rs;
    }
}