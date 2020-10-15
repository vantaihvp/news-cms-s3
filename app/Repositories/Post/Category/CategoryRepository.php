<?php
namespace App\Repositories\Post\Category;

use App\Repositories\EloquentRepository;
use Hash;
class CategoryRepository extends EloquentRepository implements CategoryRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Categories::class;
    }
    public function getAllPaginate($per_page,$term = ''){
        $data = $this->_model->orderBy('id','DESC');
        if($term){
            $data->where('title','LIKE',"%$term%");
        }
        $data = $data->paginate($per_page);
        return $data;
    }
    public function getTags($attributes){
        $data = $this->_model->where('taxonomy','tag');
        if($attributes->filled('orderBy')){
            $data->orderBy($attributes->get('orderBy'),'DESC');
        }
        $per_page = 10;
        if($attributes->filled('per_page')){
            $per_page = $attributes->get('per_page');
        }
        if($attributes->filled('s')){
            $s = $attributes['s'];
            $data->where('title','LIKE',"%$s%");
        }
        if($attributes->filled('include')){
            $include = explode(',',$attributes->get('include'));
            $data->whereIn('id',$include);
        }
        if($attributes->filled('sortLenght')){
            $data->orderByRaw('CHAR_LENGTH('.$attributes->get("sortLenght").')','DESC');
        }

        $data = $data->paginate($per_page);
        return $data;
    }
    public function getCategories($attributes){
        $data = $this->_model->where('taxonomy','category')->orderBy('id','DESC');
        if($attributes->filled('s')){
            $s = $attributes['s'];
            $data->where('title','LIKE',"%$s%");
        }
        if($attributes->filled('include')){
            $include = explode(',',$attributes->get('include'));
            $data->whereIn('id',$include);
        }
        $data = $data->get();
        return $data;
    }
    public function getCategoriesbyArrayId($data){
        return 1;
    }
    
}