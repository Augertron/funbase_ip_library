
# -----------------------------------------
# Auto-generated simulation script

# -----------------------------------------
# Initialize the variable
if ![info exist SYSTEM_INSTANCE_NAME] { 
   set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
   set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
} 

if ![info exist TOP_LEVEL_NAME] { 
   set TOP_LEVEL_NAME "nios2_a2gx_onchip"
} elseif { ![ string match "" $TOP_LEVEL_NAME ] } { 
   set TOP_LEVEL_NAME "$TOP_LEVEL_NAME"
} 

if ![info exist QSYS_SIMDIR] { 
   set QSYS_SIMDIR "."
} elseif { ![ string match "" $QSYS_SIMDIR ] } { 
   set QSYS_SIMDIR "$QSYS_SIMDIR"
} 


# -----------------------------------------
# Copy ROM/RAM files to simulation directory
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_onchip_mem_0.hex ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_bht_ram.dat ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_bht_ram.hex ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_bht_ram.mif ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_dc_tag_ram.dat ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_dc_tag_ram.hex ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_dc_tag_ram.mif ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_ic_tag_ram.dat ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_ic_tag_ram.hex ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_ic_tag_ram.mif ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_rf_ram_a.dat ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_rf_ram_a.hex ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_rf_ram_a.mif ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_rf_ram_b.dat ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_rf_ram_b.hex ./
file copy -force $QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_rf_ram_b.mif ./

# -----------------------------------------
# Create compilation libraries
vlib work
vmap work work
if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
vlib altera_ver
vmap altera_ver altera_ver
vlib lpm_ver
vmap lpm_ver lpm_ver
vlib sgate_ver
vmap sgate_ver sgate_ver
vlib altera_mf_ver
vmap altera_mf_ver altera_mf_ver
vlib altera_lnsim_ver
vmap altera_lnsim_ver altera_lnsim_ver
vlib arriaii_hssi_ver
vmap arriaii_hssi_ver arriaii_hssi_ver
vlib arriaii_pcie_hip_ver
vmap arriaii_pcie_hip_ver arriaii_pcie_hip_ver
vlib arriaii_ver
vmap arriaii_ver arriaii_ver

}

# -----------------------------------------
# Compile device library files
alias dev_com {
if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
   vlog "C:/altera/11.0/quartus/eda/sim_lib/altera_primitives.v" -work altera_ver
   vlog "C:/altera/11.0/quartus/eda/sim_lib/220model.v" -work lpm_ver
   vlog "C:/altera/11.0/quartus/eda/sim_lib/sgate.v" -work sgate_ver
   vlog "C:/altera/11.0/quartus/eda/sim_lib/altera_mf.v" -work altera_mf_ver
   vlog -sv "C:/altera/11.0/quartus/eda/sim_lib/altera_lnsim.sv" -work altera_lnsim_ver
   vlog "C:/altera/11.0/quartus/eda/sim_lib/arriaii_hssi_atoms.v" -work arriaii_hssi_ver
   vlog "C:/altera/11.0/quartus/eda/sim_lib/arriaii_pcie_hip_atoms.v" -work arriaii_pcie_hip_ver
   vlog "C:/altera/11.0/quartus/eda/sim_lib/arriaii_atoms.v" -work arriaii_ver
}

}

# -----------------------------------------
# Compile the design files in correct order
alias com {
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_irq_mapper.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_rsp_xbar_mux.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_rsp_xbar_demux_001.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_rsp_xbar_demux.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cmd_xbar_mux_001.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cmd_xbar_demux_001.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cmd_xbar_demux.sv"
   vlog "$QSYS_SIMDIR/submodules/altera_reset_controller.v"
   vlog "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"
   vlog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_id_router_001.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_id_router.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_addr_router_001.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_addr_router.sv"
   vlog "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"
   vlog -sv "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_parallel_in.v"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_parallel_out.v"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_onchip_mem_0.v"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_timer.v"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu.vo"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_mult_cell.v"
   vlog "$QSYS_SIMDIR/submodules/nios2_a2gx_onchip_cpu_test_bench.v"
   vlog "$QSYS_SIMDIR/nios2_a2gx_onchip.v"
}

# -----------------------------------------
# Elaborate top level design
alias elab "
vsim -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L arriaii_hssi_ver -L arriaii_pcie_hip_ver -L arriaii_ver $TOP_LEVEL_NAME
"

# -----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug "
vsim -novopt -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L arriaii_hssi_ver -L arriaii_pcie_hip_ver -L arriaii_ver $TOP_LEVEL_NAME
"

# -----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
dev_com
com
elab
"

# -----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
dev_com
com
elab_debug
"

# -----------------------------------------
# Print out user commmand line aliases
alias h {
echo "List Of Command Line Aliases"
echo 
echo "dev_com                       -- Compile device library files"
echo 
echo "com                           -- Compile the design files in correct order"
echo 
echo "elab                          -- Elaborate top level design"
echo 
echo "elab_debug                    -- Elaborate the top level design with novopt option"
echo 
echo "ld                            -- Compile all the design files and elaborate the top level design"
echo 
echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
echo 
echo 
echo 
echo "List Of Variables"
echo 
echo "TOP_LEVEL_NAME                -- Top level module name."
echo 
echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
echo 
echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
}
h
