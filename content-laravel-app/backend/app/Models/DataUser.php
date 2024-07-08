<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;

class DataUser extends Model
{
    use HasFactory;

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model){
            if (empty($model->unique_id)) {
                $model->unique_id = (string) Str::uuid();
            }
        });
    }

    // Define table name
    protected $table = 'dt_users';

    // Define primary key
    protected $primaryKey = 'id_user';

    // Disable timestamps
    public $timestamps = false;

    // Fillable fields
    protected $fillable = [
        'user_status',
        'user_mail',
        'user_pass',
        'user_fullname',
        'user_agree_to_ToS',
        'user_agree_to_PP',
    ];

    // Date fields
    protected $dates = [
        'user_created_timestamp',
        'user_updated_timestamp',
    ];

    // Custom timestamps
    const CREATED_AT = 'user_created_timestamp';
    const UPDATED_AT = 'user_updated_timestamp';
}
