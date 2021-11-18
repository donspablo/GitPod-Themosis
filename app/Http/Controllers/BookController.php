<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\View\Factory;
use Illuminate\View\View;
use WP_Post;

class BookController extends Controller
{
    /**
     * Books archive page.
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function archive()
    {
        return view('books.archive');
    }

    /**
     * Single book page.
     *
     * @param WP_Post $book
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function single(WP_Post $book)
    {
        return view('books.single', [
            'page_data' => [

            ],
        ]);
    }
}
