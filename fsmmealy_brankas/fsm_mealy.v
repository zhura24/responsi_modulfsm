`timescale 1ns / 1ps

module fsm_mealy(
    input         clk,
    input         ce,
    input         reset,
    input         w,
    output        y,
    output [1:0]  state
);

    localparam S0 = 2'b00,
               S1 = 2'b01,
               S2 = 2'b10,
               S3 = 2'b11;

    reg [1:0] current_state = S0;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else if (ce) begin
            case(current_state)
                S0: current_state <= w ? S1 : S0;
                S1: current_state <= w ? S2 : S0;
                S2: current_state <= w ? S2 : S3;
                S3: current_state <= w ? S1 : S0;
                default: current_state <= S0;
            endcase
        end
    end

    assign y = (current_state == S3 && w == 1'b1) ? 1'b1 : 1'b0;
    assign state = current_state;

endmodule
