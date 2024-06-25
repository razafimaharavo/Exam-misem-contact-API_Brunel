<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Notifications\WelcomeEmail;
use Illuminate\Support\Facades\Notification;

class AuthController extends Controller
{
    /**
     * @OA\Post(
     *     path="/register",
     *     operationId="registerUser",
     *     tags={"Authentication"},
     *     summary="Register a new user",
     *     description="Register a new user and return the authentication token",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="name", type="string"),
     *             @OA\Property(property="email", type="string"),
     *             @OA\Property(property="password", type="string"),
     *             @OA\Property(property="password_confirmation", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="User registered successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="token", type="string"),
     *             @OA\Property(property="name", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="errors", type="object")
     *         )
     *     )
     * )
     */

    //Code pour faire le registre
    // public function register(Request $request)
    // {
    //     $validator = Validator::make($request->all(), [
    //         'name' => 'required|string|max:255',
    //         'email' => 'required|string|email|max:255|unique:users_comptes',
    //         'password' => 'required|string|min:6|confirmed',
    //     ]);

    //     if ($validator->fails()) {
    //         return response()->json(['errors' => $validator->errors()], 422);
    //     }

    //     $user = User::create([
    //         'name' => $request->name,
    //         'email' => $request->email,
    //         'password' => Hash::make($request->password),
    //     ]);

    //     $token = $user->createToken('MyApp')->plainTextToken;

    //     return response()->json(['token' => $token, 'name' => $user->name], 201);
    // }

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

        // Envoyer l'email de bienvenue
        Notification::send($user, new WelcomeEmail());

        return response()->json(['token' => $token, 'name' => $user->name], 201);
    }


    /**
     * @OA\Post(
     *     path="/login",
     *     operationId="loginUser",
     *     tags={"Authentication"},
     *     summary="Log in a user",
     *     description="Log in a user and return the authentication token",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="email", type="string"),
     *             @OA\Property(property="password", type="string")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="User logged in successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="success", type="object", 
     *                 @OA\Property(property="token", type="string"),
     *                 @OA\Property(property="name", type="string")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Authentication error",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="error", type="string")
     *         )
     *     )
     * )
     */

    //code pour faire le login
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


    /**
     * @OA\Post(
     *     path="/logout",
     *     operationId="logoutUser",
     *     tags={"Authentication"},
     *     summary="Log out a user",
     *     description="Log out the currently authenticated user",
     *     @OA\Response(
     *         response=200,
     *         description="User logged out successfully",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string")
     *         )
     *     )
     * )
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json(['message' => 'Successfully logged out']);
    }


    /**
     * @OA\Get(
     *     path="/user",
     *     operationId="getUser",
     *     tags={"Authentication"},
     *     summary="Get authenticated user",
     *     description="Get details of the currently authenticated user",
     *     @OA\Response(
     *         response=200,
     *         description="Authenticated user details",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="id", type="integer"),
     *             @OA\Property(property="name", type="string"),
     *             @OA\Property(property="email", type="string")
     *         )
     *     )
     * )
     */

    public function user(Request $request)
    {
        return response()->json(Auth::user());
    }
}
