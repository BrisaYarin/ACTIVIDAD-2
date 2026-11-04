`timescale 1ns / 1ps

module tb_debounce1();

    localparam CLK_PERIOD = 10;

    logic clk;
    logic reset;
    logic sw;
    logic db;

    // Instancia del módulo debounce
    debounce1 uut (
        .clk(clk),
        .reset(reset),
        .sw(sw),
        .db(db)
    );

    // Generador de reloj
    always #(CLK_PERIOD / 2) clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        sw = 0;

        #20;
        reset = 0;
        #20;

        // Simular rebotes al presionar el botón
        sw = 1; #10;
        sw = 0; #10;
        sw = 1; #15;
        sw = 0; #10;
        sw = 1; #100; // Se estabiliza en 1

        // Simular rebotes al soltar el botón
        sw = 0; #10;
        sw = 1; #10;
        sw = 0; #100; // Se estabiliza en 0

        $stop;
    end

endmodule