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
        DB::table('equipos')->insert([
            [
                'nombre' => 'Real Madrid',
                'entrenador' => 'Carlo Ancelotti',
                'juegos_en_donde_participa' => json_encode(['FIFA 21', 'FIFA 22'])
            ],
            [
                'nombre' => 'FC Barcelona',
                'entrenador' => 'Xavi Hernández',
                'juegos_en_donde_participa' => json_encode(['FIFA 21', 'FIFA 22'])
            ],
            [
                'nombre' => 'Team Liquid',
                'entrenador' => 'Steve Arhancet',
                'juegos_en_donde_participa' => json_encode(['League of Legends', 'Dota 2'])
            ],
            [
                'nombre' => 'Cloud9',
                'entrenador' => 'Jack Etienne',
                'juegos_en_donde_participa' => json_encode(['League of Legends', 'CS:GO'])
            ],
            [
                'nombre' => 'Fnatic',
                'entrenador' => 'Andreas Samuelsson',
                'juegos_en_donde_participa' => json_encode(['League of Legends', 'CS:GO'])
            ],
            [
                'nombre' => 'G2 Esports',
                'entrenador' => 'Carlos Rodríguez',
                'juegos_en_donde_participa' => json_encode(['League of Legends', 'CS:GO'])
            ],
            [
                'nombre' => 'T1',
                'entrenador' => 'Choi Byoung-hoon',
                'juegos_en_donde_participa' => json_encode(['League of Legends'])
            ],
            [
                'nombre' => 'Astralis',
                'entrenador' => 'Danny Sørensen',
                'juegos_en_donde_participa' => json_encode(['CS:GO'])
            ],
            [
                'nombre' => 'Natus Vincere',
                'entrenador' => 'Andrey Gorodenskiy',
                'juegos_en_donde_participa' => json_encode(['CS:GO', 'Dota 2'])
            ],
            [
                'nombre' => 'Team SoloMid',
                'entrenador' => 'Parth Naidu',
                'juegos_en_donde_participa' => json_encode(['League of Legends', 'Fortnite'])
            ],
        ]);
    }
}

