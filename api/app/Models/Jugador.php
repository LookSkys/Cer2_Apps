<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Jugador extends Model
{
    use HasFactory;
    protected $table = "jugadores";
    protected $primary = 'rut';
    protected $keyType = 'string';
    public $incrementing = false;
    public $timestamps = false;

    public function equipo(): BelongsTo
    {
        return $this->belongsTo(Equipo::class);
    }
}
