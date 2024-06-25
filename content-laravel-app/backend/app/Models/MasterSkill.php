<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MasterSkill extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_skill';
    public $timestamps = false;

    protected $table = 'ms_skills';

    protected $fillable = [
        'skill_name',
        'skill_description',
        'skill_category',
        'skill_score',
        'skill_status',
    ];

    protected $dates = [
        'skill_created_timestamp',
        'skill_updated_timestamp',
    ];

    const CREATED_AT = 'skill_created_timestamp';
    const UPDATED_AT = 'skill_updated_timestamp';
}
