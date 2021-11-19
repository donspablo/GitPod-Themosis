<?php

namespace App\Http\Controllers;

use Illuminate\View\Factory;
use Illuminate\View\View;
use WP_Post;

class PageController extends Controller
{
    /**
     * Handle generic pages.
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function page(WP_Post $post)
    {
        return view('pages.page', [
            'page_data' => [
                'title' => get_the_title($post->ID),
                'content' => apply_filters('the_content', $post->post_content),
            ],
        ]);
    }


    /**
     * Handle custom template page.
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function contact(WP_Post $post)
    {
        return view('pages.template-contact', [
            'page_data' => [
                'title' => get_the_title($post->ID),
                'content' => apply_filters('the_content', $post->post_content),

                'hero_data' => [
                    'title' => 'Custom hero title',
                    'text' => 'Custom hero text',
                ],
            ],
        ]);
    }

    /**
     * Handle 404 page.
     *
     * @return \Illuminate\Contracts\View\Factory|Factory|View
     */
    public function error404()
    {
        return view('pages.404');
    }
}
