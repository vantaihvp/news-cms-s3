<?php
namespace App\Repositories\Slider;

use App\Repositories\EloquentRepository;

class SliderRepository extends EloquentRepository implements SliderRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Slider::class;
    }
    public function index($attributes){
        $s  = !empty($attributes['s']) ? $attributes['s'] : '';
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 10;        
        $rs = $this->_model->orderBy('id','DESC');
        if($s){
            $rs->where('title','LIKE',"%$s%");
        }
        if($attributes->filled('slider_category_id')){
            $categories = explode(',',$attributes->get('slider_category_id'));
            foreach ($categories as $key => $value) {
                if($key==0){
                    $rs->whereRaw('JSON_CONTAINS(slider_category_id, "'.$value.'")');
                }else{
                    $rs->orwhereRaw('JSON_CONTAINS(slider_category_id, "'.$value.'")');
                }
            }
        }
        if($attributes->filled('paginate')){
            $rs = $rs->paginate($per_page);            
        }else{
            $rs = $rs->get();
        }
        return $rs;
    }
    
    
}