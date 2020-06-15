<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Post\Category\CategoryRepositoryInterface;
class CategoryController extends Controller
{
    // protected $categoryRepository;
    protected $categoryRepository;
    protected $categories_array = array();
    public function __construct(CategoryRepositoryInterface $categoryRepository)
    {
        $this->categoryRepository = $categoryRepository;
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
        $data['user_id'] = \Auth::user()->id;
        if($request->filled('slug')){
            $data['slug'] = $this->slugify($request->get('slug'));
        }else{
            $data['slug'] = $this->slugify($request->get('title'));
        }
        if($request->filled('taxonomy')){
            $data['taxonomy'] = $request->get('taxonomy');
        }
        $rs = $this->categoryRepository->create($data);
        if($rs){
            return response()->json(['success'=>$rs]);
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
        $attributes = $request->all();
        $data = $this->categoryRepository->update($id,$attributes);
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
