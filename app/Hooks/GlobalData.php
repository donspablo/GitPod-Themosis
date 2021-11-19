<?php

namespace App\Hooks;

use Themosis\Hook\Hookable;
use View;
use function App\Theme\get_menu_items;

class GlobalData extends Hookable
{
    // We need to use 'wp' so WC functions and all queries are already loaded
    public $hook = 'wp';


    /**
     * Add global data shared across all views.
     * You can use it as $global_data variable.
     */
    public function register()
    {
        if (is_admin()) {
            return;
        }

        // Get MB Theme Settings
        $theme_settings = get_option('_theme_settings');

        View::share([
            'global_data' => [
                'site_name' => get_bloginfo('name'),
                'site_description' => get_bloginfo('description'),
                'site_logo_url' => get_stylesheet_directory_uri() . '/assets/images/logo.svg',
                'home_url' => get_home_url(),
                'image_path' => get_stylesheet_directory_uri() . '/assets/images/', // used in Jigsaw

                'primary_menu_items' => get_menu_items('main-menu'),

                // Social
                'social' => [
                    'facebook' => $theme_settings['facebook_url'] ?? '',
                    'instagram' => $theme_settings['instagram_url'] ?? '',
                    'twitter' => $theme_settings['twitter_url'] ?? '',
                    'youtube' => $theme_settings['youtube_url'] ?? '',
                ],

            ],
        ]);
    }
}
