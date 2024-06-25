<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DataApp extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_app';
    public $timestamps = false;

    protected $table = 'dt_applications';

    protected $fillable = [
        'app_key',
        'app_status',
    ];

    protected $dates = [
        'app_created_timestamp',
        'app_updated_timestamp',
    ];

    const CREATED_AT = 'app_created_timestamp';
    const UPDATED_AT = 'app_updated_timestamp';
}
