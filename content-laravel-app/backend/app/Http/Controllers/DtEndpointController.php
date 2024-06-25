<?php

namespace App\Http\Controllers;

use App\Http\Controllers\DtEndpointController;
use App\Models\DataEndpoint;
use App\Models\DataApp;
use Illuminate\Http\Request;

class DtEndpointController extends Controller
{
    public function index()
    {
        $eps = DataEndpoint::with('foreignAppId')->get();
        return response()->json($eps);
    }

    public function store(Request $request)
    {
        $request->validate([
            'endpoint_name' => 'required|string|max:255',
            'app_id' => 'required|exists:dt_applications,id_app',
            'endpoint_status' => 'required|in:0,1',
        ]);

        $newEndpoint = DataEndpoint::create($request->all());

        return response()->json(['success' => 'Endpoint created successfully.', 'endpoint' => $newEndpoint]);
    }

    public function show(DataEndpoint $allDtEndpoint)
    {
        return response()->json($allDtEndpoint->load('foreignAppId'));
    }

    public function update(Request $request, DataEndpoint $upEndpoint)
    {
        $request->validate([
            'endpoint_name' => 'required|string|max:255',
            'app_id' => 'required|exists:dt_applications,id_app',
            'endpoint_status' => 'required|in:0,1',
        ]);

        $upEndpoint->update($request->all());

        return response()->json(['success' => 'Endpoint updated successfully.', 'endpoint' => $upEndpoint]);
    }

    public function destroy(DataEndpoint $dropEndpoint)
    {
        $dropEndpoint->delete();

        return response()->json(['success' => 'Endpoint deleted successfully.']);
    }
}
