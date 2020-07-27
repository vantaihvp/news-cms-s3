<?php
namespace App\Repositories\Post\Popular;

use App\Repositories\EloquentRepository;
use Illuminate\Support\Carbon;
use App\User;
use App\Models\Photos;
class PostsPopularRepository extends EloquentRepository implements PostsPopularRepositoryInterface
{

    
    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Posts_Popular::class;
    }
    public function getByPostId($post_id){
        return $this->_model->where('post_id',$post_id)->get();
    }
    public function index($request){
        $rs = $this->_model->leftJoin('posts','posts_popular.post_id','posts.id')->select('posts.*','posts.id as post_id','posts_popular.id')->orderByDesc('posts_popular.id');
        if($request->filled('post_id')){
            $rs->where('posts_popular.post_id',$request->get('post_id'));
        }
        if($request->filled('include')){
            $include = explode(',',$request->get('include'));
            $rs->whereIn('posts_popular.id',$include);
        }
        if($request->filled('paginate') && $request->get('paginate')=='1'){
            $per_page = $request->filled('per_page') ? $request->get('per_page') : 10;
            $rs= $rs->paginate($per_page);
        }else{
            $rs = $rs->get();
        }
        foreach ($rs as $key => $value) {
            if($value->thumbnail_id){
                try {
                    $value->thumbnail_url = 'https://'.env('AWS_BUCKET').'.s3-'.env('AWS_DEFAULT_REGION').'.'.'amazonaws.com/'.Photos::find($value->thumbnail_id)->url;                    //code...
                } catch (\Throwable $th) {
                    $value->thumbnail_url = url('/images/admin/placeholder.png');
                }
            }else{
                $value->thumbnail_url = url('/images/admin/placeholder.png');
            }
        }
        return $rs;
    }
}