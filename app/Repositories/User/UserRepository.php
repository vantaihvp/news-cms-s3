<?php
namespace App\Repositories\User;

use App\Repositories\EloquentRepository;
use Hash;
class UserRepository extends EloquentRepository implements UserRepositoryInterface
{

    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\User::class;
    }

    public function create(array $attributes){
        $attributes['password'] = Hash::make($attributes['password']);
        $user = $this->_model->create($attributes);
        $user->assignRole($attributes['roles']);
        return $user;
    }
    public function getAllPaginate($per_page,$term = ''){
        $data = $this->_model->orderBy('id','DESC');
        if($term){
            $data->where(function($q) use($term){
                $q->where('name','LIKE',"%$term%");
                $q->orWhere('phone_number','LIKE',"%$term%");
                $q->orWhere('email','LIKE',"%$term%");
            });
        }
        $data = $data->paginate($per_page);
        foreach ($data as $key => $value) {
            $data[$key]['role'] = $value->getRoleNames();
        }
        return $data;
    }
    
}