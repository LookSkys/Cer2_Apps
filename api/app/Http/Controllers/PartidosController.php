<?php

namespace App\Http\Controllers;

use App\Models\Partido;
use Illuminate\Http\Request;
use App\Models\Equipo;
use App\Models\EquipoPartido;

class PartidosController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $partidos = Partido::orderBy('lugar')->get();
        return $partidos;
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
        $partido = new Partido();
        $partido->fecha = $request->fecha;
        $partido->hora = $request->hora;
        $partido->jugado = 0;
        $partido->lugar = $request->lugar;
        $partido->campeonato_id = $request->campeonato_id;
        $partido->save();
        return response()->json($partido, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Partido $partido)
    {
        return $partido;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Partido $partido)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Partido $partido)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Partido $partido)
    {
        return $partido->delete();
    }
}
