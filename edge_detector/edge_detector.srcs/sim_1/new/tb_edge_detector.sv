`timescale 1ns / 1ps

module tb_edge_detector();

    localparam CLK_PERIOD = 10;

    logic clk;
    logic reset;
    logic level;
    logic tick;

    // Instancia del modulo
    edge_detector uut (
        .clk(clk),
        .reset(reset),
        .level(level),
        .tick(tick)
    );

    // Generacion del reloj
    always #(CLK_PERIOD / 2) clk = ~clk;

    // Pruebas
    initial begin
        clk = 0;
        reset = 1;
        level = 0;

        #20;
        reset = 0;

        #20;

        // Primer cambio de 0 a 1
        level = 1;
        #40;

        level = 0;
        #30;

        // Segundo cambio de 0 a 1
        level = 1;
        #50;

        level = 0;
        #30;

        $stop;
    end

endmodule