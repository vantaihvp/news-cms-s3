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
    
}