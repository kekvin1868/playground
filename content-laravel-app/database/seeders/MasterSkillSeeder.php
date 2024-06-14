<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class MasterSkillSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('ms_skills')->insert([
            [
                'skill_name' => 'PHP',
                'skill_description' => 'Server-side scripting language',
                'skill_category' => 'Backend'
            ],
            [
                'skill_name' => 'JavaScript',
                'skill_description' => 'Client-side scripting language',
                'skill_category' => 'Frontend'
            ],
            [
                'skill_name' => 'Laravel',
                'skill_description' => 'PHP framework',
                'skill_category' => 'Backend'
            ],
            [
                'skill_name' => 'Vue.js',
                'skill_description' => 'JavaScript framework',
                'skill_category' => 'Frontend'
            ]
        ]);
    }
}
