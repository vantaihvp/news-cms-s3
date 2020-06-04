<?php
namespace App\Repositories\Post;

use App\Repositories\EloquentRepository;
use Illuminate\Support\Carbon;
use App\User;
use App\Models\Categories;
use App\Models\Photos;
class PostRepository extends EloquentRepository implements PostRepositoryInterface
{

    
    /**
     * get model
     * @return string
     */
    public function getModel()
    {
        return \App\Models\Posts::class;
    }
    public function getWithPaginate($attributes){
        $user = \Auth::user();
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 10;
        $sortKey    = !empty($attributes['sortKey']) ? $attributes['sortKey'] : 'id';
        $sortValue  = !empty($attributes['sortValue']) ? $attributes['sortValue'] : 'DESC';
        $s          = !empty($attributes['s']) ? $attributes['s'] : '';
        $author_id  = !empty($attributes['author_id']) ? $attributes['author_id'] : '';
        $rs = $this->_model->orderBy($sortKey,$sortValue);
        if($s){
            $rs->where('title','LIKE',"%$s%");
        }
        if($author_id){
            $rs->whereIn('user_id',$author_id);
        }
        if($attributes->filled('categories')){
            $categories = $attributes->get('categories');
            foreach ($categories as $key => $value) {
                if($key==0){
                    $rs->whereRaw('JSON_CONTAINS(categories_id, '.$value.')');
                }else{
                    $rs->orwhereRaw('JSON_CONTAINS(categories_id, '.$value.')');
                }
            }
        }
        if($user){
            if($attributes->filled('status')){
                $rs->where('status',$attributes->status);
            }
            if(!$user->can('other-post-list')){
                $rs->where('user_id',$user->id);
            }
        }else{
            $rs->where('status','publish');
        }
        if($attributes->filled('dateTime')){
            $dateStart = Carbon::parse($attributes->dateTime[0]);
            $dateEnd = Carbon::parse($attributes->dateTime[1]);
            $rs->whereBetween('date',array($dateStart,$dateEnd));
        }
        if($attributes->filled('is_featured')){
            $rs->where('is_featured',$attributes->is_featured);
        }
        if($attributes->filled('slug')){
            $rs->where('slug',$attributes->slug);
        }
        $rs = $rs->paginate($per_page);
        foreach ($rs as $key => $post) {
            $post['user_name'] = User::find($post->user_id)->name;
            if($post->categories_id){
                $categories_arr = array();
                $categories = json_decode($post->categories_id);
                foreach ($categories as $key => $value) {
                    $categories_arr[] = Categories::find($value)->title;
                }
                $post->categories_name = join(",", $categories_arr);
            }
            if($post->thumbnail_id){
                $post->thumbnail_url = url('/').'/images'.Photos::find($post->thumbnail_id)->url;
            }else{
                $post->thumbnail_url = url('/images/admin/placeholder.png');
            }
        }
        return $rs;
    }
}