@extends('layouts.admin-lte')

@section('content')
<div class="row">
    <div class="col-lg-12 margin-tb">
        <div class="pull-left">
            <h2>Post Management</h2>
        </div>
        <div class="pull-right">
        @can('role-create')
            <a class="btn btn-success" href="{{ route('post.create') }}"> Create New post</a>
            @endcan
        </div>
    </div>
</div>

@if ($message = Session::get('success'))
    <div class="alert alert-success">
        <p>{{ $message }}</p>
    </div>
@endif

<table class="table table-bordered">
  <tr>
     <th>No</th>
     <th>Name</th>
     <th width="280px">Action</th>
  </tr>
  @foreach ($data as $item)
      <tr>
          <td>{{$item->id}}</td>
          <td>{{$item->title}}</td>
        <td width="280px">Action</td>
    </tr>
  @endforeach
</table>

{!! $data->render() !!}

@endsection