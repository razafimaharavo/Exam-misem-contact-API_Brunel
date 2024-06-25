<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{{ config('app.name', 'Laravel') }}</title>
    <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
    <!-- Ajouter les styles Bootstrap -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="navbar navbar-expand-lg navbar-dark">
        <a class="navbar-brand" href="{{ url('/') }}">{{ config('app.name', 'Laravel') }}</a>
        <div class="navbar-nav ml-auto">
            @if (Route::has('login'))
                @auth
                    <a class="nav-link" href="{{ url('/home') }}">Home</a>
                @else
                    <a class="nav-link" href="{{ route('login') }}">Login</a>
                    @if (Route::has('register'))
                        <a class="nav-link" href="{{ route('register') }}">Register</a>
                    @endif
                @endauth
            @endif
        </div>
    </div>

    <div class="container">
        @yield('content')
    </div>
</body>
</html>
