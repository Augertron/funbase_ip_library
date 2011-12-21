derive_pll_clocks 
derive_clock_uncertainty
create_clock -period "100 MHz" -name {refclk} {refclk}
create_clock -period "125 MHz" -name {pcie_refclk_p} {pcie_refclk_p}
set_clock_groups -exclusive -group [get_clocks { *central_clk_div0* }] -group [get_clocks { *_hssi_pcie_hip* }]
set_clock_groups -exclusive -group [get_clocks { *ddr2_sodimm_x64_phy_inst* }] -group [get_clocks { *_hssi_pcie_hip* }]
