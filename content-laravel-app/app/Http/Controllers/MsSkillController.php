<?php

namespace App\Http\Controllers;

use App\Models\MasterSkill;
use Illuminate\Http\Request;

class MsSkillController extends Controller
{
    public function index()
    {
        $skills = MasterSkill::all();
        return response()->json($skills);
    }

    public function store(Request $request)
    {
        $request->validate([
            'skill_name' => 'required|string|max:255',
            'skill_description' => 'nullable|string',
            'skill_category' => 'nullable|string|max:255',
            'skill_status' => 'required|in:0,1',
        ]);

        $newSkill = MasterSkill::create($request->all());

        return response()->json(['success' => 'Skill created successfully.', 'skill' => $newSkill]);
    }

    public function view(MasterSkill $allMsSkill) //show
    {
        return response()->json($allMsSkill);
    }

    public function update(Request $request, MasterSkill $upSkill){
        $request->validate([
            'skill_name' => 'required|string|max:255',
            'skill_description' => 'nullable|string',
            'skill_category' => 'nullable|string|max:255',
            'skill_status' => 'required|in:0,1',
        ]);

        $upSkill->update($request->all());

        return response()->json(['success' => 'Skill updated successfully.', 'skill' => $upSkill]);
    }

    public function destroy(MasterSkill $dropSkill)
    {
        $dropSkill->delete();

        return response()->json(['success' => 'Skill deleted successfully.']);
    }

    // public function create()
    // {
    //     // Typically not used when using a front-end framework
    //     return response()->json(['status' => 'create method not used']);
    // }

    // public function edit()
    // {
    //     return response()->json(['status' => 'edit method not used']);
    // }
}
