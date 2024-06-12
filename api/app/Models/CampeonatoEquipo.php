<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CampeonatoEquipo extends Model
{
    use HasFactory;
    protected $table = "campeonato_equipo";
    public $timestamps = false;
}
