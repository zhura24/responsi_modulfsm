// ============================================================
// Testbench - FSM Moore Traffic Light Controller
// Simulasi perpindahan state: S0->S1->S2->S3->S0
// ============================================================
`timescale 1ns / 1ps

module tb_fsm_moore_traffic;

    reg        clk;
    reg        rst;
    reg        w;
    wire [2:0] y;
    wire [6:0] seg;
    wire       dp;
    wire [7:0] an;

    // Instantiate DUT
    fsm_moore_traffic dut (
        .clk(clk),
        .rst(rst),
        .w(w),
        .y(y),
        .seg(seg),
        .dp(dp),
        .an(an)
    );

    // Clock 100 MHz -> periode 10 ns
    initial clk = 0;
    always #5 clk = ~clk;

    // Override clk_div untuk simulasi cepat
    // (gunakan force/release jika simulator mendukung)

    task show_state;
        input [1:0] st;
        begin
            case (st)
                2'b00: $display("  State=S0 (GREEN),       y=%b", y);
                2'b01: $display("  State=S1 (YELLOW),      y=%b", y);
                2'b10: $display("  State=S2 (RED),         y=%b", y);
                2'b11: $display("  State=S3 (RED+YELLOW),  y=%b", y);
            endcase
        end
    endtask

    initial begin
        $display("=== FSM Moore Traffic Light - Simulation ===");
        $display("Format: y[2:0] = {R, Y, G}");

        // Reset
        rst = 1; w = 0;
        #20; rst = 0;
        $display("\n[RST] Released. State=S0, w=0");
        show_state(dut.state);

        // S0 tetap (w=0)
        w = 0;
        // Force transisi cepat (override clk_1hz)
        force dut.clk_1hz = 0;
        #10; force dut.clk_1hz = 1; #10;
        force dut.clk_1hz = 0; #10;
        $display("\n[w=0] S0 harus tetap GREEN");
        show_state(dut.state);

        // S0 -> S1 (w=1)
        w = 1;
        force dut.clk_1hz = 1; #10;
        force dut.clk_1hz = 0; #10;
        $display("\n[w=1] S0->S1: harus YELLOW");
        show_state(dut.state);

        // S1 -> S2 (selalu)
        force dut.clk_1hz = 1; #10;
        force dut.clk_1hz = 0; #10;
        $display("\n[auto] S1->S2: harus RED");
        show_state(dut.state);

        // S2 -> S3
        force dut.clk_1hz = 1; #10;
        force dut.clk_1hz = 0; #10;
        $display("\n[auto] S2->S3: harus RED+YELLOW");
        show_state(dut.state);

        // S3 -> S0
        force dut.clk_1hz = 1; #10;
        force dut.clk_1hz = 0; #10;
        $display("\n[auto] S3->S0: harus GREEN");
        show_state(dut.state);

        release dut.clk_1hz;

        $display("\n=== Simulasi Selesai ===");
        #50; $finish;
    end

endmodule
