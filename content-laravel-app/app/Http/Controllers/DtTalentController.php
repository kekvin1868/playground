<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DataTalent;

class DtTalentController extends Controller
{
    public function index()
    {
        // Eager load the related user data
        $talents = DataTalent::with('foreignUserId')->get();
        return response()->json($talents);
    }

    public function store(Request $request)
    {
        $request->validate([
            'talent_status' => 'required|in:0,1',
            'user_id' => 'required|exists:dt_users,id_user',
            'talent_score' => 'required|numeric',
        ]);

        $newTalent = DataTalent::create($request->all());

        return response()->json(['success' => 'Talent created successfully.', 'talent' => $newTalent]);
    }

    public function show(DataTalent $allDtTalent)
    {
        return response()->json($allDtTalent->load('user'));
    }

    public function update(Request $request, DataTalent $upTalent)
    {
        $request->validate([
            'talent_status' => 'required|in:0,1',
            'user_id' => 'required|exists:dt_users,id_user',
            'talent_score' => 'required|numeric',
        ]);

        $upTalent->update($request->all());

        return response()->json(['success' => 'Talent updated successfully.', 'talent' => $upTalent]);
    }

    public function destroy(DataTalent $dropTalent)
    {
        $dropTalent->delete();

        return response()->json(['success' => 'Talent deleted successfully.']);
    }
}
