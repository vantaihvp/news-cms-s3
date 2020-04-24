@extends('layouts.admin-lte')

@section('content')
<div class="row">
    <div class="col-lg-12 margin-tb">
        <div class="pull-left">
            <h2>Create Post</h2>
        </div>
        <div class="pull-right">
            <a class="btn btn-primary" href="{{ route('roles.index') }}"> Back</a>
        </div>
    </div>
</div>

@if (count($errors) > 0)
    <div class="alert alert-danger">
        <strong>Whoops!</strong> There were some problems with your input.<br><br>
        <ul>
        @foreach ($errors->all() as $error)
            <li>{{ $error }}</li>
        @endforeach
        </ul>
    </div>
@endif

{!! Form::open(array('route' => 'post.store','method'=>'POST')) !!}
<div class="row">
    <div class="col-md-12">
        <div class="form-group">
          <label for="">Title</label>
          <input type="text"
            class="form-control" name="title" id="" aria-describedby="helpId" placeholder="">
        </div>
        <div class="form-group">
          <label for="">Description</label>
          <input type="text"
            class="form-control" name="description" id="" aria-describedby="helpId" placeholder="">
        </div>
        {!! Form::submit('Lưu') !!}
    </div>
</div>
{!! Form::close() !!}

@endsection