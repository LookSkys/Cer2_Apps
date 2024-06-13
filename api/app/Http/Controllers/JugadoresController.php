<?php

namespace App\Http\Controllers;

use App\Models\Jugador;
use Illuminate\Http\Request;

class JugadoresController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $jugadores = Jugador::orderBy('nombre')->get();
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
        $request->validate([
            'rut' => 'required|unique:jugadores',
            'nombre' => 'required',
            'apellido' => 'required',
            'equipo_id' => 'required|exists:equipos,id',
        ]);

        $jugador = Jugador::create($request->all());

        return response()->json($jugador, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Jugador $jugador)
    {
        return $jugador;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Jugador $jugador)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Jugador $jugador)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Jugador $jugador)
    {
        //
    }
}
