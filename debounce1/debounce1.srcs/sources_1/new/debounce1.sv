module debounce1 (
    input  logic clk,
    input  logic reset,
    input  logic sw,      // Señal ruidosa del botón (switch)
    output logic db       // Señal filtrada y limpia (debounced)
);

    // Parámetro de estados de la máquina
    typedef enum logic [3:0] {
        zero      = 4'b0000,
        wait1_1   = 4'b0001,
        wait1_2   = 4'b0010,
        wait1_3   = 4'b0011,
        one       = 4'b0100,
        wait0_1   = 4'b0101,
        wait0_2   = 4'b0110,
        wait0_3   = 4'b0111
    } state_t;

    state_t state_reg, state_next;

    // Suposición de tick de muestreo (en proyectos reales se conecta a un divisor de ticks)
    // Para simulación rápida, podemos usar un generador de enable o tick de muestreo.
    // Aquí asumiremos temporalmente m_tick = 1'b1 o lo manejaremos con un contador interno.
    logic m_tick = 1'b1; 

    // Registro de estados
    always_ff @(posedge clk, posedge reset) begin
        if (reset)
            state_reg <= zero;
        else
            state_reg <= state_next;
    end

    // Lógica de estado siguiente y salida
    always_comb begin
        state_next = state_reg;
        db = 1'b0;

        case (state_reg)
            zero: begin
                db = 1'b0;
                if (sw)
                    state_next = wait1_1;
            end

            wait1_1: begin
                db = 1'b0;
                if (!sw)
                    state_next = zero;
                else if (m_tick)
                    state_next = wait1_2;
            end

            wait1_2: begin
                db = 1'b0;
                if (!sw)
                    state_next = zero;
                else if (m_tick)
                    state_next = wait1_3;
            end

            wait1_3: begin
                db = 1'b0;
                if (!sw)
                    state_next = zero;
                else if (m_tick)
                    state_next = one;
            end

            one: begin
                db = 1'b1;
                if (!sw)
                    state_next = wait0_1;
            end

            wait0_1: begin
                db = 1'b1;
                if (sw)
                    state_next = one;
                else if (m_tick)
                    state_next = wait0_2;
            end

            wait0_2: begin
                db = 1'b1;
                if (sw)
                    state_next = one;
                else if (m_tick)
                    state_next = wait0_3;
            end

            wait0_3: begin
                db = 1'b1;
                if (sw)
                    state_one: state_next = one; // o one directo
                else if (m_tick)
                    state_next = zero;
            end

            default: state_next = zero;
        endcase
    end

endmodule