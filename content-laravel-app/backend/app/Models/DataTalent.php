<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\DataUser;

class DataTalent extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_talent';
    public $timestamps = false;

    protected $table = 'dt_talents';

    protected $fillable = [
        'talent_status',
        'user_id',
        'talent_score',
    ];

    protected $dates = [
        'talent_created_timestamp',
        'talent_updated_timestamp',
    ];

    const CREATED_AT = 'talent_created_timestamp';
    const UPDATED_AT = 'talent_updated_timestamp';

    public function foreignUserId()
    {
        return $this->belongsTo(DataUser::class, 'user_id', 'id_user');
    }
}
