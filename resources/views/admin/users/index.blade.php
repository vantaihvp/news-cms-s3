@extends('layouts.admin-lte')

@section('content')
<div class="row">
    <div class="col-lg-12 margin-tb">
        <div class="float-left">
            <h2>Danh sách thành viên</h2>
        </div>
        <div class="float-right">
            @can('user-create')
            <a class="btn btn-success" href="{{ route('user.create') }}"> Thêm mới thành viên</a>
            @endcan
        </div>
    </div>
</div>

@if ($message = Session::get('success'))
<div class="alert alert-success">
  <p>{{ $message }}</p>
</div>
@endif
<div class="card shadow-none border-0">
  <div class="card-body">
    <table class="table table-bordered">
      <tr>
        <th width="10px">STT</th>
        <th>Họ Tên</th>
        <th>Email</th>
        <th>Vai trò</th>
        <th class="text-center" width="180px">Hành động</th>
      </tr>
      @foreach ($data as $key => $user)
        <tr>
          <td>{{ ++$i }}</td>
          <td>{{ $user->name }}</td>
          <td>{{ $user->email }}</td>
          <td>
            @if(!empty($user->getRoleNames()))
              @foreach($user->getRoleNames() as $v)
                <label class="badge badge-success">{{ $v }}</label>
              @endforeach
            @endif
          </td>
          <td class="text-center">
            <a class="btn btn-success" href="{{ route('users.show',$user->id) }}">Show</a>
            <a class="btn btn-primary" href="{{ route('users.edit',$user->id) }}">Edit</a>
              {!! Form::open(['method' => 'DELETE','route' => ['users.destroy', $user->id],'style'=>'display:inline']) !!}
                  {!! Form::submit('Delete', ['class' => 'btn btn-danger']) !!}
              {!! Form::close() !!}
          </td>
        </tr>
      @endforeach
      </table>
  </div>
</div>
{!! $data->render() !!}
@endsection