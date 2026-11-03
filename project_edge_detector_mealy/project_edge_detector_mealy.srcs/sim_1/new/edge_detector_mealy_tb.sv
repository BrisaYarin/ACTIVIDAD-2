`timescale 1ns / 1ps


module edge_detector_mealy_tb();

    localparam CLK_PERIOD = 10; // Reloj de 100 MHz (10 ns)

    logic clk;
    logic reset;
    logic level;
    logic tick;

    // Instancia del módulo Mealy
    edge_detector_mealy uut (
        .clk(clk),
        .reset(reset),
        .level(level),
        .tick(tick)
    );

    // Generador de reloj
    always #(CLK_PERIOD / 2) clk = ~clk;

    // Estímulos de prueba
    initial begin
        clk = 0;
        reset = 1;
        level = 0;

        // Desactivar reset después de 20 ns
        #20;
        reset = 0;
        #20;

        // Primer flanco de subida
        level = 1;
        #40;

        // Bajar la señal a 0
        level = 0;
        #30;

        // Segundo flanco de subida
        level = 1;
        #50;

        // Regresar a 0
        level = 0;
        #30;

        $stop;
    end

endmodule