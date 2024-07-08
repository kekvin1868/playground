<?php

namespace App\Http\Controllers;

use App\Http\Controllers\testController;
use Illuminate\Http\Request;

class testController extends Controller
{
    public function print() {
        return response($content = 'hello world');
    }
}
