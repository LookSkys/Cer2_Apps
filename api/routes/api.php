<?php

use App\Http\Controllers\CampeonatosController;
use App\Http\Controllers\EquiposController;
use App\Http\Controllers\EstadiosController;
use App\Http\Controllers\JugadoresController;
use App\Http\Controllers\PartidosController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

Route::resource('/equipos', EquiposController::class);
Route::resource('/estadios', EstadiosController::class);
Route::resource('/jugadores', JugadoresController::class);
Route::resource('/partidos', PartidosController::class);
Route::resource('/campeonatos', CampeonatosController::class);
