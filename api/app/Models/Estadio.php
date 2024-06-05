<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Estadio extends Model
{
    use HasFactory;
    protected $table = 'estadios';
    public $timestamps = false;

    public function partidos(): HasMany
    {
        return $this->HasMany(Partido::class);
    }
}
