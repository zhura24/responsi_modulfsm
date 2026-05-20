// ============================================================
// FSM MOORE - Traffic Light Controller  (FIXED FULL CODE)
// Board  : Nexys A7-100T
// Top    : fsm_moore_traffic
// Fix    : Urutan digit_sel dibalik agar susunan "wX yX StXX"
//          terbaca benar dari kiri ke kanan (AN7 ke AN0)
// ============================================================

module fsm_moore_traffic (
    input  wire        clk,
    input  wire        rst,   // BTNC active-high
    input  wire        w,     // SW0
    output reg  [2:0]  y,     // LED[2:0] = {R,Y,G}
    output wire [6:0]  seg,
    output wire        dp,
    output wire [7:0]  an
);

    // --------------------------------------------------
    // State encoding
    // --------------------------------------------------
    localparam [1:0] S0 = 2'b00,  // GREEN
                     S1 = 2'b01,  // YELLOW
                     S2 = 2'b10,  // RED
                     S3 = 2'b11;  // RED+YELLOW

    reg [1:0] state, next_state;

    // --------------------------------------------------
    // Clock divider: 100MHz -> 1Hz
    // --------------------------------------------------
    reg [26:0] div_cnt;
    reg        clk_1hz;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            div_cnt <= 27'd0;
            clk_1hz <= 1'b0;
        end else if (div_cnt == 27'd49_999_999) begin
            div_cnt <= 27'd0;
            clk_1hz <= ~clk_1hz;
        end else
            div_cnt <= div_cnt + 1'b1;
    end

    // --------------------------------------------------
    // State register
    // --------------------------------------------------
    always @(posedge clk_1hz or posedge rst) begin
        if (rst) state <= S0;
        else     state <= next_state;
    end

    // --------------------------------------------------
    // Next-state logic (kombinasional)
    // --------------------------------------------------
    always @(*) begin
        case (state)
            S0:      next_state = w ? S1 : S0;
            S1:      next_state = S2;
            S2:      next_state = S3;
            S3:      next_state = S0;
            default: next_state = S0;
        endcase
    end

    // --------------------------------------------------
    // Moore Output: hanya dari state, bukan input
    // y[2:0] = {R, Y, G}
    // --------------------------------------------------
    always @(*) begin
        case (state)
            S0:      y = 3'b001; // GREEN
            S1:      y = 3'b010; // YELLOW
            S2:      y = 3'b100; // RED
            S3:      y = 3'b110; // RED+YELLOW
            default: y = 3'b000;
        endcase
    end

    // --------------------------------------------------
    // Seven Segment Multiplexer
    // --------------------------------------------------
    reg [19:0] ref_cnt;
    reg  [2:0] digit_sel;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ref_cnt   <= 20'd0;
            digit_sel <= 3'd0;
        end else if (ref_cnt == 20'd99_999) begin
            ref_cnt   <= 20'd0;
            digit_sel <= digit_sel + 1'b1;
        end else
            ref_cnt <= ref_cnt + 1'b1;
    end

    // AN aktif LOW, nyalakan digit sesuai digit_sel
    assign an = ~(8'b0000_0001 << digit_sel);

    // KONTEN PER DIGIT DIURUTKAN ULANG DARI DIGIT_SEL 0 (KIRI) KE 7 (KANAN)
    reg [3:0] dval;
    always @(*) begin
        case (digit_sel)
            3'd0: dval = 4'hA;               // Tampil 'A' (mewakili 'w') di paling KIRI
            3'd1: dval = {3'b0, w};          // Nilai input w (0/1)
            3'd2: dval = 4'hB;               // Tampil 'b' (mewakili 'y')
            3'd3: dval = {3'b0, y[0]};       // Nilai y (menggunakan bit G)
            3'd4: dval = 4'hC;               // Tampil 'C' (mewakili 'S')
            3'd5: dval = 4'hD;               // Tampil 'd' (mewakili 't')
            3'd6: dval = {3'b0, state[1]};   // Bit-1 state (MSB)
            3'd7: dval = {3'b0, state[0]};   // Bit-0 state (LSB) di paling KANAN
            default: dval = 4'hF;            // Blank
        endcase
    end

    // Decoder 7-segment, common anode, seg aktif LOW
    assign dp = 1'b1;   // decimal point mati
    reg [6:0] seg_r;
    assign seg = seg_r;

    always @(*) begin
        case (dval)
            4'h0: seg_r = 7'b100_0000; // "0"
            4'h1: seg_r = 7'b111_1001; // "1"
            4'h2: seg_r = 7'b010_0100; // "2"
            4'h3: seg_r = 7'b011_0000; // "3"
            4'h4: seg_r = 7'b001_1001; // "4"
            4'h5: seg_r = 7'b001_0010; // "5"
            4'h6: seg_r = 7'b000_0010; // "6"
            4'h7: seg_r = 7'b111_1000; // "7"
            4'h8: seg_r = 7'b000_0000; // "8"
            4'h9: seg_r = 7'b001_0000; // "9"
            4'hA: seg_r = 7'b000_1000; // "A" -> mewakili 'w'
            4'hB: seg_r = 7'b000_0011; // "b" -> mewakili 'y'
            4'hC: seg_r = 7'b100_0110; // "C" -> mewakili 'S'
            4'hD: seg_r = 7'b010_0001; // "d" -> mewakili 't'
            default: seg_r = 7'b111_1111; // blank
        endcase
    end

endmodule
