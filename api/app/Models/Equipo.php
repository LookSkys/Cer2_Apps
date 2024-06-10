<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Equipo extends Model
{
    use HasFactory;
    protected $table = "equipos";

    protected $fillable = ['nombre', 'entrenador', 'juegos_en_donde_participa'];

    protected $casts = [
        'juegos_en_donde_participa' => 'array', // Esto convierte el JSON en un array automáticamente
    ];
    public $timestamps = false;

    public function jugadores(): HasMany
    {
        return $this->hasMany(Jugador::class);
    }
    public function partidos(): BelongsToMany
    {
        return $this->BelongsToMany(Partido::class);
    }

    public function campeonatos(): BelongsToMany
    {
        return $this->BelongsToMany(Campeonato::class);
    }
}
