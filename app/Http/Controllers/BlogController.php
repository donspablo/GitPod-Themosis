<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\View\Factory;
use Illuminate\View\View;
use WP_Post;
use function App\Theme\get_single_post_data;

class BlogController extends Controller
{
    /**
     * Handle blog main page / blog archive.
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function index()
    {
        return view('blog.blog');
    }

    /**
     * Handle single post.
     *
     * @param WP_Post $post
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function single(WP_Post $post)
    {
        $page_data = get_single_post_data($post->ID);

        return view('blog.single-post', [
            'page_data' => $page_data,
        ]);
    }

    /**
     * Handle search page.
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function search(Request $request)
    {
        return view('blog.search', [
            'searched_terms' => $request->get('s'),
        ]);
    }
}
