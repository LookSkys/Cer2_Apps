<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('resultados', function (Blueprint $table) {
            $table->id();
            $table->tinyInteger('puntuacion_ganador')->default(0);
            $table->tinyInteger('puntuacion_perdedor')->default(0);
            $table->unsignedBigInteger('partido_id')->nullable(false);
            $table->unsignedBigInteger('equipo_ganador_id')->nullable(false);
            $table->unsignedBigInteger('equipo_perdedor_id')->nullable(false);

            $table->foreign('partido_id')->references('id')->on('partidos')->onDelete('cascade');
            $table->foreign('equipo_ganador_id')->references('id')->on('equipos')->onDelete('cascade');
            $table->foreign('equipo_perdedor_id')->references('id')->on('equipos')->onDelete('cascade');
            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('resultados');
    }
};
