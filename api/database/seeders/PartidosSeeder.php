<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PartidosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table("partidos")->insert([
            ['fecha' => '2024-07-02', 'jugado' => false, 'estadio_id' => 1],
            ['fecha' => '2024-07-03', 'jugado' => false, 'estadio_id' => 2],
            ['fecha' => '2024-07-04', 'jugado' => false, 'estadio_id' => 3],
            ['fecha' => '2024-07-05', 'jugado' => false, 'estadio_id' => 4],
            ['fecha' => '2024-07-06', 'jugado' => false, 'estadio_id' => 5],
            ['fecha' => '2024-07-07', 'jugado' => false, 'estadio_id' => 6],
            ['fecha' => '2024-07-08', 'jugado' => false, 'estadio_id' => 7],
            ['fecha' => '2024-07-09', 'jugado' => false, 'estadio_id' => 8],
            ['fecha' => '2024-07-10', 'jugado' => false, 'estadio_id' => 9],
            ['fecha' => '2024-07-11', 'jugado' => false, 'estadio_id' => 10],
            ['fecha' => '2024-07-12', 'jugado' => false, 'estadio_id' => 11],
            ['fecha' => '2024-07-13', 'jugado' => false, 'estadio_id' => 12],
            ['fecha' => '2024-07-14', 'jugado' => false, 'estadio_id' => 13],
            ['fecha' => '2024-07-15', 'jugado' => false, 'estadio_id' => 14],
            ['fecha' => '2024-07-16', 'jugado' => false, 'estadio_id' => 15]
        ]);
    }
}
