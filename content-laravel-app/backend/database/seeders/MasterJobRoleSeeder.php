<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class MasterJobRoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('ms_job_roles')->insert([
            [
                'role_name' => 'Backend Developer',
                'role_description' => 'Handles server-side logic'
            ],
            [
                'role_name' => 'Frontend Developer',
                'role_description' => 'Works on client-side'
            ],
            [
                'role_name' => 'Full Stack Developer',
                'role_description' => 'Handles both client and server-side'
            ]
        ]);
    }
}
