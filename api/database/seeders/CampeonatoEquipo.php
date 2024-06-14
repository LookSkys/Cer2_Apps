<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CampeonatoEquipo extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Variables
        $totalCampeonatos = 10;
        $totalEquipos = 10;
        $registrosPorCampeonato = 10; // Puedes ajustar esto si quieres más o menos registros por campeonato

        // Obtener ids de todos los campeonatos y equipos
        $campeonatosIds = range(1, $totalCampeonatos);
        $equiposIds = range(1, $totalEquipos);

        // Preparar datos a insertar
        $data = [];

        // Generar registros aleatorios para cada campeonato
        foreach ($campeonatosIds as $campeonatoId) {
            // Obtener 10 equipos aleatorios para este campeonato
            $equiposSeleccionados = array_rand($equiposIds, $registrosPorCampeonato);

            foreach ($equiposSeleccionados as $index) {
                $equipoId = $equiposIds[$index];

                $data[] = [
                    'campeonato_id' => $campeonatoId,
                    'equipo_id' => $equipoId,
                ];
            }
        }

        // Insertar datos en la tabla campeonato_equipo
        DB::table("campeonato_equipo")->insert($data);
    }
}
