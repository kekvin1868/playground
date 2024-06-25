<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckApiKey
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $apiKey = 'test';

        // $requestApiKey = 'test';
        $requestApiKey = $request->header('x-api-key');

        if ($requestApiKey && $requestApiKey == $apiKey) {
            return $next($request);
        }

        return response()->json(['message' => 'Invalid API key'], 403);
    }
}
