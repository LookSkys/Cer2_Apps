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
            $table->unsignedBigInteger('campeonato_id');
            $table->unsignedBigInteger('equipo_id');
            $table->primary(['campeonato_id', 'equipo_id']);

            $table->foreign('campeonato_id')->references('id')->on('campeonato')->onDelete('cascade');
            $table->foreign('equipo_id')->references('id')->on('equipos')->onDelete('cascade');
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
