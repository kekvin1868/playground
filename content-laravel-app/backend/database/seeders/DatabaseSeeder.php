<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Call your custom seeders
        $this->call([
            MasterSkillSeeder::class,
            MasterJobRoleSeeder::class,
            RelationRoleSkillSeeder::class,
        ]);
    }
}
