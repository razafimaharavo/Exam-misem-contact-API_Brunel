<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\UpdateContactRequest;
use App\Http\Requests\NewContactRequest;
use App\Models\Contact;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;

/**
 * @OA\Schema(
 *     schema="Contact",
 *     type="object",
 *     properties={
 *         @OA\Property(property="id", type="integer"),
 *         @OA\Property(property="name", type="string"),
 *         @OA\Property(property="first_name", type="string"),
 *         @OA\Property(property="numTel", type="string"),
 *         @OA\Property(property="image", type="string")
 *     }
 * )
 *
 * @OA\Schema(
 *     schema="NewContact",
 *     type="object",
 *     required={"name", "first_name", "numTel", "image"},
 *     properties={
 *         @OA\Property(property="name", type="string"),
 *         @OA\Property(property="first_name", type="string"),
 *         @OA\Property(property="numTel", type="string"),
 *         @OA\Property(property="image", type="string", format="binary")
 *     }
 * )
 *
 * @OA\Schema(
 *     schema="UpdateContact",
 *     type="object",
 *     properties={
 *         @OA\Property(property="name", type="string"),
 *         @OA\Property(property="first_name", type="string"),
 *         @OA\Property(property="numTel", type="string"),
 *         @OA\Property(property="image", type="string", format="binary")
 *     }
 * )
 */


class ContactController extends Controller //Controlleur pour gerer les crud sur contact
{

    /**
     * @OA\Get(
     *      path="/contacts",
     *      operationId="getContactsList",
     *      tags={"Contacts"},
     *      summary="Get list of contacts",
     *      description="Returns list of contacts",
     *      @OA\Response(
     *          response=200,
     *          description="Successful operation",
     *          @OA\JsonContent(type="array", @OA\Items(ref="#/components/schemas/Contact"))
     *       ),
     *      @OA\Response(
     *          response=500,
     *          description="Server error"
     *      )
     * )
     */
    public function get()
    {
        try {
            $data = Contact::all();
            return response()->json($data, 200);
        } catch (\Throwable $t) {
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }


    /**
     * @OA\Post(
     *      path="/contacts",
     *      operationId="createContact",
     *      tags={"Contacts"},
     *      summary="Create a new contact",
     *      description="Creates a new contact",
     *      @OA\RequestBody(
     *          required=true,
     *          @OA\JsonContent(ref="#/components/schemas/NewContactRequest")
     *      ),
     *      @OA\Response(
     *          response=201,
     *          description="Contact created successfully",
     *          @OA\JsonContent(ref="#/components/schemas/Contact")
     *       ),
     *      @OA\Response(
     *          response=500,
     *          description="Server error"
     *      )
     * )
     */
    public function create(NewContactRequest $request)
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


    /**
     * @OA\Get(
     *      path="/contacts/{id}",
     *      operationId="getContactById",
     *      tags={"Contacts"},
     *      summary="Get contact by ID",
     *      description="Returns a single contact",
     *      @OA\Parameter(
     *          name="id",
     *          description="Contact ID",
     *          required=true,
     *          in="path",
     *          @OA\Schema(type="integer")
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="Successful operation",
     *          @OA\JsonContent(ref="#/components/schemas/Contact")
     *       ),
     *      @OA\Response(
     *          response=404,
     *          description="Contact not found"
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Server error"
     *      )
     * )
     */
    public function getById($id)
    {
        try {
            $contact = Contact::findOrFail($id);
            return response()->json($contact, 200);
        } catch (\Throwable $t) {
            return response()->json(['error' => $t->getMessage()], 500);
        }
    }



    /**
     * @OA\Put(
     *      path="/contacts/{id}",
     *      operationId="updateContact",
     *      tags={"Contacts"},
     *      summary="Update a contact",
     *      description="Updates a contact",
     *      @OA\Parameter(
     *          name="id",
     *          description="Contact ID",
     *          required=true,
     *          in="path",
     *          @OA\Schema(type="integer")
     *      ),
     *      @OA\RequestBody(
     *          required=true,
     *          @OA\JsonContent(ref="#/components/schemas/UpdateContactRequest")
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="Contact updated successfully",
     *          @OA\JsonContent(ref="#/components/schemas/Contact")
     *       ),
     *      @OA\Response(
     *          response=404,
     *          description="Contact not found"
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Server error"
     *      )
     * )
     */
    public function update(UpdateContactRequest $request, $id)
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




    /**
     * @OA\Delete(
     *      path="/contacts/{id}",
     *      operationId="deleteContact",
     *      tags={"Contacts"},
     *      summary="Delete a contact",
     *      description="Deletes a contact",
     *      @OA\Parameter(
     *          name="id",
     *          description="Contact ID",
     *          required=true,
     *          in="path",
     *          @OA\Schema(type="integer")
     *      ),
     *      @OA\Response(
     *          response=200,
     *          description="Contact deleted successfully",
     *       ),
     *      @OA\Response(
     *          response=404,
     *          description="Contact not found"
     *      ),
     *      @OA\Response(
     *          response=500,
     *          description="Server error"
     *      )
     * )
     */
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
