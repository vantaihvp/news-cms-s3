<?php
namespace App\Repositories\Photo;

use App\Repositories\EloquentRepository;
use Hash;
class PhotoRepository extends EloquentRepository implements PhotoRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Photos::class;
    } 
    public function getWithPaginate($attributes){
        $s  = !empty($attributes['s']) ? $attributes['s'] : '';
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 18;
        $rs = $this->_model->orderBy('id','DESC');
        if($s){
            $rs->where('title','LIKE',"%$s%");
        }
        $rs = $rs->paginate($per_page);
        return $rs;
    }
}