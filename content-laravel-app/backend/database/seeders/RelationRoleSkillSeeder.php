<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class RelationRoleSkillSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('rl_skills_roles')->insert([
            ['skill_id' => 1, 'role_id' => 1], // PHP for Backend Developer
            ['skill_id' => 2, 'role_id' => 2], // JavaScript for Frontend Developer
            ['skill_id' => 3, 'role_id' => 1], // Laravel for Backend Developer
            ['skill_id' => 4, 'role_id' => 2], // Vue.js for Frontend Developer
            ['skill_id' => 1, 'role_id' => 3], // PHP for Full Stack Developer
            ['skill_id' => 2, 'role_id' => 3], // JavaScript for Full Stack Developer
            ['skill_id' => 3, 'role_id' => 3], // Laravel for Full Stack Developer
            ['skill_id' => 4, 'role_id' => 3] // Vue.js for Full Stack Developer
        ]);
    }
}
