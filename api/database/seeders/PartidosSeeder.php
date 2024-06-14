<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PartidosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('partidos')->insert([
            ['fecha' => '2024-06-11', 'hora' => '14:30', 'jugado' => false, 'lugar' => 'Estadio Santiago Bernabéu', 'campeonato_id' => 1],
            ['fecha' => '2024-06-12', 'hora' => '15:00', 'jugado' => false, 'lugar' => 'Old Trafford', 'campeonato_id' => 1],
            ['fecha' => '2024-07-02', 'hora' => '18:00', 'jugado' => false, 'lugar' => 'MetLife Stadium', 'campeonato_id' => 2],
            ['fecha' => '2024-07-05', 'hora' => '19:30', 'jugado' => false, 'lugar' => 'Lambeau Field', 'campeonato_id' => 2],
            ['fecha' => '2024-08-20', 'hora' => '16:00', 'jugado' => false, 'lugar' => 'Staples Center', 'campeonato_id' => 3],
            ['fecha' => '2024-08-25', 'hora' => '17:00', 'jugado' => false, 'lugar' => 'Madison Square Garden', 'campeonato_id' => 3],
            ['fecha' => '2024-09-10', 'hora' => '18:30', 'jugado' => false, 'lugar' => 'Bell Centre', 'campeonato_id' => 4],
            ['fecha' => '2024-09-15', 'hora' => '20:00', 'jugado' => false, 'lugar' => 'Scotiabank Arena', 'campeonato_id' => 4],
            ['fecha' => '2024-10-06', 'hora' => '19:00', 'jugado' => false, 'lugar' => 'T-Mobile Arena', 'campeonato_id' => 5],
            ['fecha' => '2024-10-10', 'hora' => '21:30', 'jugado' => false, 'lugar' => 'Madison Square Garden', 'campeonato_id' => 5],
            ['fecha' => '2024-11-15', 'hora' => '18:00', 'jugado' => false, 'lugar' => 'Staples Center', 'campeonato_id' => 6],
            ['fecha' => '2024-11-20', 'hora' => '19:00', 'jugado' => false, 'lugar' => 'Olympic Stadium', 'campeonato_id' => 6],
            ['fecha' => '2024-12-18', 'hora' => '16:30', 'jugado' => false, 'lugar' => 'BlizzCon Arena', 'campeonato_id' => 7],
            ['fecha' => '2024-12-22', 'hora' => '18:00', 'jugado' => false, 'lugar' => 'BlizzCon Arena', 'campeonato_id' => 7],
            ['fecha' => '2025-01-25', 'hora' => '17:00', 'jugado' => false, 'lugar' => 'Rogers Arena', 'campeonato_id' => 8],
            ['fecha' => '2025-01-30', 'hora' => '19:30', 'jugado' => false, 'lugar' => 'KeyArena', 'campeonato_id' => 8],
            ['fecha' => '2025-03-05', 'hora' => '20:00', 'jugado' => false, 'lugar' => 'Esports Stadium Arlington', 'campeonato_id' => 9],
            ['fecha' => '2025-03-10', 'hora' => '21:00', 'jugado' => false, 'lugar' => 'Gfinity Arena', 'campeonato_id' => 9],
            ['fecha' => '2025-04-08', 'hora' => '18:30', 'jugado' => false, 'lugar' => 'Rocket League Arena', 'campeonato_id' => 10],
            ['fecha' => '2025-04-12', 'hora' => '20:00', 'jugado' => false, 'lugar' => 'Rocket League Arena', 'campeonato_id' => 10],
        ]);
    }
}
