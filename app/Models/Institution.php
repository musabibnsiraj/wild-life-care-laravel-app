<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Institution extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'name', 'address', 'address_2', 'phone', 'branch', 'type'];

    // Institution can have multiple officers
    public function officers()
    {
        return $this->hasMany(Officer::class);
    }
}
