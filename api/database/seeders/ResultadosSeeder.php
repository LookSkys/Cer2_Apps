<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ResultadosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('resultados')->insert([
            [
                'puntuacion_ganador' => 3,
                'puntuacion_perdedor' => 1,
                'partido_id' => 1,
                'equipo_ganador_id' => 1,
                'equipo_perdedor_id' => 2
            ],
            [
                'puntuacion_ganador' => 2,
                'puntuacion_perdedor' => 0,
                'partido_id' => 2,
                'equipo_ganador_id' => 1,
                'equipo_perdedor_id' => 3
            ],
            [
                'puntuacion_ganador' => 1,
                'puntuacion_perdedor' => 0,
                'partido_id' => 3,
                'equipo_ganador_id' => 4,
                'equipo_perdedor_id' => 5
            ],
            [
                'puntuacion_ganador' => 4,
                'puntuacion_perdedor' => 3,
                'partido_id' => 4,
                'equipo_ganador_id' => 6,
                'equipo_perdedor_id' => 7
            ],
            [
                'puntuacion_ganador' => 2,
                'puntuacion_perdedor' => 1,
                'partido_id' => 5,
                'equipo_ganador_id' => 8,
                'equipo_perdedor_id' => 9
            ],
            [
                'puntuacion_ganador' => 3,
                'puntuacion_perdedor' => 2,
                'partido_id' => 6,
                'equipo_ganador_id' => 10,
                'equipo_perdedor_id' => 1
            ],
        ]);
    }
}
