<?php

namespace App\Http\Controllers;

use App\Http\Controllers\MsSkillController;
use App\Models\MasterSkill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MsSkillController extends Controller
{
    public function index()
    {
        $skills = MasterSkill::all();
        return response()->json($skills);
    }

    public function store(Request $request)
    {
        $request->merge([
            'skill_status' => 1,
        ]);

        $validateReq = $request->validate([
            'skill_status' => 'required|in:0,1',
            'skill_name' => 'required|string|max:255|unique:ms_skills,skill_name',
            'skill_description' => 'nullable|string',
            'skill_category' => 'required|in:Softskill,Hardskill',
            'skill_score' => 'required|regex:/^\d{1,2}(\.\d{1,2})?$/',
        ]);

        /*
            TODO:
            - skill_name harus unique
            - validation untuk duplicate names
            - skill_category: Softskill, Hardskill
        */

        // $mergedData = array_merge($validateReq, $default);
        $newSkill = MasterSkill::create($request->all());

        return response()->json(['success' => 'Skill created successfully.', 'skill' => $newSkill]);
    }

    public function view(MasterSkill $allMsSkill) //show
    {
        return response()->json($allMsSkill);
    }

    public function update(Request $request, MasterSkill $upSkill){
        $request->validate([
            'skill_status' => 'required|in:0,1',
            'skill_name' => 'required|string|max:255|unique:ms_skills,skill_name',
            'skill_description' => 'nullable|string',
            'skill_category' => 'required|in:Softskill,Hardskill',
            'skill_score' => 'required|regex:/^\d{1,2}(\.\d{1,2})?$/',
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
