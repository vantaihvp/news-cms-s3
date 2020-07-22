<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Slider\Categories\CategoriesSliderRepositoryInterface;
class CategorySliderController extends Controller
{
    // protected $cSliderRepository;
    protected $cSliderRepository;
    public function __construct(CategoriesSliderRepositoryInterface $cSliderRepository)
    {
        $this->cSliderRepository = $cSliderRepository;
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $rs = $this->cSliderRepository->index($request);
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
        $rs = $this->cSliderRepository->create($data);
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
        $data = $this->cSliderRepository->find($id);
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
        $data = $this->cSliderRepository->find($id);
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
        $attributes = $request->all();
        $data = $this->cSliderRepository->update($id,$attributes);
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
        $rs = $this->cSliderRepository->delete($id);
        if($rs){
            return response()->json(['success'=>$rs]);
        }
    }
}
