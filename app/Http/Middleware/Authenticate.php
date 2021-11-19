<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as AuthenticateMiddleware;
use Illuminate\Http\Request;

class Authenticate extends AuthenticateMiddleware
{
    /**
     * Define where to redirect the user to.
     *
     * @param Request $request
     *
     * @return string
     */
    protected function redirectTo($request)
    {
        return '/';
    }
}
