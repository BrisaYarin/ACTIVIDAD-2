
module tb_frequency_divider;

    parameter N = 17;

    logic clk;
    logic reset;
    logic s_out;

    // Instancia del divisor de frecuencia
    frequency_divider #(
        .N(N)
    ) uut (
        .clk(clk),
        .reset(reset),
        .s_out(s_out)
    );

    // Generacion de la señal de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Pruebas del funcionamiento
    initial begin
        reset = 1;
        #20;
        reset = 0;

        // Tiempo suficiente para observar la salida
        #1500000;

        $finish;
    end

endmodule
