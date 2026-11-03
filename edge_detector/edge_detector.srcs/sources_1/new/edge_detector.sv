`timescale 1ns / 1ps

module edge_detector (
    input  logic clk,
    input  logic reset,
    input  logic level,
    output logic tick
);

    // Estados de la maquina
    typedef enum logic [1:0] {
        zero       = 2'b00,
        edge_state = 2'b01,
        one        = 2'b10
    } state_t;

    state_t state_reg, state_next;

    // Registro de estados
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
    end

    // Cambio de estados y salida
    always_comb begin
        state_next = state_reg;
        tick = 1'b0;

        case (state_reg)

            zero: begin
                if (level)
                    state_next = edge_state;
                else
                    state_next = zero;
            end

            edge_state: begin
                tick = 1'b1;
                if (level)
                    state_next = one;
                else
                    state_next = zero;
            end

            one: begin
                if (level)
                    state_next = one;
                else
                    state_next = zero;
            end

            default: begin
                state_next = zero;
            end

        endcase
    end

endmodule