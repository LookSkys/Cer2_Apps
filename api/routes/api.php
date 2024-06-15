<?php

use App\Http\Controllers\Campeonato_equipoController;
use App\Http\Controllers\CampeonatosController;
use App\Http\Controllers\Equipo_partidoController;
use App\Http\Controllers\EquiposController;
use App\Http\Controllers\JugadoresController;
use App\Http\Controllers\PartidosController;
use App\Http\Controllers\ResultadosController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::resource('/equipos', EquiposController::class);
Route::resource('/jugadores', JugadoresController::class);
Route::resource('/partidos', PartidosController::class);
Route::resource('/campeonatos', CampeonatosController::class);
route::resource('/resultados', ResultadosController::class);
route::resource('/equipo_partido', Equipo_partidoController::class);
route::resource('/campeonato_equipo', Campeonato_equipoController::class);
Route::post('/campeonatos/{campeonatoId}/equipos', [CampeonatosController::class, 'vincularEquipo']);
Route::post('/campeonatos', [CampeonatosController::class, 'store']);
Route::post('/equipos', [EquiposController::class, 'store']);
Route::post('/jugadores', [JugadoresController::class, 'store']);
Route::post('/partidos', [PartidosController::class, 'store']);
Route::post('/equipo-partido/vincular', [Equipo_partidoController::class, 'vincularEquipos']);
Route::post('/resultados', [ResultadosController::class, 'store']);
Route::put('/campeonatos/{campeonatoId}', [CampeonatosController::class, 'update']);

