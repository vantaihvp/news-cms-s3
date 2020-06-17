<?php
namespace App\Repositories\Menu;

use App\Repositories\EloquentRepository;
use App\User;
class MenuRepository extends EloquentRepository implements MenuRepositoryInterface
{

    
    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Menus::class;
    }
    public function getWithPaginate($attributes){
        return $this->_model->all();
    }
}