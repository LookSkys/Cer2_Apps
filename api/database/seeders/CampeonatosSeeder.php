<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CampeonatosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table("campeonato")->insert([
            ['nombre' => 'FIFA World Cup', 'fecha_inicio' => '2024-06-10', 'fecha_fin' => '2024-07-10', 'reglas' => 'Reglas de la FIFA', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Madden NFL Championship', 'fecha_inicio' => '2024-07-01', 'fecha_fin' => '2024-08-01', 'reglas' => 'Reglas de la NFL', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'NBA Live Tournament', 'fecha_inicio' => '2024-08-15', 'fecha_fin' => '2024-09-15', 'reglas' => 'Reglas de la NBA', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'NHL eSports Cup', 'fecha_inicio' => '2024-09-01', 'fecha_fin' => '2024-10-01', 'reglas' => 'Reglas de la NHL', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'UFC eSports Championship', 'fecha_inicio' => '2024-10-05', 'fecha_fin' => '2024-11-05', 'reglas' => 'Reglas de la UFC', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'League of Legends World Championship', 'fecha_inicio' => '2024-11-10', 'fecha_fin' => '2024-12-10', 'reglas' => 'Reglas de Riot Games', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Overwatch League Grand Finals', 'fecha_inicio' => '2024-12-15', 'fecha_fin' => '2025-01-15', 'reglas' => 'Reglas de Blizzard Entertainment', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Dota 2 The International', 'fecha_inicio' => '2025-01-20', 'fecha_fin' => '2025-02-20', 'reglas' => 'Reglas de Valve Corporation', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Call of Duty Championship', 'fecha_inicio' => '2025-03-01', 'fecha_fin' => '2025-04-01', 'reglas' => 'Reglas de Activision', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Rocket League Championship Series', 'fecha_inicio' => '2025-04-05', 'fecha_fin' => '2025-05-05', 'reglas' => 'Reglas de Psyonix', 'premios' => 'Trofeo, medallas, y premio en efectivo']
        ]);
    }
}
