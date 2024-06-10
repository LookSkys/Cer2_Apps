<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Campeonato extends Model
{
    use HasFactory;
    protected $table = "campeonato";
    public $timestamps = false;

    public function equipos(): BelongsToMany
    {
        return $this->belongsToMany(Equipo::class);
    }
}
