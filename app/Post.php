<?php

namespace App;

use App\Scopes\PostTypeScope;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    const UPDATED_AT = 'post_modified';
    const CREATED_AT = 'post_date';
    protected static $post_type = 'post';
    protected $primaryKey = 'ID';
    protected $table = 'posts';

    /**
     * Apply a post type scope to model.
     */
    protected static function boot()
    {
        parent::boot();

        static::addGlobalScope(new PostTypeScope(static::$post_type));
    }
}
