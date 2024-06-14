<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $this->call([
            EquiposSeeder::class,
            JugadoresSeeder::class,
            CampeonatosSeeder::class,
            PartidosSeeder::class,
            ResultadosSeeder::class,
            CampeonatoEquipo::class,
            EquipoPartido::class,
        ]);
    }
}
