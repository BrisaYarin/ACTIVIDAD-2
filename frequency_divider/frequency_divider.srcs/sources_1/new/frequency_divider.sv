
module frequency_divider
#(
    parameter N = 17
)
(
    input  logic clk,
    input  logic reset,
    output logic s_out
);

    logic [N-1:0] contador;
    logic [N-1:0] contador_next;

    // Actualizacion del contador
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            contador <= 0;
        else
            contador <= contador_next;
    end

    // Incremento del contador
    assign contador_next = contador + 1'b1;

    // Salida tomada del bit mas significativo
    assign s_out = contador[N-1];

endmodule
