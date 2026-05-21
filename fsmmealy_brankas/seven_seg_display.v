`timescale 1ns / 1ps

module seven_seg_display(
    input         clk,
    input  [3:0]  hex7, hex6, hex5, hex4, hex3, hex2, hex1, hex0,
    output [7:0]  AN,
    output [6:0]  SEG
);

    reg [16:0] refresh_counter = 0;
    reg [2:0]  sel = 0;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        if (refresh_counter == 17'd50000) begin
            refresh_counter <= 0;
            sel <= sel + 1;
        end
    end

    reg [7:0] an_reg;
    always @(*) begin
        an_reg = 8'hFF;
        an_reg[sel] = 1'b0;
    end
    assign AN = an_reg;

    reg [3:0] digit;
    always @(*) begin
        case(sel)
            3'd0: digit = hex0;
            3'd1: digit = hex1;
            3'd2: digit = hex2;
            3'd3: digit = hex3;
            3'd4: digit = hex4;
            3'd5: digit = hex5;
            3'd6: digit = hex6;
            3'd7: digit = hex7;
            default: digit = 4'hB;
        endcase
    end

    reg [6:0] seg_reg;
    always @(*) begin
        case(digit)
            4'h0: seg_reg = 7'b1000000;
            4'h1: seg_reg = 7'b1111001;
            4'h2: seg_reg = 7'b0100100;
            4'h3: seg_reg = 7'b0110000;
            4'h4: seg_reg = 7'b0011001;
            4'h5: seg_reg = 7'b0010010;
            4'h6: seg_reg = 7'b0000010;
            4'h7: seg_reg = 7'b1111000;
            4'h8: seg_reg = 7'b0000000;
            4'h9: seg_reg = 7'b0010000;
            4'hA: seg_reg = 7'b0000111;
            4'hB: seg_reg = 7'b1111111;
            4'hC: seg_reg = 7'b0001000;
            4'hD: seg_reg = 7'b0010001;
            4'hE: seg_reg = 7'b0000110;
            4'hF: seg_reg = 7'b0001110;
            default: seg_reg = 7'b1111111;
        endcase
    end
    assign SEG = seg_reg;

endmodule
