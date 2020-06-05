<?php
namespace App\Repositories\Post\Category;

interface CategoryRepositoryInterface
{
    public function getTags($attributes);
    public function getCategories($attributes);
    public function getCategoriesbyArrayId($data);
}