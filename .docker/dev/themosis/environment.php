<?php

return function()
{
    // Check for the environment variable
    if ('development' === getenv('WP_ENV') || 'development' === $_SERVER['WP_ENV'])
    {
        // Return the environment file slug name: .env.{$slug}.php
        return 'development';
    }

    // Else if no environment variable found... it might be a production environment...
    return 'production';
};