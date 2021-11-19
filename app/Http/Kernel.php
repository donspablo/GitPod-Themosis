<?php

namespace App\Http;

use App\Http\Middleware\Authenticate;
use App\Http\Middleware\RedirectIfAuthenticated;
use Illuminate\Auth\Middleware\EnsureEmailIsVerified;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Routing\Middleware\ThrottleRequests;
use Illuminate\Routing\Middleware\ValidateSignature;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\View\Middleware\ShareErrorsFromSession;
use Themosis\Core\Http\Kernel as HttpKernel;
use Themosis\Route\Middleware\WordPressAuthorize;
use Themosis\Route\Middleware\WordPressBindings;
use Themosis\Route\Middleware\WordPressBodyClass;
use Themosis\Route\Middleware\WordPressHeaders;

class Kernel extends HttpKernel
{
    /**
     * The application's global HTTP middleware stack.
     *
     * These middleware are run during every request to your application.
     *
     * @var array
     */
    protected $middleware = [];

    /**
     * The application's route middleware groups.
     *
     * @var array
     */
    protected $middlewareGroups = [
        'admin' => [
            StartSession::class,
            ShareErrorsFromSession::class
        ],
        'web' => [
            'wp.headers',
            'wp.bindings',
            'bindings',
            StartSession::class,
            ShareErrorsFromSession::class,
            // 'csrf',
            WordPressBodyClass::class
        ],
        'api' => [
            'throttle:60,1',
            'wp.can:edit_posts',
            'bindings'
        ]
    ];

    /**
     * The application's route middleware.
     * Aliased middleware. Can be used individually or within groups.
     *
     * @var array
     */
    protected $routeMiddleware = [
        'auth' => Authenticate::class,
        'bindings' => SubstituteBindings::class,
        /**
         * Disable CSRF, because this functionality is causing issues with Woocommerce.
         * https://github.com/donpablonow/themosis/themosis/issues/301
         */
        // 'csrf' => \App\Http\Middleware\VerifyCsrfToken::class,
        'guest' => RedirectIfAuthenticated::class,
        'signed' => ValidateSignature::class,
        'throttle' => ThrottleRequests::class,
        'verified' => EnsureEmailIsVerified::class,
        'wp.bindings' => WordPressBindings::class,
        'wp.can' => WordPressAuthorize::class,
        'wp.headers' => WordPressHeaders::class
    ];
}
