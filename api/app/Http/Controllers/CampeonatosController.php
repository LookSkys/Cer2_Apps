<?php

namespace App\Http\Controllers;

use App\Models\Campeonato;
use App\Models\Equipo;
use App\Models\CampeonatoEquipo;
use Illuminate\Http\Request;

class CampeonatosController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $campeonatos = Campeonato::orderBy('nombre')->get();
        return $campeonatos;
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $campeonato = new Campeonato();
        $campeonato->nombre = $request->nombre;
        $campeonato->fecha_inicio = $request->fecha_inicio;
        $campeonato->fecha_fin = $request->fecha_fin;
        $campeonato->reglas = $request->reglas;
        $campeonato->premios = $request->premios;
        $campeonato->save();
        return $campeonato;
    }

    /**
     * Display the specified resource.
     */
    public function show(Campeonato $campeonato)
    {
        return $campeonato;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Campeonato $campeonato)
    {
        return $campeonato;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Campeonato $campeonato)
    {
        $campeonato->nombre = $request->nombre;
        $campeonato->fecha_inicio = $request->fecha_inicio;
        $campeonato->fecha_fin = $request->fecha_fin;
        $campeonato->reglas = $request->reglas;
        $campeonato->premios = $request->premios;
        $campeonato->save();
        return $campeonato;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Campeonato $campeonato)
    {
        return $campeonato->delete();
    }

    /**
     * Vincular un equipo a un campeonato.
     */
    public function vincularEquipo(Request $request, $campeonatoId)
    {
        $equipoId = $request->input('equipo_id');

        // Verificar si el equipo ya está vinculado al campeonato
        $existeVinculo = CampeonatoEquipo::where('campeonato_id', $campeonatoId)
            ->where('equipo_id', $equipoId)
            ->first();

        if ($existeVinculo) {
            return response()->json(['error' => 'El equipo ya está vinculado a este campeonato'], 400);
        }

        // Crear el nuevo vínculo
        $campeonato = Campeonato::find($campeonatoId);

        if (!$campeonato) {
            return response()->json(['error' => 'Campeonato no encontrado'], 404);
        }

        $equipo = Equipo::find($equipoId);

        if (!$equipo) {
            return response()->json(['error' => 'Equipo no encontrado'], 404);
        }

        $campeonato->equipos()->attach($equipoId);

        return response()->json(['message' => 'Equipo vinculado correctamente'], 201);
    }

}
