<?php

namespace App\Http\Controllers;

use App\Models\EquipoPartido;
use Illuminate\Http\Request;
use App\Models\Partido;
use App\Models\Equipo;

class Equipo_partidoController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $jugadores = EquipoPartido::all();
        return $jugadores;
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
        $equipoPartido = new EquipoPartido();
        $equipoPartido->equipo_id = $request->equipo_id;
        $equipoPartido->partido_id = $request->partido_id;
        $equipoPartido->es_ganador = 0;
        $equipoPartido->save();
        return $equipoPartido;
    }

    /**
     * Display the specified resource.
     */
    public function show(EquipoPartido $equipoPartido)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(EquipoPartido $equipoPartido)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */

    public function update(Request $request)
    {
        //
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(EquipoPartido $equipoPartido)
    {
        return $equipoPartido->delete();
    }
    public function vincularEquipos(Request $request)
    {
        $partidoId = $request->input('partido_id');
        $equipoIds = $request->input('equipo_ids');

        try {
            $partido = Partido::findOrFail($partidoId);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Partido no encontrado'], 404);
        }

        foreach ($equipoIds as $equipoId) {
            try {
                $equipo = Equipo::findOrFail($equipoId);
            } catch (\Exception $e) {
                return response()->json(['error' => 'Equipo no encontrado'], 404);
            }

            $equipoPartido = new EquipoPartido();
            $equipoPartido->partido_id = $partido->id;
            $equipoPartido->equipo_id = $equipo->id;
            $equipoPartido->es_ganador = 0;
            $equipoPartido->save();
        }

        return response()->json(['message' => 'Equipos vinculados correctamente'], 200);
    }
}
