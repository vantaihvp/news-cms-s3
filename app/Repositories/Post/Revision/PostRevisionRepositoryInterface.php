<?php
namespace App\Repositories\Post\Revision;

interface PostRevisionRepositoryInterface
{
    public function getByPostId($post_id);
    public function index(array $request);
}