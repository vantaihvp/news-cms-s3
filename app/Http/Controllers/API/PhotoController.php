<?php

namespace App\Http\Controllers\API;
use Carbon\Carbon;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Repositories\Photo\PhotoRepositoryInterface;

use Illuminate\Support\Facades\Storage;
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
        foreach ($rs as $key => $value) {
            $value['url'] = 'https://'.env('AWS_BUCKET').'.s3-'.env('AWS_DEFAULT_REGION').'.'.'amazonaws.com/'. $value->url;
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
           'image' => 'required|image|max:200'
        ],[
            'image.required' => 'Chưa chọn hình ảnh',
            'image.image' => 'Định dạng không được hỗ trợ',
            'image.max' => 'Giới hạn tối đa là 200kb',
        ]);
        $dt = Carbon::now('Asia/Ho_Chi_Minh')->addHours('7');
        $month = $dt->month;
        if($month<10){
            $month ='0'+$month;
        }
        $path = $request->file('image')->store('images/'.$dt->year.'/'.$month,'s3');
        Storage::disk('s3')->setVisibility($path, 'public');
        $path_arr = explode('/',$path);
        $data = $request->all();
        $data['name'] = $path_arr[(count($path_arr)-1)];
        $data['url'] =  $path;
        $data['user_id'] = \Auth::user()->id;
        $rs = $this->photoRepository->create($data);
        if($rs){
            $rs['url'] = 'https://'.env('AWS_BUCKET').'.s3-'.env('AWS_DEFAULT_REGION').'.'.'amazonaws.com/'. $rs->url;
            return response()->json(['success'=>$rs]);
        }
        return response()->json(['errors'=> ['Tạo không thành công']]);
    }

    public function store_api(Request $request){
        $data = $request->all();
        if($request->name==''){
            $data['name'] = 'no_name';
        }
        $data['user_id'] = \Auth::user()->id;
        $data['url'] = str_replace("https://billboardvn.vn/wp-content/uploads/","images/",$request->url);
        $rs = $this->photoRepository->updateOrCreate($data);
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
            $data['url'] = 'https://'.env('AWS_BUCKET').'.s3-'.env('AWS_DEFAULT_REGION').'.'.'amazonaws.com/'. $data['url'];
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

        if(Storage::disk('s3')->delete($data->url)){
            $rs = $this->photoRepository->delete($id);
            if($rs){
                return response()->json(['success'=>true]);
            }
            return response()->json(['error'=>$id]);
        }
        return response()->json(['error'=>$id]);
        
    }
}
