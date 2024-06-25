<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MasterRole extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_role';
    public $timestamps = false;

    protected $table = 'ms_job_roles';

    protected $fillable = [
        'role_name',
        'role_description',
        'role_status',
    ];

    protected $dates = [
        'role_created_timestamp',
        'role_updated_timestamp',
    ];

    const CREATED_AT = 'role_created_timestamp';
    const UPDATED_AT = 'role_updated_timestamp';
}
