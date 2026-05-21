set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports CLK100MHZ]

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports SW0]

set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports BTNC]
set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports BTND]

set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports LED0]
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports LED2]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports LED3]

set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports {AN[0]}]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports {AN[1]}]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports {AN[2]}]
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports {AN[3]}]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports {AN[4]}]
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports {AN[5]}]
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports {AN[6]}]
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports {AN[7]}]

set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports {SEG[6]}]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports {SEG[5]}]
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports {SEG[1]}]
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports {SEG[2]}]
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports {SEG[3]}]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports {SEG[4]}]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports {SEG[0]}]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLDOWN [current_design]
