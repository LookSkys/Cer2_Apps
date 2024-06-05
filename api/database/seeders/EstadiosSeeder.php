<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EstadiosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table("estadios")->insert([
            ['nombre' => 'Santiago Bernabéu', 'ubicacion' => 'Madrid, España'],
            ['nombre' => 'Camp Nou', 'ubicacion' => 'Barcelona, España'],
            ['nombre' => 'Old Trafford', 'ubicacion' => 'Manchester, Inglaterra'],
            ['nombre' => 'Etihad Stadium', 'ubicacion' => 'Manchester, Inglaterra'],
            ['nombre' => 'Anfield', 'ubicacion' => 'Liverpool, Inglaterra'],
            ['nombre' => 'Parc des Princes', 'ubicacion' => 'París, Francia'],
            ['nombre' => 'Allianz Arena', 'ubicacion' => 'Múnich, Alemania'],
            ['nombre' => 'Juventus Stadium', 'ubicacion' => 'Turín, Italia'],
            ['nombre' => 'Stamford Bridge', 'ubicacion' => 'Londres, Inglaterra'],
            ['nombre' => 'Wanda Metropolitano', 'ubicacion' => 'Madrid, España'],
            ['nombre' => 'San Siro', 'ubicacion' => 'Milán, Italia'],
            ['nombre' => 'Giuseppe Meazza', 'ubicacion' => 'Milán, Italia'],
            ['nombre' => 'Tottenham Hotspur Stadium', 'ubicacion' => 'Londres, Inglaterra'],
            ['nombre' => 'Emirates Stadium', 'ubicacion' => 'Londres, Inglaterra'],
            ['nombre' => 'Estadio Monumental', 'ubicacion' => 'Santiago, Chile']
        ]);
    }
}
