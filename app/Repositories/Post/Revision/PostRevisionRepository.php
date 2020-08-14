<?php
namespace App\Repositories\Post\Revision;

use App\Repositories\EloquentRepository;
use Illuminate\Support\Carbon;
use App\User;
class PostRevisionRepository extends EloquentRepository implements PostRevisionRepositoryInterface
{

    
    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Posts_Revision::class;
    }
    public function getByPostId($post_id){
        return $this->_model->where('post_id',$post_id)->get();
    }
    public function index($request){
        $rs = $this->_model->orderByDesc('id');
        if($request->filled('post_id')){
            $rs->where('post_id',$request->get('post_id'));
        }
        if($request->filled('include')){
            $include = explode(',',$request->get('include'));
            $rs->whereIn('id',$include);
        }
        if($request->filled('paginate') && $request->get('paginate')=='1'){
            $per_page = $request->filled('per_page') ? $request->get('per_page') : 10;
            $rs= $rs->paginate($per_page);
        }else{
            $rs = $rs->get();
        }
        foreach ($rs as $key => $value) {
            $value['user_name'] = $value->user_edit ? User::find($value->user_edit)->name : User::find($value->user_id)->name;
        }
        return $rs;
    }
}