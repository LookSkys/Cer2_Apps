<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class EquipoPartido extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Variables
        $totalEquipos = 10;
        $totalPartidos = 20;

        // Obtener ids de todos los equipos y partidos
        $equiposIds = range(1, $totalEquipos);
        $partidosIds = range(1, $totalPartidos);

        // Preparar datos a insertar
        $data = [];

        // Asignar equipos a partidos de forma aleatoria
        foreach ($partidosIds as $partidoId) {
            // Seleccionar dos equipos diferentes aleatoriamente
            $equiposAleatorios = array_rand($equiposIds, 2);
            $equipoId1 = $equiposIds[$equiposAleatorios[0]];
            $equipoId2 = $equiposIds[$equiposAleatorios[1]];

            $data[] = [
                'equipo_id' => $equipoId1,
                'partido_id' => $partidoId,
                'es_ganador' => rand(0, 1), // 0 = no ganador, 1 = ganador
            ];

            $data[] = [
                'equipo_id' => $equipoId2,
                'partido_id' => $partidoId,
                'es_ganador' => rand(0, 1), // 0 = no ganador, 1 = ganador
            ];
        }

        // Insertar datos en la tabla equipo_partido
        DB::table("equipo_partido")->insert($data);
    }
}
