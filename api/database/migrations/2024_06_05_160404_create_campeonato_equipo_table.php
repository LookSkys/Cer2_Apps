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
        Schema::create('campeonato_equipo', function (Blueprint $table) {
            $table->unsignedBigInteger('equipo_id');
            $table->unsignedBigInteger('campeonato_id');
            $table->primary(['equipo_id', 'campeonato_id']);

            $table->foreign('equipo_id')->references('id')->on('equipos');
            $table->foreign('campeonato_id')->references('id')->on('campeonato');

            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('campeonato_equipo');
    }
};
