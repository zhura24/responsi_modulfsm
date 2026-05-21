`timescale 1ns / 1ps

module top_mealy(
    input         CLK100MHZ,
    input         SW0,
    input         BTNC,
    input         BTND,
    output        LED0,
    output        LED2,
    output        LED3,
    output [7:0]  AN,
    output [6:0]  SEG
);

    wire clk_en;
    wire reset;

    reg reset_sync0 = 0, reset_sync1 = 0;
    always @(posedge CLK100MHZ) begin
        reset_sync0 <= BTND;
        reset_sync1 <= reset_sync0;
    end
    assign reset = reset_sync1;

    debouncer u_debouncer(
        .clk(CLK100MHZ),
        .btn(BTNC),
        .pulse(clk_en)
    );

    wire w = SW0;
    wire y;
    wire [1:0] state;

    fsm_mealy u_fsm(
        .clk(CLK100MHZ),
        .ce(clk_en),
        .reset(reset),
        .w(w),
        .y(y),
        .state(state)
    );

    assign LED0 = y;
    assign LED2 = state[0];
    assign LED3 = state[1];

    seven_seg_display u_display(
        .clk(CLK100MHZ),
        .hex7(4'hC),                  // AN7: A
        .hex6({3'b0, w}),             // AN6: input value
        .hex5(4'hD),                  // AN5: y
        .hex4({3'b0, y}),             // AN4: output value
        .hex3(4'h5),                  // AN3: s (state prefix)
        .hex2(4'hA),                  // AN2: t (state prefix)
        .hex1({3'b0, state[1]}),      // AN1: state bit 1
        .hex0({3'b0, state[0]}),      // AN0: state bit 0
        .AN(AN),
        .SEG(SEG)
    );

endmodule
