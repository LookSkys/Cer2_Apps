<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EquiposSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table("equipos")->insert([
            ['nombre' => 'Real Madrid', 'entrenador' => 'Carlo Ancelotti'],
            ['nombre' => 'Barcelona', 'entrenador' => 'Xavi Hernández'],
            ['nombre' => 'Manchester United', 'entrenador' => 'Erik ten Hag'],
            ['nombre' => 'Manchester City', 'entrenador' => 'Pep Guardiola'],
            ['nombre' => 'Liverpool', 'entrenador' => 'Jürgen Klopp'],
            ['nombre' => 'Paris Saint-Germain', 'entrenador' => 'Luis Enrique'],
            ['nombre' => 'Bayern Munich', 'entrenador' => 'Thomas Tuchel'],
            ['nombre' => 'Juventus', 'entrenador' => 'Massimiliano Allegri'],
            ['nombre' => 'Chelsea', 'entrenador' => 'Mauricio Pochettino'],
            ['nombre' => 'Atlético Madrid', 'entrenador' => 'Diego Simeone'],
            ['nombre' => 'AC Milan', 'entrenador' => 'Stefano Pioli'],
            ['nombre' => 'Inter de Milán', 'entrenador' => 'Simone Inzaghi'],
            ['nombre' => 'Tottenham Hotspur', 'entrenador' => 'Ange Postecoglou'],
            ['nombre' => 'Arsenal', 'entrenador' => 'Mikel Arteta'],
            ['nombre' => 'Colo-Colo', 'entrenador' => 'Jorge Almirón']
        ]);
    }
}
