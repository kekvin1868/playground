<?php

namespace App\Http\Controllers;

use App\Models\MasterRole;
use Illuminate\Http\Request;

class MsRoleController extends Controller
{
    public function index()
    {
        $roles = MasterRole::all();
        return response()->json($roles);
    }

    public function store(Request $request)
    {
        $request->validate([
            'role_name' => 'required|string|max:255',
            'role_description' => 'nullable|string',
            'role_status' => 'required|in:0,1',
        ]);

        $newRole = MasterRole::create($request->all());

        return response()->json(['success' => 'Role created successfully.', 'role' => $newRole]);
    }

    public function view(MasterRole $allMsRole) //show
    {
        return response()->json($allMsRole);
    }

    public function update(Request $request, MasterRole $upRole)
    {
        $request->validate([
            'role_name' => 'required|string|max:255',
            'role_description' => 'nullable|string',
            'role_status' => 'required|in:0,1',
        ]);

        $upRole->update($request->all());

        return response()->json(['success' => 'Role updated successfully.', 'role' => $upRole]);
    }

    public function destroy(MasterRole $dropRole)
    {
        $dropRole->delete();

        return response()->json(['success' => 'Role deleted successfully.']);
    }
}
