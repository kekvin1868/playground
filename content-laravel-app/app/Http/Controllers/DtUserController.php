<?php

namespace App\Http\Controllers;

use App\Models\DataUser;
use Illuminate\Http\Request;

class DtUserController extends Controller
{
    public function index()
    {
        $users = DataUser::all();
        return response()->json($users);
    }

    public function register(Request $request)
    {
        $request->validate([
            'user_status' => 'required|in:0,1',
            'user_mail' => 'required|email|unique:users,user_mail',
            'user_pass' => 'required|string|min:8',
            'user_fullname' => 'required|string|max:255',
            'user_agree_to_ToS' => 'required|in:0,1',
            'user_agree_to_PP' => 'required|in:0,1',
        ]);

        $newUser = DataUser::create($request->all());

        return response()->json(['success' => 'User created successfully.', 'user' => $newUser]);
    }

    public function show(DataUser $allDtUser)
    {
        return response()->json($allDtUser);
    }

    public function update(Request $request, DataUser $upUser)
    {
        $request->validate([
            'user_status' => 'required|in:0,1',
            'user_mail' => 'required|email|unique:users,user_mail,' . $upUser->id_user,
            'user_pass' => 'required|string|min:8',
            'user_fullname' => 'required|string|max:255',
            'user_agree_to_ToS' => 'required|in:0,1',
            'user_agree_to_PP' => 'required|in:0,1',
        ]);

        $upUser->update($request->all());

        return response()->json(['success' => 'User updated successfully.', 'user' => $upUser]);
    }

    public function destroy(User $dropUser)
    {
        $dropUser->delete();

        return response()->json(['success' => 'User deleted successfully.']);
    }
}
