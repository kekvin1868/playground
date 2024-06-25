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
                'skill_category' => 'Hardskill',
                'skill_score' => 91.22
            ],
            [
                'skill_name' => 'JavaScript',
                'skill_description' => 'Frontend programming language',
                'skill_category' => 'Hardskill',
                'skill_score' => 82.93
            ],
            [
                'skill_name' => 'Laravel',
                'skill_description' => 'PHP framework for project development',
                'skill_category' => 'Hardskill',
                'skill_score' => 78.32
            ],
            [
                'skill_name' => 'Vue',
                'skill_description' => 'JavaScript frontend framework',
                'skill_category' => 'Hardskill',
                'skill_score' => 95.81
            ],
            [
                'skill_name' => 'Accounting',
                'skill_description' => 'Managerial financial position in the company',
                'skill_category' => 'Softskill',
                'skill_score' => 84.45
            ],
            [
                'skill_name' => 'Public Relations',
                'skill_description' => 'PIC for business proposals',
                'skill_category' => 'Softskill',
                'skill_score' => 75.49
            ],
            [
                'skill_name' => 'English',
                'skill_description' => 'Real life language',
                'skill_category' => 'Softskill',
                'skill_score' => 75.49
            ]
        ]);
    }
}
