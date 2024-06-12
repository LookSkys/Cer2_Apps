<?php

namespace App\Http\Controllers;

use App\Models\CampeonatoEquipo;
use Illuminate\Http\Request;

class Campeonato_equipoController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $jugadores = CampeonatoEquipo::all();
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
    public function show(CampeonatoEquipo $campeonatoEquipo)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(CampeonatoEquipo $campeonatoEquipo)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, CampeonatoEquipo $campeonatoEquipo)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(CampeonatoEquipo $campeonatoEquipo)
    {
        //
    }
}
