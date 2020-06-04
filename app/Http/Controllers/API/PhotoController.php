<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Photo\PhotoRepositoryInterface;
class PhotoController extends Controller
{
    protected $photoRepository;
    public function __construct(PhotoRepositoryInterface $photoRepository)
    {
        $this->photoRepository = $photoRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $rs = $this->photoRepository->getWithPaginate($request);
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
        $imageName = time().'.'.$request->image->getClientOriginalExtension();
        $request->image->move(public_path('images/frontend/post'), $imageName);
        $data = $request->all();
        $data['name'] = $imageName;
        $data['url'] = '/frontend/post/'.$imageName;
        $data['user_id'] = \Auth::user()->id;
        $rs = $this->photoRepository->create($data);
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
        $data = $this->photoRepository->find($id);
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
        //
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
        unset($attributes['url']);
        $data = $this->photoRepository->update($id,$attributes);
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
        if($id==1){
            return response()->json(['error'=>'Không thể xóa hình này'],400);
        }
        $data = $this->photoRepository->find($id);
        // return public_path('images').$data->url;
        if(unlink(public_path('images').$data->url)){
            $rs = $this->photoRepository->delete($id);
            if($rs){
                return response()->json(['success'=>true]);
            }
            return response()->json(['error'=>$id]);
        }
        return response()->json(['error'=>$id]);
        
    }
}
