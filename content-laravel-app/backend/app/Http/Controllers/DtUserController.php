<?php

namespace App\Http\Controllers;

use App\Http\Controllers\DtUserController;
use App\Models\DataUser;
use App\Mail\ActivationEmail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\DB;

class DtUserController extends Controller
{
    public function index(Request $request)
    {
        if ($request->has('getId')) {
            $uid = $request->header('uuid');
            $users = DataUser::where('unique_id', $uid)->firstOrFail();

            return response()->json([
                'id' => $users->id_user,
            ]);
        } else if($request->has('getAgreements')) {
            $stringId = $request->header('id');
            $id = intval($stringId);

            $users = DataUser::where('id_user', $id)->firstOrFail();

            return response()->json([
                'tos' => $users->user_agree_to_ToS,
                'pp' => $users->user_agree_to_PP,
            ]);
        } else {
            $users = DataUser::all();
            return response()->json($users);
        }
    }

    public function store(Request $request)
    {
        try {
            $request->validate([
                'user_mail' => 'required|email|unique:dt_users,user_mail',
                'user_pass' => 'required|string|min:8',
                'user_fullname' => 'required|string|max:255',
                'user_agree_to_ToS' => 'required|in:0,1',
                'user_agree_to_PP' => 'required|in:0,1',
            ], [
                'user_pass.min' => 'The password must be at least 8 characters long.',
            ]);

            $request->merge([
                'user_pass' => Hash::make($request->user_pass),
            ]);

            $request->merge([
                'user_status' => '0',
                'user_agree_to_ToS' => '0',
                'user_agree_to_PP' => '0',
            ]);
        } catch (ValidationException $e) {
            return response()->json(['error' => $e->errors()], 422);
        } finally {
            $newUser = DataUser::create($request->all());

            return response()->json(['success' => 'User created successfully.', 'user' => $newUser], 201);
        }
    }

    public function show(DataUser $thisUser)
    {
        return response()->json($thisUser);
    }

    public function update(Request $request, $info)
    {
        if ($request->input('type') === 'agreement') {
            $user = DataUser::where('id_user', $info)->firstOrFail();

            $user->user_agree_to_ToS = '1';
            $user->user_agree_to_PP = '1';
            $user->save();

            return response()->json(['success' => 'User terms updated successfully.', 'user' => $user]);
        }

        if ($request->input('type') === 'activation') {
            $user = DataUser::where('id_user', $info)->firstOrFail();

            $user->user_status = '1';
            $user->save();

            return response()->json(['success' => 'User updated successfully.', 'user' => $user]);
        }

        if ($request->input('type') === 'personal') {
            $user = DataUser::where('id_user', $info)->firstOrFail();

            $user->
            $user->save();

            return response()->json(['success' => 'User personal data saved.', 'user' => $user]);
        }

        return response()->json(['error' => 'Invalid request type.'], 400);
    }

    public function destroy(DataUser $dropUser)
    {
        $dropUser->delete();

        return response()->json(['success' => 'User deleted successfully.']);
    }

    public function checkEmailUser(Request $request) {
        $email = $request->header('email');

        $user = DataUser::where('user_mail', $email)->first();

        if ($user) {
            return response()->json([
                'exists' => true,
                'unique_id' => $user->unique_id,
                'status' => $user->user_status,
                'id' => $user->id_user,
            ]);
        } else {
            return response()->json([
                'exists' => false,
                'unique_id' => null,
                'status' => $user->user_status,
                'id' => $user->id_user,
            ]);
        }
    }

    public function sendEmail(Request $request) {
        $uuid = $request->header('uuid');
        $email = $request->header('email');

        try {
            Mail::to($email)->send(new ActivationEmail($uuid));

            return response()->json(['message' => 'Email sent successfully']);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Failed to send activation email: ' . $e->getMessage()], 500);
        }
    }

    public function activation(Request $request) {
        $uuid = $request->header('uuid');

        $user = DataUser::where('unique_id', $uuid)->first();

        if ($user) {
            return response()->json([
                'activated' => true,
            ]);
        } else {
            return response()->json([
                'activated' => false,
            ]);
        }
    }
}
