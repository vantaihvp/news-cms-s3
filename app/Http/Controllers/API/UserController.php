<?php
namespace App\Http\Controllers\API;
use Illuminate\Http\Request; 
use App\Http\Controllers\Controller; 
use App\Models\User; 
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Auth; 
use Validator;
use DB;
use Hash;
use App\Repositories\User\UserRepositoryInterface;
use App\Repositories\Post\Category\CategoryRepositoryInterface;
class UserController extends Controller 
{
    public $successStatus = 200;
    protected $userRepository;

    public function __construct(UserRepositoryInterface $userRepository)
    {
        $this->userRepository = $userRepository;
        $this->middleware('permission:user-list|user-create|user-edit|user-delete', ['only' => ['index','store']]);
        $this->middleware('permission:user-create', ['only' => ['create','store']]);
        $this->middleware('permission:user-edit', ['only' => ['edit','update']]);
        $this->middleware('permission:user-delete', ['only' => ['destroy']]);
    }
    /** 
     * login api 
     * 
     * @return \Illuminate\Http\Response 
     */ 

    
    public function login(){ 
        if(Auth::attempt(['email' => request('email'), 'password' => request('password')])){ 
            $user = Auth::user(); 
            $success['token'] =  $user->createToken('MyApp')-> accessToken; 
            return response()->json(['success' => $success], $this-> successStatus); 
        } 
        else{ 
            return response()->json(['error'=>'Unauthorised'], 401); 
        } 
    }
    /** 
     * Register api 
     * 
     * @return \Illuminate\Http\Response 
     */ 
    public function register(Request $request) 
    { 
        $validator = Validator::make($request->all(), [ 
            'name' => 'required', 
            'email' => 'required|email', 
            'password' => 'required', 
            'c_password' => 'required|same:password', 
        ]);
        if ($validator->fails()) { 
            return response()->json(['error'=>$validator->errors()], 401);            
        }
        $input = $request->all(); 
        $input['password'] = bcrypt($input['password']); 
        $user = User::create($input); 
        $success['token'] =  $user->createToken('MyApp')-> accessToken; 
        $success['name'] =  $user->name;
        return response()->json(['success'=>$success], $this-> successStatus); 
    }
    /** 
     * details api 
     * 
     * @return \Illuminate\Http\Response 
     */ 
    public function details() 
    { 
        $user = Auth::user(); 
        return response()->json(['success' => $user], $this-> successStatus); 
    }
    public function getAllPermissionsAttribute() {
        $permissions = [];
        foreach (Permission::all() as $permission) {
            if (Auth::user()->can($permission->name)) {
                $permissions[] = $permission->name;
            }
        }
        return $permissions;
    }
    public function index(Request $request){
        $term = '';
        if($request->filled('s')){
            $term = $request->get('s');

        }
        $user = $this->userRepository->getAllPaginate(10,$term);
        return response()->json(['success' => $user], $this-> successStatus);
    }
    public function show($id)
    {
        $user = $this->userRepository->find($id);
        if(!Auth::user()){
            $data['id'] = $user->id;
            $data['name'] = $user->name;
            $data['pseudonym'] = $user->pseudonym;
            return response()->json(['success'=> $data]);
        }
        $userRole = $user->roles->pluck('name','name')->all();
        $data = array('user' => $user, 'userRole'=>$userRole);
        if($user){
            return response()->json(['success'=> $data]);
        }
        return response()->json(['error'=> "Lỗi không tải được user"]);
    }
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|same:confirm-password',
            'roles' => 'required',
        ]);
        $rs = $this->userRepository->create($request->all());
        if($rs){
            return response()->json(['success'=>$rs]);
        }
        return response()->json(['errors'=> ['Tạo không thành công']]);
    }
    public function update(Request $request, $id)
    {
        $validatedData = $request->validate([
            'name' => 'required',
            'password' => 'same:confirm-password',
            'roles' => 'required'
            ]);
        $input = $request->all();
        if(!empty($input['password'])){ 
            $input['password'] = Hash::make($input['password']);
        }else{
            $input['password'] = User::find($id)->password;
        }

        $user = User::find($id);
        $user->update($input);
        DB::table('model_has_roles')->where('model_id',$id)->delete();

        $user->assignRole($request->input('roles'));
        return response()->json(['success'=>$user], 200);
    }public function destroy($id)
    {
        User::find($id)->delete();
        return response()->json(['success'=>'Xóa thành công']);
    }
}