<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users_comptes',
            'password' => 'required|string|min:6|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = $user->createToken('MyApp')->plainTextToken;

        return response()->json(['token' => $token, 'name' => $user->name], 201);
    }

    public function login(Request $request)
    {
        // Recherche de l'utilisateur par email
        $user = User::where('email', $request->email)->first();

        // Vérification de l'utilisateur et de son mot de passe
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['error' => 'L\'authentification est incorrect'], 401);
        }

        // Génération du jeton d'authentification
        $token = $user->createToken('MyApp')->plainTextToken;

        // Création de la réponse JSON avec le jeton et le nom de l'utilisateur
        $success['token'] = $token;
        $success['name'] = $user->name;

        return response()->json(['success' => $success]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Successfully logged out']);
    }

    public function user(Request $request)
    {
        return response()->json(Auth::user());
    }
}
