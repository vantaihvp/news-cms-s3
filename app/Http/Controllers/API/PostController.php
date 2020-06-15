<?php

namespace App\Http\Controllers\API;
use Carbon\Carbon;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Post\PostRepositoryInterface;
use Illuminate\Support\Facades\Auth;
use App\Repositories\Post\Category\CategoryRepositoryInterface;
class PostController extends Controller
{
    protected $postRepository;
    protected $categoryRepository;
    public function __construct(PostRepositoryInterface $postRepository,CategoryRepositoryInterface $categoryRepository)
    {
        $this->postRepository = $postRepository;
        $this->categoryRepository = $categoryRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $rs = $this->postRepository->getWithPaginate($request);
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
        if($request->filled('slug')){
            $data['slug'] = $this->slugify($request->get('slug'));
        }else{
            $data['slug'] = $this->slugify($request->get('title'));
        }
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

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = $this->postRepository->find($id);
        if($data){
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
        $user = \Auth::user();
        $attributes = $request->all();
        $attributes['date'] = Carbon::parse($request->date);
        if($request->filled('slug')){
            $attributes['slug'] = $this->slugify($request->get('slug'));
        }else{
            $attributes['slug'] = $this->slugify($request->get('title'));
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
        $attributes['tags_id'] = json_encode($arrTags);
        $attributes['categories_id'] = json_encode($request->categories_id);
        $attributes['related_posts'] = json_encode($request->related_posts);
        $data = $this->postRepository->update($id,$attributes);
        if($data){
            return response()->json(['success'=>$data]);
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
}
