<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DataUser extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_user';
    public $timestamps = false;

    protected $table = 'dt_users';

    protected $fillable = [
        'user_status',
        'user_mail',
        'user_pass',
        'user_fullname',
        'user_agree_to_ToS',
        'user_agree_to_PP',
    ];

    protected $dates = [
        'user_created_timestamp',
        'user_updated_timestamp',
    ];

    const CREATED_AT = 'user_created_timestamp';
    const UPDATED_AT = 'user_updated_timestamp';
}
