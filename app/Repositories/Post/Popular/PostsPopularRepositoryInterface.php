<?php
namespace App\Repositories\Post\Popular;

interface PostsPopularRepositoryInterface
{
    public function getByPostId($post_id);
    public function index(array $request);
}