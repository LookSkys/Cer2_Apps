<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Partido extends Model
{
    use HasFactory;
    protected $table = 'partidos';
    public $timestamps = false;

    public function estadios(): BelongsTo
    {
        return $this->belongsTo(Estadio::class);
    }

    public function equipos(): BelongsToMany
    {
        return $this->belongsToMany(Equipo::class)->withPivot(['goles', 'es_local']);
    }
}
