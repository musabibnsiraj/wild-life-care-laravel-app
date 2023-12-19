<?php

namespace Database\Seeders;

use App\Models\Customer;
use App\Models\Institution;
use App\Models\Officer;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Reset cached roles and permissions
        app()[PermissionRegistrar::class]->forgetCachedPermissions();

        $superadminRole = Role::findByName('Super-Admin');
        $adminRole = Role::findByName('Admin');
        $officerRole = Role::findByName('Officer');
        $userRole = Role::findByName('User');

        // ----------------Super Admin ----------------

        $superAdmin = \App\Models\User::factory()->create([
            'name' => 'Super-Admin User',
            'email' => 'superadmin@example.com',
            'password' => Hash::make('superadmin835'),
        ]);
        $superAdmin->assignRole($superadminRole);

        // -------------Wildlife---------

        $admin1 = \App\Models\User::factory()->create([
            'name' => 'Wildlife Admin',
            'email' => 'wildlife@example.com',
            'password' => Hash::make('wildlife835'),
        ]);
        $admin1->assignRole($adminRole);
        Institution::create([
            'user_id' => $admin1->id,
            'type' => 'wildlife'
        ]);

        $officer1 = \App\Models\User::factory()->create([
            'name' => 'Mr.Been Officer ',
            'email' => 'officer@example.com',
            'password' => Hash::make('office835'),
        ]);
        $officer1->assignRole($officerRole);
        Officer::create([
            'user_id' => $officer1->id,
            'admin_id' => $admin1->id
        ]);

        // ----------------Forestry--------------

        $admin2 = \App\Models\User::factory()->create([
            'name' => 'Forestry Admin',
            'email' => 'forestry@example.com',
            'password' => Hash::make('forestry835'),
        ]);
        $admin2->assignRole($adminRole);
        Institution::create([
            'user_id' => $admin2->id,
            'type' => 'forestry'
        ]);

        $officer2 = \App\Models\User::factory()->create([
            'name' => 'Bruce Lee Officer ',
            'email' => 'officer2@example.com',
            'password' => Hash::make('office2835'),
        ]);
        $officer2->assignRole($officerRole);
        Officer::create([
            'user_id' => $officer2->id,
            'admin_id' => $admin2->id
        ]);


        // ------------Environmental--crime----------

        $admin3 = \App\Models\User::factory()->create([
            'name' => 'Environmental crime Admin',
            'email' => 'environmental@example.com',
            'password' => Hash::make('environmental835'),
        ]);
        $admin3->assignRole($adminRole);
        Institution::create([
            'user_id' => $admin3->id,
            'type' => 'environmental_crime'
        ]);

        $officer3 = \App\Models\User::factory()->create([
            'name' => 'Bruce Officer ',
            'email' => 'officer3@example.com',
            'password' => Hash::make('office3835'),
        ]);
        $officer3->assignRole($officerRole);
        Officer::create([
            'user_id' => $officer3->id,
            'admin_id' => $admin3->id
        ]);

        // --------------Public----User--------------

        $user = \App\Models\User::factory()->create([
            'name' => 'Public User',
            'email' => 'user@example.com',
            'password' => Hash::make('user835'),
        ]);
        $user->assignRole($userRole);

        Customer::create([
            'user_id' => $user->id,
        ]);
    }
}
