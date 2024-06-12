<?php

namespace App\Http\Controllers;

use App\Models\EquipoPartido;
use Illuminate\Http\Request;

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
        //
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
    public function update(Request $request, EquipoPartido $equipoPartido)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(EquipoPartido $equipoPartido)
    {
        //
    }
}
