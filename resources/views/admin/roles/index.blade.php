@extends('layouts.admin-lte')

@section('content')
<div class="row">
    <div class="col-lg-12 mb-2">
        <div class="float-left">
            <h2>Role Management</h2>
        </div>
        <div class="float-right">
            @can('role-create')
            <a class="btn btn-success" href="{{ route('roles.create') }}"> Thêm mới Role</a>
            @endcan
        </div>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="card shadow-none border-0">
            <div class="card-body">
                @if ($message = Session::get('success'))
                <div class="alert alert-success">
                    <p>{{ $message }}</p>
                </div>
                @endif

                <table class="table table-bordered">
                    <tr>
                        <th width="20px">STT</th>
                        <th>Tiêu đề</th>
                        <th class="text-center" width="178px">Hành động</th>
                    </tr>
                    @foreach ($roles as $key => $role)
                    <tr>
                        <td width="20px">{{ ++$i }}</td>
                        <td>{{ $role->name }}</td>
                        <td class="text-center">
                            <a class="btn btn-info" href="{{ route('roles.show',$role->id) }}">Show</a>
                            @can('role-edit')
                            <a class="btn btn-primary" href="{{ route('roles.edit',$role->id) }}">Edit</a>
                            @endcan
                            @can('role-delete')
                            {!! Form::open(['method' => 'DELETE','route' => ['roles.destroy',
                            $role->id],'style'=>'display:inline']) !!}
                            {!! Form::submit('Delete', ['class' => 'btn btn-danger']) !!}
                            {!! Form::close() !!}
                            @endcan
                        </td>
                    </tr>
                    @endforeach
                </table>

                {!! $roles->render() !!}
            </div>
        </div>
    </div>
</div>
@endsection
