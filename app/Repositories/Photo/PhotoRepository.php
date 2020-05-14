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
}