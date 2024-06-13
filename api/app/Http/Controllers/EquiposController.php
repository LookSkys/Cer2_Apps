<?php

namespace App\Http\Controllers;

use App\Models\Equipo;
use Illuminate\Http\Request;

class EquiposController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $equipos = Equipo::orderBy('nombre')->get();
        return $equipos;
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
        $equipo = new Equipo();
        $equipo->nombre = $request->nombre;
        $equipo->entrenador = $request->entrenador;
        $equipo->juegos_en_donde_participa = $request->juegos_en_donde_participa;
        $equipo->save();
        return $equipo;
    }

    /**
     * Display the specified resource.
     */
    public function show(Equipo $equipo)
    {
        return $equipo;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Equipo $equipo)
    {
        return $equipo;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Equipo $equipo)
    {
        $equipo->nombre = $request->nombre;
        $equipo->entrenador = $request->entrenador;
        $equipo->juegos_en_donde_participa = $request->juegos_en_donde_participa;
        $equipo->save();

        return $equipo;
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Equipo $equipo)
    {
        return $equipo->delete();
    }
}
