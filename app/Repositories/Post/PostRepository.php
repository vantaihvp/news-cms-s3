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
        $dt = Carbon::now('Asia/Ho_Chi_Minh')->addHours('7')->toDateTimeString();
        // return $dt;
        $user = \Auth::user();
        $per_page   = $attributes['per_page'] ? $attributes['per_page'] : 10;
        $sortKey    = !empty($attributes['sortKey']) ? $attributes['sortKey'] : 'id';
        $sortValue  = !empty($attributes['sortValue']) ? $attributes['sortValue'] : 'DESC';
        $s          = !empty($attributes['s']) ? $attributes['s'] : '';
        $author_id  = !empty($attributes['author_id']) ? $attributes['author_id'] : '';
        $rs = $this->_model->where('date','<=',$dt)->orderBy($sortKey,$sortValue);
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
                    $rs->whereRaw('JSON_CONTAINS(categories_id, "'.$value.'")');
                }else{
                    $rs->orwhereRaw('JSON_CONTAINS(categories_id, "'.$value.'")');
                }
            }
        }
        if($attributes->filled('categories_id')){
            $categories = explode(',',$attributes->get('categories_id'));
            foreach ($categories as $key => $value) {
                if($key==0){
                    $rs->whereRaw('JSON_CONTAINS(categories_id, "'.$value.'")');
                }else{
                    $rs->orwhereRaw('JSON_CONTAINS(categories_id, "'.$value.'")');
                }
            }
        }
        if($attributes->filled('tags_id')){
            $tags_id = explode(',',$attributes->get('tags_id'));
            foreach ($tags_id as $key => $value) {
                if($key==0){
                    $rs->whereRaw('JSON_CONTAINS(tags_id, "'.$value.'")');
                }else{
                    $rs->orwhereRaw('JSON_CONTAINS(tags_id, "'.$value.'")');
                }
            }
        }
        if($user){
            if($attributes->filled('status') && $attributes->status!='deleted'){
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
        if($attributes->filled('format')){
            $rs->where('format',$attributes->format);
        }
        if($attributes->filled('popular')){
            $rs->where('popular',$attributes->popular);
        }
        if($attributes->filled('include')){
            $include = explode(',',$attributes->get('include'));
            $rs->whereIn('id',$include);
        }
        if($attributes->filled('exclude')){
            $exclude = explode(',',$attributes->get('exclude'));
            $rs->whereNotIn('id',$exclude);
        }
        if($attributes->filled('status') && $attributes->status=='deleted'){
            $rs = $rs->onlyTrashed()->paginate($per_page);
        }else{
            $rs = $rs->paginate($per_page);
        }
        foreach ($rs as $key => $post) {
            $post['user_name'] = User::find($post->user_id)->name;
            if($post->categories_id){
                $categories_arr = array();
                $categories = json_decode($post->categories_id);
                foreach ($categories as $key => $value) {
                    try {
                        $categories_arr[] = Categories::find($value)->title;
                    } catch (\Throwable $th) {
                    }
                }
                $post->categories_name = join(",", $categories_arr);
            }
            if($post->thumbnail_id){
                try {
                    $post->thumbnail_url = 'https://'.env('AWS_BUCKET').'.s3-'.env('AWS_DEFAULT_REGION').'.'.'amazonaws.com/'.Photos::find($post->thumbnail_id)->url;                    //code...
                } catch (\Throwable $th) {
                    $post->thumbnail_url = url('/images/admin/placeholder.png');
                }
            }else{
                $post->thumbnail_url = url('/images/admin/placeholder.png');
            }
            if($post->thumbnail_highlight){
                try {
                    $post->highlight_url = 'https://'.env('AWS_BUCKET').'.s3-'.env('AWS_DEFAULT_REGION').'.'.'amazonaws.com/'.Photos::find($post->thumbnail_highlight)->url;
                } catch (\Throwable $th) {
                    $post->highlight_url = url('/images/admin/placeholder.png');
                }
            }
        }
        return $rs;
    }
    public function issetSlug($slug,$id){
        $post = $this->_model->where('slug',$slug);
        if($id){
            $post->where('id','<>',$id);
        }
        $result = $post->count();
        return $result;
    }
    
}