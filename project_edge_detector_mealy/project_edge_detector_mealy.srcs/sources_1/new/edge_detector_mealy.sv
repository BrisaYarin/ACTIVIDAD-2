`timescale 1ns / 1ps
module edge_detector_mealy (
    input  logic clk,
    input  logic reset,
    input  logic level,
    output logic tick
);

    // Solo 2 estados en la máquina de Mealy
    typedef enum logic {
        zero = 1'b0,
        one  = 1'b1
    } state_t;

    state_t state_reg, state_next;

    // Registro de estado
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
    end

    // Lógica de estado siguiente y salida (Mealy)
    always_comb begin
        state_next = state_reg;
        tick = 1'b0;

        case (state_reg)
            zero: begin
                if (level) begin
                    tick = 1'b1;       // La salida se activa durante la transición
                    state_next = one;
                end
            end

            one: begin
                if (!level)
                    state_next = zero;
            end
        endcase
    end

endmodule