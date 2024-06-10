<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JugadoresSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table("jugadores")->insert([
            ['rut' => '21203724-9', 'nombre' => 'Enrique', 'apellido' => 'Sanhueza', 'equipo_id' => 1],
            ['rut' => '21304725-3', 'nombre' => 'Juan', 'apellido' => 'Pérez', 'equipo_id' => 1],
            ['rut' => '21405726-7', 'nombre' => 'Luis', 'apellido' => 'González', 'equipo_id' => 2],
            ['rut' => '21506727-1', 'nombre' => 'Carlos', 'apellido' => 'Ramírez', 'equipo_id' => 2],
            ['rut' => '21607728-5', 'nombre' => 'José', 'apellido' => 'Hernández', 'equipo_id' => 3],
            ['rut' => '21708729-9', 'nombre' => 'Andrés', 'apellido' => 'Martínez', 'equipo_id' => 3],
            ['rut' => '21809730-2', 'nombre' => 'Miguel', 'apellido' => 'López', 'equipo_id' => 4],
            ['rut' => '21910731-6', 'nombre' => 'Fernando', 'apellido' => 'Díaz', 'equipo_id' => 4],
            ['rut' => '22011732-0', 'nombre' => 'Javier', 'apellido' => 'Torres', 'equipo_id' => 5],
            ['rut' => '22112733-4', 'nombre' => 'Pablo', 'apellido' => 'Sánchez', 'equipo_id' => 5],
            ['rut' => '22213734-8', 'nombre' => 'Eduardo', 'apellido' => 'Cruz', 'equipo_id' => 6],
            ['rut' => '22314735-2', 'nombre' => 'Manuel', 'apellido' => 'Rojas', 'equipo_id' => 6],
            ['rut' => '22415736-6', 'nombre' => 'Sebastián', 'apellido' => 'Morales', 'equipo_id' => 7],
            ['rut' => '22516737-0', 'nombre' => 'Rodrigo', 'apellido' => 'Ortiz', 'equipo_id' => 7],
            ['rut' => '22617738-4', 'nombre' => 'Felipe', 'apellido' => 'Reyes', 'equipo_id' => 8],
            ['rut' => '22718739-8', 'nombre' => 'Francisco', 'apellido' => 'Flores', 'equipo_id' => 8],
            ['rut' => '22819740-1', 'nombre' => 'Alberto', 'apellido' => 'García', 'equipo_id' => 9],
            ['rut' => '22920741-5', 'nombre' => 'Santiago', 'apellido' => 'Vargas', 'equipo_id' => 9],
            ['rut' => '23021742-9', 'nombre' => 'Diego', 'apellido' => 'Mendoza', 'equipo_id' => 10],
            ['rut' => '23122743-3', 'nombre' => 'Ricardo', 'apellido' => 'Fuentes', 'equipo_id' => 10],
        ]);
    }
}
