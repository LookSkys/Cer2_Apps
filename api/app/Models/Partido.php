<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Partido extends Model
{
    use HasFactory;
    protected $table = "partidos";
    public $timestamps = false;

    public function equipos(): BelongsToMany
    {
        return $this->BelongsToMany(Equipo::class)->withPivot(['es_ganador']);
    }
}
