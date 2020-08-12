<?php

namespace App\Http\Controllers\API;
use DB;
use Carbon\Carbon;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Post\PostRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use App\Repositories\Post\Category\CategoryRepositoryInterface;
use App\Repositories\Photo\PhotoRepositoryInterface;
use App\Repositories\Seo\SeoRepositoryInterface;
use App\Repositories\Post\Revision\PostRevisionRepositoryInterface;
use App\Repositories\User\UserRepositoryInterface;
class PostController extends Controller
{
    protected $postRepository;
    protected $postRevision;
    protected $categoryRepository;
    protected $photoRepository;
    protected $seoRepository;
    protected $userRepo;
    public function __construct(PostRepositoryInterface $postRepository,
                                PostRevisionRepositoryInterface $postRevision,
                                CategoryRepositoryInterface $categoryRepository,
                                PhotoRepositoryInterface $photoRepository,
                                UserRepositoryInterface $userRepo,
                                SeoRepositoryInterface $seoRepository){
        $this->postRepository = $postRepository;
        $this->postRevision = $postRevision;
        $this->categoryRepository = $categoryRepository;
        $this->photoRepository = $photoRepository;
        $this->seoRepository = $seoRepository;
        $this->userRepo = $userRepo;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $rs = $this->postRepository->index($request);
        foreach ($rs as $key => $item) {
            $item->date = Carbon::parse($item->date)->format('d/m/Y H:i:s');
        }
        return response()->json(['success'=>$rs]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'title' => 'required'
        ]);
        $user = Auth::user();
        $data = $request->all();
        $data['user_id'] = $user->id;
        $data['date'] = Carbon::parse($request->date);
        $data['categories_id'] = json_encode($request->categories_id);
        $data['related_posts'] = json_encode($request->related_posts);
        $data_seo['title'] = $request->seo['title'] ? $request->seo['title'] : $request->title;
        $data_seo['description'] = $request->seo['description']? $request->seo['description'] : $request->excerpt;
        $data['seo_id'] = $this->seoRepository->create($data_seo)->id;
        if($request->filled('slug')){
            $data['slug'] = $this->slugify($request->get('slug'));
        }else{
            $data['slug'] = $this->slugify($request->get('title'));
        }
        $request['slug'] = $data['slug'];
        // return $request;
        $data['slug'] = $this->getSlug($request);
        if(!$request->thumbnail_id){
            $data['thumbnail_id'] = 1;
        }
        $arrTags = array();
        foreach ($request->selectedTags as $key => $item) {
            if(!$this->categoryRepository->find($item['id'])){
                $tags = array(
                    'title' => $item['title'],
                    'slug'  => $this->slugify($item['title']),
                    'taxonomy' => 'tag',
                    'user_id'   => $user->id,
                );
                $arrTags[] = $this->categoryRepository->create($tags)->id;
            }else{
                $arrTags[] = $item['id'];
            }
        }
        $data['tags_id'] = json_encode($arrTags);
        $rs = $this->postRepository->create($data);
        if($rs){
            return response()->json(['success'=>$rs]);
        }
        return response()->json(['errors'=> ['Tạo không thành công']],400);
    }

    public function store_api(Request $request){
        $data = $request->all();
        $data['title'] = html_entity_decode($request->title);
        $data['excerpt'] = html_entity_decode($request->excerpt);
        $data['description'] = str_replace('https://billboardvn.vn/wp-content/uploads','https://news-cms.s3-ap-southeast-1.amazonaws.com/images',$request->description);
        $data_seo = $request->all();
        $data_seo['title'] = html_entity_decode($request->title);
        $data_seo['description'] = html_entity_decode($request->excerpt);
        $seo = $this->seoRepository->create($data_seo);
        if($request->format=='standard'){
            $data['format'] = 'default';
        }
        $data['tags_id'] = json_encode($request->get('tags_id'));
        $data['categories_id'] = json_encode($request->get('categories_id'));
        $data['seo_id'] = $seo->id;
        $data['role_id'] = 23;
        $rs = $this->postRepository->updateOrCreate($data);
        if($rs){
            return response()->json(['success'=>$rs]);
        }
        return response()->json(['errors'=> ['Tạo không thành công']],400);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = $this->postRepository->find($id);
        $data->user_name = $this->userRepo->find($data->user_id)->name;
        if($data){
            if($data->thumbnail_id){
                $data['thumbnail_url'] = $this->photoRepository->find($data->thumbnail_id)['url'];
            }
            if($data->thumbnail_highlight){
                $data['highlight_url'] = $this->photoRepository->find($data->thumbnail_highlight)['url'];
            }
            return response()->json(['success'=>$data]);
        }
        return response()->json(['errors'=> ['Not found']]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = \Auth::user();
        $data = $this->postRepository->find($id);
        if($user->id  != $data->user_id && !$user->can('other-post-edit')){
            return response([
                'errors' => 'Bạn không có quyền sửa bài viết của người khác'
            ], 200);
        }
        if($data){
            $data['seoObj'] = $this->seoRepository->find($data->seo_id);
            return response()->json(['success'=>$data]);
        }
        return response()->json(['errors'=> ['Not found']]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'title' => 'required'
        ]);
        DB::beginTransaction();
        try {
            //Tạo bảng sao lưu            
            $post_old = $this->postRepository->find($id)->toArray();
            $post_old['post_id'] = $post_old['id'];
            unset($post_old['id']);
            $post_revision = $this->postRevision->create($post_old);
            //End Tạo bảng sao lưu
            $user = \Auth::user();
            $attributes = $request->all();
            $attributes['date'] = Carbon::parse($request->date);
            $attributes['slug'] = $this->postRepository->getSlug($this->slugify($request->get('slug')),$id);
            $request['id'] = $id;
            if($request->filled('selectedTags')){
                $arrTags = array();
                foreach ($request->selectedTags as $key => $item) {
                    if(!$this->categoryRepository->find($item['id'])){
                        $tags = array(
                            'title' => $item['title'],
                            'slug'  => $this->slugify($item['title']),
                            'taxonomy' => 'tag',
                            'user_id'   => $user->id,
                        );
                        $arrTags[] = $this->categoryRepository->create($tags)->id;
                    }else{
                        $arrTags[] = $item['id'];
                    }
                }
                $attributes['tags_id'] = json_encode($arrTags);
            }
            if($request->filled('categories_id')){
                $attributes['categories_id'] = json_encode($request->categories_id);
            }
            if($request->filled('related_posts')){
                $attributes['related_posts'] = json_encode($request->related_posts);
            }
            $data_seo['title'] = $request->seo['title'] ? $request->seo['title'] : $request->title;
            $data_seo['description'] = $request->seo['description']? $request->seo['description'] : $request->excerpt;
            $seo_id = $this->postRepository->find($id)->seo_id;
            if($seo_id){
                $this->seoRepository->update($seo_id,$data_seo);
            }else{
                $attributes['seo_id'] = $this->seoRepository->create($data_seo)->id;
            }
            $attributes['user_id'] = $user->id;
            $data = $this->postRepository->update($id,$attributes);
            if($data){
                DB::commit();
                return response()->json(['success'=>$data]);
            }
            DB::rollback();
            return response()->json(['error'=>'Lỗi']);
        } catch (\Throwable $th) {
            throw $th;
            DB::rollback();
            return response()->json(['error'=>$th]);
        }
    }

    public function restoreRevision(Request $request,$id){
        $this->validate($request, [ 'title' => 'required' ]);
        DB::beginTransaction();
        try {
            //Tạo bảng sao lưu
            $post_old = $this->postRevision->find($id);
            $post_current = $this->postRepository->find($post_old->post_id)->toArray();
            unset($post_current['id']);
            $post_current['post_id'] = $post_old->post_id;
            $post_revision = $this->postRevision->create($post_current)->toArray();
            //End Tạo bảng sao lưu
            $user = \Auth::user();
            $attributes = $request->all();
            unset($post_old['id']);
            $data = $this->postRepository->update($post_old->post_id,$post_old->toArray());
            if($data){
                DB::commit();
                return response()->json(['success'=>$data]);
            }
            DB::rollback();
            return response()->json(['error'=>'Lỗi']);
        } catch (\Throwable $th) {
            throw $th;
            DB::rollback();
            return response()->json(['error'=>$th]);
        }
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = $this->postRepository->delete($id);
        if($data){
            return response()->json(['success'=>true]);
        }
        return response()->json(['error'=>$id]);
    }
    /**
     * restore the specified resource from storage.
     *
     * @param  int  $id
     * @return bool
     */
    public function restore(Request $request){
        $id = $request->id;
        $rs =  $this->postRepository->restore($id);
        if($rs){
            return response()->json(['success'=>true]);
        }
        return response()->json(['error'=>$id]);
    }

    public function getSlug(Request $request){
        return $this->postRepository->getSlug($request->slug,$request->id);
    }

    public function setPopular(Request $request){
        $data = $this->postRepository->update($request->id,['popular' => !$request->popular]);
        if($data){
            return response()->json(['success'=>$data]);
        }
        return response()->json(['error'=>$data]);
    }
    public function setUserEditing(Request $request){
        return $this->postRepository->update($request->id,['user_editing'=>$request->user_editing]);
    }
}
