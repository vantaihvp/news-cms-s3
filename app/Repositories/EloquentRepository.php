<?php

namespace App\Repositories;

use App\Repositories\RepositoryInterface;

abstract class EloquentRepository implements RepositoryInterface
{
    /**
     * @var \Illuminate\Database\Eloquent\Model
     */
    protected $_model;

    /**
     * EloquentRepository constructor.
     */
    public function __construct()
    {
        $this->setModel();
    }

    /**
     * get model
     * @return string
     */
    abstract public function getModel();

    /**
     * Set model
     */
    public function setModel()
    {
        $this->_model = app()->make(
            $this->getModel()
        );
    }


    /**
     * Get All
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     */
    public function getAll()
    {
        return $this->_model->orderByDesc('id')->get();
    }
    
    public function getWithPaginate($attributes){
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 10;
        $sortKey    = !empty($attributes['sortKey']) ? $attributes['sortKey'] : 'id';
        $sortValue  = !empty($attributes['sortValue']) ? $attributes['sortValue'] : 'DESC';
        return $this->_model->orderBy($sortKey,$sortValue)->paginate($per_page);
    }

    /**
     * Get one
     * @param $id
     * @return mixed
     */
    public function find($id)
    {
        $result = $this->_model->find($id);

        return $result;
    }

    /**
     * Create
     * @param array $attributes
     * @return mixed
     */
    public function create(array $attributes)
    {

        return $this->_model->create($attributes);
    }

    /**
     * Update
     * @param $id
     * @param array $attributes
     * @return bool|mixed
     */
    public function update($id, array $attributes)
    {
        $result = $this->find($id);
        if ($result) {
            $result->update($attributes);
            return $result;
        }

        return false;
    }

    public function updateOrCreate($attributes){
        return $this->_model->updateOrCreate(['id'=>$attributes['id']],$attributes);
    }

    /**
     * Delete
     *
     * @param $id
     * @return bool
     */
    public function delete($id)
    {
        $result = $this->find($id);
        if ($result) {
            $result->delete();

            return true;
        }

        return false;
    }

    public function restore($id){
        return $this->_model->withTrashed()->find($id)->restore();
    }

    public function getSlug($slug,$id){
        $flag = 2;
        $slug_default = $slug;
        while ($this->_model->where('slug',$slug)->where('id','<>',$id)->count()) {
            $slug = $slug_default.'-'.$flag;
            $flag++;
        }
        return $slug;
    }

}