@extends('layouts.admin-lte')

@section('content')

    <div class="page-header">
        <div class="page-title">
            <h4>{{__('Roles')}}</h4>
        </div>
    </div>
	
    <div class="content">
        <div class="card bg-white">
            <div class="card-body">
                <form method="POST" action="{{ route('roles.store') }}">
                    @csrf
                    <div class="form-group row">
                        <div class="col-md-2">{{ __('Name') }}</div>
                        <div class="col-md-8">
                            <input id="name" type="text" class="form-control{{ $errors->has('name') ? ' is-invalid' : '' }}" name="name" value="{{ old('name') }}" required autofocus>

                            @if ($errors->has('name'))
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{ $errors->first('name') }}</strong>
                                </span>
                            @endif
                        </div>
                    </div>

                    <div class="form-group row">
                        <div class="col-md-2">{{ __('Permissions') }}</div>
                        <div class="col-md-8">
                            <table class="table table-striped table-bordered permissions_table">
                                @foreach($groups as $group)
                                    <tr>
                                        <td>
                                            <h6 class="mb-2 font-weight-bold"><label>{{$group['name']}}</label></h6>

                                            <div>
                                                @foreach($group['permissions'] as $perm)
                                                    <label class="mr-4">
                                                        <input type="checkbox" name="{{$perm['name']}}">
                                                        {{$perm['display_name'] !== null ? $perm['display_name'] : $perm['name']}}
                                                    </label>
                                                @endforeach
                                            </div>
                                        </td>
                                        
                                    </tr>
                                @endforeach
                            </table>
                        </div>
                    </div>
                  
                    <div class="form-group row mb-0">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <button type="submit" class="btn btn-primary">
                                {{ __('Create') }}
                            </button>
                            <a href="{{route('roles.index')}}" class="btn btn-danger">
                                {{ __('Cancel') }}
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
