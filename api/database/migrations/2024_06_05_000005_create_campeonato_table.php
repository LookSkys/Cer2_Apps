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
        Schema::create('campeonato', function (Blueprint $table) {
            $table->id();
            $table->string('nombre', 50);
            $table->date('fecha_inicio');
            $table->date('fecha_fin');
            $table->string('reglas', 300);
            $table->string('premios', 100);
            //$table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('campeonato');
    }
};
