<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EquipoPartido extends Model
{
    use HasFactory;
    protected $table = "equipo_partido";
    public $timestamps = false;
}
