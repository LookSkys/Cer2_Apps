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
            ['rut' => '21203724-9', 'nombre' => 'Enrique', 'apellido' => 'Sanhueza', 'num_camiseta' => '1', 'posicion' => 'Delantero', 'equipo_id' => 1],
            ['rut' => '19283746-5', 'nombre' => 'Carlos', 'apellido' => 'González', 'num_camiseta' => '9', 'posicion' => 'Delantero', 'equipo_id' => 2],
            ['rut' => '17483920-3', 'nombre' => 'José', 'apellido' => 'Martínez', 'num_camiseta' => '10', 'posicion' => 'Mediocampista', 'equipo_id' => 3],
            ['rut' => '15827364-7', 'nombre' => 'Luis', 'apellido' => 'Ramírez', 'num_camiseta' => '7', 'posicion' => 'Extremo', 'equipo_id' => 4],
            ['rut' => '14682937-8', 'nombre' => 'Mario', 'apellido' => 'Fernández', 'num_camiseta' => '5', 'posicion' => 'Defensa', 'equipo_id' => 5],
            ['rut' => '13574829-6', 'nombre' => 'Juan', 'apellido' => 'Pérez', 'num_camiseta' => '4', 'posicion' => 'Defensa', 'equipo_id' => 6],
            ['rut' => '12483920-4', 'nombre' => 'Alberto', 'apellido' => 'Sánchez', 'num_camiseta' => '8', 'posicion' => 'Mediocampista', 'equipo_id' => 7],
            ['rut' => '11473829-7', 'nombre' => 'Fernando', 'apellido' => 'Gutiérrez', 'num_camiseta' => '11', 'posicion' => 'Delantero', 'equipo_id' => 8],
            ['rut' => '10394820-2', 'nombre' => 'Ricardo', 'apellido' => 'López', 'num_camiseta' => '3', 'posicion' => 'Defensa', 'equipo_id' => 9],
            ['rut' => '09384756-1', 'nombre' => 'Hugo', 'apellido' => 'Morales', 'num_camiseta' => '6', 'posicion' => 'Mediocampista', 'equipo_id' => 10],
            ['rut' => '08374629-5', 'nombre' => 'Roberto', 'apellido' => 'Castro', 'num_camiseta' => '2', 'posicion' => 'Portero', 'equipo_id' => 11],
            ['rut' => '07384756-3', 'nombre' => 'Cristian', 'apellido' => 'Ríos', 'num_camiseta' => '13', 'posicion' => 'Delantero', 'equipo_id' => 12],
            ['rut' => '06384920-7', 'nombre' => 'Sebastián', 'apellido' => 'Vargas', 'num_camiseta' => '14', 'posicion' => 'Extremo', 'equipo_id' => 13],
            ['rut' => '05374829-8', 'nombre' => 'Rodrigo', 'apellido' => 'Hernández', 'num_camiseta' => '15', 'posicion' => 'Defensa', 'equipo_id' => 14],
            ['rut' => '04382746-9', 'nombre' => 'Javier', 'apellido' => 'Díaz', 'num_camiseta' => '16', 'posicion' => 'Mediocampista', 'equipo_id' => 15],
        ]);
    }
}
