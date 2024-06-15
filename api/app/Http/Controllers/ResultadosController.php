<?php

namespace App\Http\Controllers;

use App\Models\Resultado;
use Illuminate\Http\Request;

class ResultadosController
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $resultados = Resultado::orderBy('puntuacion_ganador')->get();
        return $resultados;
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
        try {
            $resultado = new Resultado(); // Asegúrate de tener el modelo Resultado definido

            // Asignar los datos del request al modelo
            $resultado->puntuacion_ganador = $request->puntuacion_ganador;
            $resultado->puntuacion_perdedor = $request->puntuacion_perdedor;
            $resultado->partido_id = $request->partido_id;
            $resultado->equipo_ganador_id = $request->equipo_ganador_id;
            $resultado->equipo_perdedor_id = $request->equipo_perdedor_id;

            // Guardar el resultado
            $resultado->save();

            // Retornar el resultado guardado
            return response()->json($resultado, 201);
        } catch (\Exception $e) {
            // Capturar y manejar cualquier excepción
            return response()->json(['error' => 'Error al crear resultado: ' . $e->getMessage()], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(Resultado $resultado)
    {
        return $resultado;
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Resultado $resultado)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Resultado $resultado)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Resultado $resultado)
    {
        return $resultado->delete();
    }
}
