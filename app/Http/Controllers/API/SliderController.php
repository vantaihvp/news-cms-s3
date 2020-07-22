<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Slider\SliderRepositoryInterface;
use App\Repositories\Photo\PhotoRepositoryInterface;
use App\Repositories\Slider\Categories\CategoriesSliderRepositoryInterface;
class SliderController extends Controller
{
    // protected $SliderRepository;
    protected $SliderRepository;
    protected $photoRepository;
    protected $cSliderRepository;
    public function __construct(SliderRepositoryInterface $SliderRepository,PhotoRepositoryInterface $photoRepository,CategoriesSliderRepositoryInterface $cSliderRepository)
    {
        $this->SliderRepository = $SliderRepository;
        $this->photoRepository = $photoRepository;
        $this->cSliderRepository = $cSliderRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $rs = $this->SliderRepository->index($request);
        foreach ($rs as $key => $value) {
            if($value->thumbnail_id){
                $value['thumbnail'] = env('URL_S3').'/'.$this->photoRepository->find($value->thumbnail_id)->url;
            }
            if($value->slider_category_id){
                $value['category'] = $this->cSliderRepository->find($value->slider_category_id)->title;
            }
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
            'title' => 'required',
            'url' => 'required',
        ]);
        $data = $request->all();
        $data['user_id'] = \Auth::user()->id;
        $rs = $this->SliderRepository->create($data);
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
        $data = $this->SliderRepository->find($id);
        if($data){
            if($data->thumbnail_id){
                $data['thumbnail'] = env('URL_S3').'/'.$this->photoRepository->find($data->thumbnail_id)->url;
            }
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
        $data = $this->SliderRepository->find($id);
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
        $data = $this->SliderRepository->update($id,$attributes);
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
        $rs = $this->SliderRepository->delete($id);
        if($rs){
            return response()->json(['success'=>$rs]);
        }
    }
}
