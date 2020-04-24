<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
         $this->middleware('permission:role-list|role-create|role-edit|role-delete|user-create|user-edit', ['only' => ['index','store']]);
         $this->middleware('permission:role-create', ['only' => ['create','store']]);
         $this->middleware('permission:role-edit', ['only' => ['edit','update']]);
         $this->middleware('permission:role-delete', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $roles = Role::orderBy('id','DESC')->get();
        return response()->json($roles, 200);
        // return view('admin.roles.index',compact('roles'))
        //     ->with('i', ($request->input('page', 1) - 1) * 5);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $permissions = $this->getPermissionsByGroup();
        return response()->json(['groups' => $permissions ], 200);
    }
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();
        $validator = Validator::make($data, [
            'name' => ['required', 'string', 'max:255', 'unique:roles', 'not_regex:/[#$%^&*()+=\-\[\]\';,.\/{}|":<>?~\\\\]/'],
        ]);
        $validator->validate();
        // return $request->name;
        $role = Role::create([
            'name' => $data['name'],
        ]);
        if ($role){
            //Permissions
            $permissions = Permission::get();
            foreach ($permissions as $p) {
                if(isset($data[$p->name]) && $data[$p->name] == "on"){
                    $role->givePermissionTo($p);
                } else {
                    $role->revokePermissionTo($p);
                }
            }
            return response()->json(['success'=>$role], 200);
        } else {
            return response()->json(['error'=>"There has been an error!"], 401);
        }
    }
    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $role = Role::find($id);
        $rolePermissions = Permission::join("role_has_permissions","role_has_permissions.permission_id","=","permissions.id")
            ->where("role_has_permissions.role_id",$id)
            ->get();
        $data = array('role' => $role, 'rolePermissions'=>$rolePermissions );
        return response()->json($data, 200);
        // return view('admin.roles.show',compact('role','rolePermissions'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $role = Role::with('permissions')->find($id);
        $permissions = $this->getPermissionsByGroup();
        if($role){
            return response()->json(['groups' => $permissions,'role' => $role], 200);
        } else {
            return response()->json('error', 404);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request,$id)
    {   
        $role = Role::find($id);
        if($role){
            $data = $request->all();

            $validator = Validator::make($data, [
                'name' => ['required', 'string', 'max:255', Rule::unique('roles')->ignore($role), 'not_regex:/[#$%^&*()+=\-\[\]\';,.\/{}|":<>?~\\\\]/'],
            ]);

            $validator->validate();

            $role->name = $data['name'];
            if($role->save()){
                //Permissions
                $permissions = Permission::get();
                foreach ($permissions as $p) {
                    if(isset($data[$p->name]) && $data[$p->name] == "on"){
                        $role->givePermissionTo($p);
                    } else {
                        $role->revokePermissionTo($p);
                    }
                }
                return response()->json(['susscess'=>$id], 200);
                // return redirect('/admin/roles/'.$id)->with('success',__("Role updated!"));
            } else {
                return response()->json(['error'=>'There has been an error!'], 401);
            }
        } else {
            return response()->json(['error'=>'Role not found!'], 404);
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
        DB::table("roles")->where('id',$id)->delete();
        return response()->json(['success'=>'Xóa thành công']);
        return redirect()->route('roles.index')
                        ->with('success','Role deleted successfully');
    }
    public function getPermissionsByGroup(){
        $permissions = Permission::get();
        $group_arr = [];

        foreach ($permissions as $permission) {
            if($permission->group_slug !== null && !in_array($permission->group_slug, $group_arr)){
                $group_arr[] = $permission->group_slug;
            }
        }
        foreach ($permissions as $permission) {
            if($permission->group_slug == null && !in_array($permission->group_slug, $group_arr)){
                $group_arr[] = $permission->group_slug;
            }
        }
        foreach ($permissions as $permission) {
            foreach ($group_arr as $group) {
                if($permission->group_slug == $group) {
                    $groups[$permission->group_slug]['name'] = $permission->group_name;
                    $groups[$permission->group_slug]['permissions'][] = $permission->toArray();
                }
            }
        }
        $collection = collect($groups);

        return $collection;
    }
    public function getAllPermissions()
    {
        $permissions = Permission::get();
        return response()->json($permissions, 200);
    }
}
