<?php
namespace App\Repositories\Post\Category;

interface CategoryRepositoryInterface
{
    public function getTags($per_page, $term = '');
    public function getCategories($attributes);
    public function getCategoriesbyArrayId($data);
}