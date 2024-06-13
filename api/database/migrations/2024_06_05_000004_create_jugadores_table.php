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
        Schema::create('jugadores', function (Blueprint $table) {
            $table->string('rut', 10)->primary();
            $table->string('nombre', 20)->nullable(false);
            $table->string('apellido', 20)->nullable(false);
            $table->unsignedBigInteger('equipo_id')->nullable(false);

            $table->foreign('equipo_id')->references('id')->on('equipos')->onDelete('cascade');
            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jugadores');
    }
};
