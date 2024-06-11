<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Contact;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;

class ContactController extends Controller
{
    public function get()
    {
        try {
            $data = Contact::all();
            return response()->json($data, 200);
        } catch (\Throwable $t) {
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }

    public function create(Request $request)
    {
        // Validation des données
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'first_name' => 'required|string|max:255',
            'numTel' => 'required|string|max:20',
            'image' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        try {
            // Stockage de l'image
            if ($request->hasFile('image')) {
                $fileName = $request->image->getClientOriginalName();
                $request->image->move(public_path('ImageContact'), $fileName);
                $validated['image'] = $fileName;
            }

            // Création du contact
            $contact = Contact::create($validated);

            // Réponse JSON
            return response()->json($contact, 201); // Utilisez le code de statut 201 pour indiquer que la ressource a été créée
        } catch (\Throwable $t) {
            // En cas d'erreur, renvoyer un message d'erreur avec un code de statut 500
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }



    public function getById($id)
    {
        try {
            $contact = Contact::findOrFail($id);
            return response()->json($contact, 200);
        } catch (\Throwable $t) {
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }

    public function update(Request $request, $id)
    {
        // Validation des données
        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'first_name' => 'sometimes|required|string|max:255',
            'numTel' => 'sometimes|required|string|max:20',
            'image' => 'sometimes|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        try {
            $contact = Contact::findOrFail($id);

            // Ajout de logs pour vérifier les données reçues
            Log::info('Données de mise à jour reçues :', $request->all());

            // Gestion de l'image
            if ($request->hasFile('image')) {
                // Supprimer l'ancienne image si elle existe
                if ($contact->image) {
                    Storage::disk('public')->delete('ImageContact/' . $contact->image);
                }

                $fileName = $request->file('image')->getClientOriginalName();
                $request->file('image')->move(public_path('ImageContact'), $fileName);
                $validated['image'] = $fileName;
            }

            // Mise à jour du contact
            $contact->update($validated);

            // Ajout de logs pour vérifier les données mises à jour
            Log::info('Contact mis à jour avec succès :', ['contact' => $contact]);

            return response()->json($contact, 200);
        } catch (\Throwable $t) {
            Log::error('Erreur lors de la mise à jour du contact :', ['error' => $t->getMessage()]);
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }

    



    public function delete($id)
    {
        try {
            $contact = Contact::findOrFail($id);

            // Supprimer l'image si elle existe
            if ($contact->image) {
                Storage::disk('public')->delete($contact->image);
            }

            $contact->delete();

            return response()->json(['message' => 'Contact deleted successfully'], 200);
        } catch (\Throwable $t) {
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }
}
