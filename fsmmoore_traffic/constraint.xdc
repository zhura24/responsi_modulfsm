# ============================================================
# Constraint File - FSM Moore Traffic Light Controller
# Board: Nexys A7-100T (xc7a100tcsg324-1)
# ============================================================

# --- Clock ---
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];

# --- Reset (BTNC) ---
set_property -dict { PACKAGE_PIN N17  IOSTANDARD LVCMOS33 } [get_ports { rst }];

# --- Input Switch SW0 (w) ---
set_property -dict { PACKAGE_PIN J15  IOSTANDARD LVCMOS33 } [get_ports { w }];

# --- Output LEDs: y[2:0] = {R, Y, G} ---
# LED0 = Green (y[0])
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { y[0] }];
# LED1 = Yellow (y[1])
set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { y[1] }];
# LED2 = Red (y[2])
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { y[2] }];

# --- Seven Segment Display ---
# Segment cathodes (active low)
set_property -dict { PACKAGE_PIN T10  IOSTANDARD LVCMOS33 } [get_ports { seg[0] }]; # a
set_property -dict { PACKAGE_PIN R10  IOSTANDARD LVCMOS33 } [get_ports { seg[1] }]; # b
set_property -dict { PACKAGE_PIN K16  IOSTANDARD LVCMOS33 } [get_ports { seg[2] }]; # c
set_property -dict { PACKAGE_PIN K13  IOSTANDARD LVCMOS33 } [get_ports { seg[3] }]; # d
set_property -dict { PACKAGE_PIN P15  IOSTANDARD LVCMOS33 } [get_ports { seg[4] }]; # e
set_property -dict { PACKAGE_PIN T11  IOSTANDARD LVCMOS33 } [get_ports { seg[5] }]; # f
set_property -dict { PACKAGE_PIN L18  IOSTANDARD LVCMOS33 } [get_ports { seg[6] }]; # g

# Decimal point
set_property -dict { PACKAGE_PIN H15  IOSTANDARD LVCMOS33 } [get_ports { dp }];

# Anode enables (active low) AN7..AN0
set_property -dict { PACKAGE_PIN J17  IOSTANDARD LVCMOS33 } [get_ports { an[7] }];
set_property -dict { PACKAGE_PIN J18  IOSTANDARD LVCMOS33 } [get_ports { an[6] }];
set_property -dict { PACKAGE_PIN T9   IOSTANDARD LVCMOS33 } [get_ports { an[5] }];
set_property -dict { PACKAGE_PIN J14  IOSTANDARD LVCMOS33 } [get_ports { an[4] }];
set_property -dict { PACKAGE_PIN P14  IOSTANDARD LVCMOS33 } [get_ports { an[3] }];
set_property -dict { PACKAGE_PIN T14  IOSTANDARD LVCMOS33 } [get_ports { an[2] }];
set_property -dict { PACKAGE_PIN K2   IOSTANDARD LVCMOS33 } [get_ports { an[1] }];
set_property -dict { PACKAGE_PIN U13  IOSTANDARD LVCMOS33 } [get_ports { an[0] }];

# ============================================================
# Configuration
# ============================================================
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
