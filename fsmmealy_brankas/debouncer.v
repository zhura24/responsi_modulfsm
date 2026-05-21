`timescale 1ns / 1ps

module debouncer(
    input  clk,
    input  btn,
    output pulse
);

    reg [19:0] count = 0;
    reg btn_sync0 = 0, btn_sync1 = 0, btn_stable = 0;
    reg btn_stable_d1 = 0;

    always @(posedge clk) begin
        btn_sync0 <= btn;
        btn_sync1 <= btn_sync0;
    end

    always @(posedge clk) begin
        if (btn_sync1 != btn_stable) begin
            if (count == 20'd1000000) begin
                btn_stable <= btn_sync1;
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end else begin
            count <= 0;
        end
    end

    always @(posedge clk) begin
        btn_stable_d1 <= btn_stable;
    end

    assign pulse = btn_stable & ~btn_stable_d1;

endmodule
