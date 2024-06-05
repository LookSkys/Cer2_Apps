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
            ['nombre' => 'Champions League', 'fecha_inicio' => '2024-06-01', 'fecha_fin' => '2024-08-01', 'reglas' => 'Reglas de la UEFA', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Copa Libertadores', 'fecha_inicio' => '2024-07-01', 'fecha_fin' => '2024-09-01', 'reglas' => 'Reglas de la CONMEBOL', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Premier League', 'fecha_inicio' => '2024-08-01', 'fecha_fin' => '2025-05-01', 'reglas' => 'Reglas de la Premier League', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'La Liga', 'fecha_inicio' => '2024-08-15', 'fecha_fin' => '2025-05-20', 'reglas' => 'Reglas de la Liga', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Serie A', 'fecha_inicio' => '2024-09-01', 'fecha_fin' => '2025-05-30', 'reglas' => 'Reglas de la Serie A', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Bundesliga', 'fecha_inicio' => '2024-08-10', 'fecha_fin' => '2025-05-15', 'reglas' => 'Reglas de la Bundesliga', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Ligue 1', 'fecha_inicio' => '2024-08-20', 'fecha_fin' => '2025-05-25', 'reglas' => 'Reglas de la Ligue 1', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'FA Cup', 'fecha_inicio' => '2024-11-01', 'fecha_fin' => '2025-04-01', 'reglas' => 'Reglas de la FA', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Copa del Rey', 'fecha_inicio' => '2024-10-01', 'fecha_fin' => '2025-04-15', 'reglas' => 'Reglas de la RFEF', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Copa Italia', 'fecha_inicio' => '2024-11-10', 'fecha_fin' => '2025-05-05', 'reglas' => 'Reglas de la FIGC', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'DFB-Pokal', 'fecha_inicio' => '2024-08-05', 'fecha_fin' => '2025-05-21', 'reglas' => 'Reglas de la DFB', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Copa de la Liga Francesa', 'fecha_inicio' => '2024-09-05', 'fecha_fin' => '2025-04-10', 'reglas' => 'Reglas de la LFP', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Superliga Argentina', 'fecha_inicio' => '2024-07-15', 'fecha_fin' => '2025-03-20', 'reglas' => 'Reglas de la AFA', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'Brasileirão', 'fecha_inicio' => '2024-05-10', 'fecha_fin' => '2024-12-10', 'reglas' => 'Reglas de la CBF', 'premios' => 'Trofeo, medallas, y premio en efectivo'],
            ['nombre' => 'MLS', 'fecha_inicio' => '2024-03-01', 'fecha_fin' => '2024-11-01', 'reglas' => 'Reglas de la MLS', 'premios' => 'Trofeo, medallas, y premio en efectivo']
        ]);
    }
}
