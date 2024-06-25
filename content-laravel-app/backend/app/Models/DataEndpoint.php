<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DataApp;

class DataEndpoint extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_endpoint';
    public $timestamps = false;

    protected $table = 'dt_endpoints';

    protected $fillable = [
        'endpoint_name',
        'app_id',
        'endpoint_status',
    ];

    protected $dates = [
        'endpoint_created_timestamp',
        'endpoint_updated_timestamp',
    ];

    const CREATED_AT = 'endpoint_created_timestamp';
    const UPDATED_AT = 'endpoint_updated_timestamp';

    public function foreignAppId()
    {
        return $this->belongsTo(DataApp::class, 'app_id', 'id_app');
    }
}
