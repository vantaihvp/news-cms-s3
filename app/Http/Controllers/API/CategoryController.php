<?php

namespace App\Http\Controllers\API;
use Illuminate\Support\Str;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Post\Category\CategoryRepositoryInterface;
use App\Repositories\Seo\SeoRepositoryInterface;
class CategoryController extends Controller
{
    // protected $categoryRepository;
    protected $categoryRepository;
    protected $categories_array = array();
    protected $seoRepository;
    public function __construct(CategoryRepositoryInterface $categoryRepository,SeoRepositoryInterface $seoRepository)
    {
        $this->categoryRepository = $categoryRepository;
        $this->seoRepository = $seoRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        
    }

    public function getAll(){
        $rs = $this->categoryRepository->getAll();
        return response()->json(['success'=>$rs]);
    }

    public function getCategories(Request $request){
        $rs = $this->categoryRepository->getCategories($request);
        if($request->filled('sort') && $request->get('sort')==0){
            return response()->json(['success'=>$rs]);
        }
        $this->sortCategories($rs);
        return response()->json(['success'=>$this->categories_array]);
    }

    public function getTags(Request $request){
        $rs = $this->categoryRepository->getTags($request);
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
        $data = $request->all();
        $user = \Auth::user();

        $slug_Category = $request->slug ? $request->slug : Str::slug($request->title);
        // seo 
        $seoObj = [
            'title' => !empty($request->seo['title']) ? Str::of($request->seo['title'])->trim() : Str::of($request->title)->trim(),
            'slug' => !empty($request->seo['slug']) ? $request->seo['slug'] : $slug_Category,
            'description' => !empty($request->seo['description']) ? $request->seo['description'] : Str::substr($request->description, 0, 158),
            'synonyms' => !empty($request->seo['synonyms']) ? $request->seo['synonyms'] : '',
            'keyword' => !empty($request->seo['keyword']) ? $request->seo['keyword'] : '',
        ];
        $seo = $this->seoRepository->create($seoObj);
        //end seo

        $dataCategory = [
            'title' => Str::of($request->title)->trim(),
            'slug' => $slug_Category,
            'description' => $request->description,
            'thumbnail_id' => $request->thumbnail_id,
            'parent_id' => $request->parent_id,
            'taxonomy' => "category",
            'seo_id' => $seo->id,
            'user_id' => $user->id,
        ];

        $category = $this->categoryRepository->create($dataCategory);
        if($category){
            return response()->json(['success'=>$category]);
        }
        return response()->json(['errors'=> ['Tạo không thành công']]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $data = $this->categoryRepository->find($id);
        if($data){
            return response()->json(['success'=>$data]);
        } 
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $data = $this->categoryRepository->find($id);
        if($data){
            $data['seoObj'] = $this->seoRepository->find($data->seo_id);
            return response()->json(['success'=>$data]);
        }
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
        $user = \Auth::user();
        $attributes = $request->all();
        $slug_Category = $request->slug ? $request->slug : Str::slug($request->title);
        $dataCategory = [
            'title' => Str::of($request->title)->trim(),
            'slug' => $slug_Category,
            'description' => $request->description,
            'parent_id' => $request->parent_id,
            'taxonomy' => "category",
            'user_id' => $user->id,
        ];
        $rsCategory = $this->categoryRepository->update($id,$dataCategory);

        $seoObj = [
            'title' => !empty($request->seo['title']) ? Str::of($request->seo['title'])->trim() : Str::of($request->title)->trim(),
            'slug' => !empty($request->seo['slug']) ? $request->seo['slug'] : $slug_Category,
            'description' => !empty($request->seo['description']) ? $request->seo['description'] : Str::substr($request->description, 0, 158),
            'synonyms' => !empty($request->seo['synonyms']) ? $request->seo['synonyms'] : '',
            'keyword' => !empty($request->seo['keyword']) ? $request->seo['keyword'] : '',
        ];
        $seo_id = $this->categoryRepository->find($id)->seo_id;
        $rsSeo = $this->seoRepository->update($seo_id,$seoObj);

        if($rsCategory && $rsSeo){
            return response()->json(['success'=>$rsCategory]);
        }
        return response()->json(['error'=>'Lỗi']);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $rs = $this->categoryRepository->delete($id);
        if($rs){
            return response()->json(['success'=>$rs]);
        }
    }
    public function sortCategories($categories,$parent = 0, $char =""){
        foreach ($categories as $key => $item) {
            if($item['parent_id']==$parent){
                $item['title'] = $char.$item['title'];
                array_push($this->categories_array,$item);
                unset($categories[$key]);
                $this->sortCategories($categories, $item['id'], $char.'- ');
            }
        }
    }
}
