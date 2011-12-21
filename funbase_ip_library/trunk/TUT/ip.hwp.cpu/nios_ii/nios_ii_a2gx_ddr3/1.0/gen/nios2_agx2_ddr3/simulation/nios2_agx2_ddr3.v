// nios2_agx2_ddr3.v


`timescale 1 ps / 1 ps
module nios2_agx2_ddr3 (
		input  wire  reset_reset_n, // reset.reset_n
		input  wire  clk_clk        //   clk.clk
	);

	wire          ddr3_128mb_sysclk_clk;                                                                      // ddr3_128MB:phy_clk -> [addr_router:clk, addr_router_001:clk, burst_adapter:clk, burst_adapter_001:clk, burst_adapter_002:clk, cmd_xbar_demux:clk, cmd_xbar_demux_001:clk, cmd_xbar_mux:clk, cmd_xbar_mux_001:clk, cpu:clk, cpu_data_master_translator:clk, cpu_data_master_translator_avalon_universal_master_0_agent:clk, cpu_instruction_master_translator:clk, cpu_instruction_master_translator_avalon_universal_master_0_agent:clk, cpu_jtag_debug_module_translator:clk, cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:clk, cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:clk, ddr3_128MB_s1_translator:clk, ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:clk, ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:clk, ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:clk, id_router:clk, id_router_001:clk, id_router_002:clk, irq_mapper:clk, limiter:clk, limiter_001:clk, rsp_xbar_demux:clk, rsp_xbar_demux_001:clk, rsp_xbar_demux_002:clk, rsp_xbar_mux:clk, rsp_xbar_mux_001:clk, rst_controller:clk, timer:clk, timer_s1_translator:clk, timer_s1_translator_avalon_universal_slave_0_agent:clk, timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:clk, width_adapter:clk, width_adapter_001:clk]
	wire    [3:0] cpu_instruction_master_burstcount;                                                          // cpu:i_burstcount -> cpu_instruction_master_translator:av_burstcount
	wire          cpu_instruction_master_waitrequest;                                                         // cpu_instruction_master_translator:av_waitrequest -> cpu:i_waitrequest
	wire   [27:0] cpu_instruction_master_address;                                                             // cpu:i_address -> cpu_instruction_master_translator:av_address
	wire          cpu_instruction_master_read;                                                                // cpu:i_read -> cpu_instruction_master_translator:av_read
	wire   [31:0] cpu_instruction_master_readdata;                                                            // cpu_instruction_master_translator:av_readdata -> cpu:i_readdata
	wire          cpu_instruction_master_readdatavalid;                                                       // cpu_instruction_master_translator:av_readdatavalid -> cpu:i_readdatavalid
	wire    [3:0] cpu_data_master_burstcount;                                                                 // cpu:d_burstcount -> cpu_data_master_translator:av_burstcount
	wire          cpu_data_master_waitrequest;                                                                // cpu_data_master_translator:av_waitrequest -> cpu:d_waitrequest
	wire   [31:0] cpu_data_master_writedata;                                                                  // cpu:d_writedata -> cpu_data_master_translator:av_writedata
	wire   [27:0] cpu_data_master_address;                                                                    // cpu:d_address -> cpu_data_master_translator:av_address
	wire          cpu_data_master_write;                                                                      // cpu:d_write -> cpu_data_master_translator:av_write
	wire          cpu_data_master_read;                                                                       // cpu:d_read -> cpu_data_master_translator:av_read
	wire   [31:0] cpu_data_master_readdata;                                                                   // cpu_data_master_translator:av_readdata -> cpu:d_readdata
	wire          cpu_data_master_debugaccess;                                                                // cpu:jtag_debug_module_debugaccess_to_roms -> cpu_data_master_translator:av_debugaccess
	wire          cpu_data_master_readdatavalid;                                                              // cpu_data_master_translator:av_readdatavalid -> cpu:d_readdatavalid
	wire    [3:0] cpu_data_master_byteenable;                                                                 // cpu:d_byteenable -> cpu_data_master_translator:av_byteenable
	wire   [31:0] cpu_jtag_debug_module_translator_avalon_anti_slave_0_writedata;                             // cpu_jtag_debug_module_translator:av_writedata -> cpu:jtag_debug_module_writedata
	wire    [8:0] cpu_jtag_debug_module_translator_avalon_anti_slave_0_address;                               // cpu_jtag_debug_module_translator:av_address -> cpu:jtag_debug_module_address
	wire          cpu_jtag_debug_module_translator_avalon_anti_slave_0_chipselect;                            // cpu_jtag_debug_module_translator:av_chipselect -> cpu:jtag_debug_module_select
	wire          cpu_jtag_debug_module_translator_avalon_anti_slave_0_write;                                 // cpu_jtag_debug_module_translator:av_write -> cpu:jtag_debug_module_write
	wire   [31:0] cpu_jtag_debug_module_translator_avalon_anti_slave_0_readdata;                              // cpu:jtag_debug_module_readdata -> cpu_jtag_debug_module_translator:av_readdata
	wire          cpu_jtag_debug_module_translator_avalon_anti_slave_0_begintransfer;                         // cpu_jtag_debug_module_translator:av_begintransfer -> cpu:jtag_debug_module_begintransfer
	wire          cpu_jtag_debug_module_translator_avalon_anti_slave_0_debugaccess;                           // cpu_jtag_debug_module_translator:av_debugaccess -> cpu:jtag_debug_module_debugaccess
	wire    [3:0] cpu_jtag_debug_module_translator_avalon_anti_slave_0_byteenable;                            // cpu_jtag_debug_module_translator:av_byteenable -> cpu:jtag_debug_module_byteenable
	wire          ddr3_128mb_s1_translator_avalon_anti_slave_0_waitrequest;                                   // ddr3_128MB:local_ready -> ddr3_128MB_s1_translator:av_waitrequest
	wire    [2:0] ddr3_128mb_s1_translator_avalon_anti_slave_0_burstcount;                                    // ddr3_128MB_s1_translator:av_burstcount -> ddr3_128MB:local_size
	wire   [63:0] ddr3_128mb_s1_translator_avalon_anti_slave_0_writedata;                                     // ddr3_128MB_s1_translator:av_writedata -> ddr3_128MB:local_wdata
	wire   [23:0] ddr3_128mb_s1_translator_avalon_anti_slave_0_address;                                       // ddr3_128MB_s1_translator:av_address -> ddr3_128MB:local_address
	wire          ddr3_128mb_s1_translator_avalon_anti_slave_0_write;                                         // ddr3_128MB_s1_translator:av_write -> ddr3_128MB:local_write_req
	wire          ddr3_128mb_s1_translator_avalon_anti_slave_0_beginbursttransfer;                            // ddr3_128MB_s1_translator:av_beginbursttransfer -> ddr3_128MB:local_burstbegin
	wire          ddr3_128mb_s1_translator_avalon_anti_slave_0_read;                                          // ddr3_128MB_s1_translator:av_read -> ddr3_128MB:local_read_req
	wire   [63:0] ddr3_128mb_s1_translator_avalon_anti_slave_0_readdata;                                      // ddr3_128MB:local_rdata -> ddr3_128MB_s1_translator:av_readdata
	wire          ddr3_128mb_s1_translator_avalon_anti_slave_0_readdatavalid;                                 // ddr3_128MB:local_rdata_valid -> ddr3_128MB_s1_translator:av_readdatavalid
	wire    [7:0] ddr3_128mb_s1_translator_avalon_anti_slave_0_byteenable;                                    // ddr3_128MB_s1_translator:av_byteenable -> ddr3_128MB:local_be
	wire          ddr3_128mb_reset_request_n_reset;                                                           // ddr3_128MB:reset_request_n -> [burst_adapter_001:reset, cmd_xbar_mux_001:reset, ddr3_128MB_s1_translator:reset, ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:reset, ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:reset, ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, id_router_001:reset, rsp_xbar_demux_001:reset, width_adapter:reset, width_adapter_001:reset]
	wire   [15:0] timer_s1_translator_avalon_anti_slave_0_writedata;                                          // timer_s1_translator:av_writedata -> timer:writedata
	wire    [2:0] timer_s1_translator_avalon_anti_slave_0_address;                                            // timer_s1_translator:av_address -> timer:address
	wire          timer_s1_translator_avalon_anti_slave_0_chipselect;                                         // timer_s1_translator:av_chipselect -> timer:chipselect
	wire          timer_s1_translator_avalon_anti_slave_0_write;                                              // timer_s1_translator:av_write -> timer:write_n
	wire   [15:0] timer_s1_translator_avalon_anti_slave_0_readdata;                                           // timer:readdata -> timer_s1_translator:av_readdata
	wire          cpu_instruction_master_translator_avalon_universal_master_0_waitrequest;                    // cpu_instruction_master_translator_avalon_universal_master_0_agent:av_waitrequest -> cpu_instruction_master_translator:uav_waitrequest
	wire    [5:0] cpu_instruction_master_translator_avalon_universal_master_0_burstcount;                     // cpu_instruction_master_translator:uav_burstcount -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire   [31:0] cpu_instruction_master_translator_avalon_universal_master_0_writedata;                      // cpu_instruction_master_translator:uav_writedata -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_writedata
	wire   [27:0] cpu_instruction_master_translator_avalon_universal_master_0_address;                        // cpu_instruction_master_translator:uav_address -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_address
	wire          cpu_instruction_master_translator_avalon_universal_master_0_lock;                           // cpu_instruction_master_translator:uav_lock -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_lock
	wire          cpu_instruction_master_translator_avalon_universal_master_0_write;                          // cpu_instruction_master_translator:uav_write -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_write
	wire          cpu_instruction_master_translator_avalon_universal_master_0_read;                           // cpu_instruction_master_translator:uav_read -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_read
	wire   [31:0] cpu_instruction_master_translator_avalon_universal_master_0_readdata;                       // cpu_instruction_master_translator_avalon_universal_master_0_agent:av_readdata -> cpu_instruction_master_translator:uav_readdata
	wire          cpu_instruction_master_translator_avalon_universal_master_0_debugaccess;                    // cpu_instruction_master_translator:uav_debugaccess -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire    [3:0] cpu_instruction_master_translator_avalon_universal_master_0_byteenable;                     // cpu_instruction_master_translator:uav_byteenable -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire          cpu_instruction_master_translator_avalon_universal_master_0_readdatavalid;                  // cpu_instruction_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> cpu_instruction_master_translator:uav_readdatavalid
	wire          cpu_data_master_translator_avalon_universal_master_0_waitrequest;                           // cpu_data_master_translator_avalon_universal_master_0_agent:av_waitrequest -> cpu_data_master_translator:uav_waitrequest
	wire    [5:0] cpu_data_master_translator_avalon_universal_master_0_burstcount;                            // cpu_data_master_translator:uav_burstcount -> cpu_data_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire   [31:0] cpu_data_master_translator_avalon_universal_master_0_writedata;                             // cpu_data_master_translator:uav_writedata -> cpu_data_master_translator_avalon_universal_master_0_agent:av_writedata
	wire   [27:0] cpu_data_master_translator_avalon_universal_master_0_address;                               // cpu_data_master_translator:uav_address -> cpu_data_master_translator_avalon_universal_master_0_agent:av_address
	wire          cpu_data_master_translator_avalon_universal_master_0_lock;                                  // cpu_data_master_translator:uav_lock -> cpu_data_master_translator_avalon_universal_master_0_agent:av_lock
	wire          cpu_data_master_translator_avalon_universal_master_0_write;                                 // cpu_data_master_translator:uav_write -> cpu_data_master_translator_avalon_universal_master_0_agent:av_write
	wire          cpu_data_master_translator_avalon_universal_master_0_read;                                  // cpu_data_master_translator:uav_read -> cpu_data_master_translator_avalon_universal_master_0_agent:av_read
	wire   [31:0] cpu_data_master_translator_avalon_universal_master_0_readdata;                              // cpu_data_master_translator_avalon_universal_master_0_agent:av_readdata -> cpu_data_master_translator:uav_readdata
	wire          cpu_data_master_translator_avalon_universal_master_0_debugaccess;                           // cpu_data_master_translator:uav_debugaccess -> cpu_data_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire    [3:0] cpu_data_master_translator_avalon_universal_master_0_byteenable;                            // cpu_data_master_translator:uav_byteenable -> cpu_data_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire          cpu_data_master_translator_avalon_universal_master_0_readdatavalid;                         // cpu_data_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> cpu_data_master_translator:uav_readdatavalid
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_waitrequest;             // cpu_jtag_debug_module_translator:uav_waitrequest -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire    [2:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_burstcount;              // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_burstcount -> cpu_jtag_debug_module_translator:uav_burstcount
	wire   [31:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_writedata;               // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_writedata -> cpu_jtag_debug_module_translator:uav_writedata
	wire   [27:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_address;                 // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_address -> cpu_jtag_debug_module_translator:uav_address
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_write;                   // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_write -> cpu_jtag_debug_module_translator:uav_write
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_lock;                    // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_lock -> cpu_jtag_debug_module_translator:uav_lock
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_read;                    // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_read -> cpu_jtag_debug_module_translator:uav_read
	wire   [31:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdata;                // cpu_jtag_debug_module_translator:uav_readdata -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_readdata
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdatavalid;           // cpu_jtag_debug_module_translator:uav_readdatavalid -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_debugaccess;             // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_debugaccess -> cpu_jtag_debug_module_translator:uav_debugaccess
	wire    [3:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_byteenable;              // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:m0_byteenable -> cpu_jtag_debug_module_translator:uav_byteenable
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;      // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_valid;            // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_valid -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;    // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire   [87:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_data;             // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_data -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_ready;            // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;   // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;         // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket; // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire   [87:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;          // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;         // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rf_sink_ready -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;       // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire   [31:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;        // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;       // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;                     // ddr3_128MB_s1_translator:uav_waitrequest -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire    [5:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;                      // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> ddr3_128MB_s1_translator:uav_burstcount
	wire   [63:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_writedata;                       // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> ddr3_128MB_s1_translator:uav_writedata
	wire   [27:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_address;                         // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_address -> ddr3_128MB_s1_translator:uav_address
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_write;                           // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_write -> ddr3_128MB_s1_translator:uav_write
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_lock;                            // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_lock -> ddr3_128MB_s1_translator:uav_lock
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_read;                            // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_read -> ddr3_128MB_s1_translator:uav_read
	wire   [63:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                        // ddr3_128MB_s1_translator:uav_readdata -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                   // ddr3_128MB_s1_translator:uav_readdatavalid -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;                     // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> ddr3_128MB_s1_translator:uav_debugaccess
	wire    [7:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;                      // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> ddr3_128MB_s1_translator:uav_byteenable
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;              // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;                    // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;            // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [123:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_data;                     // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;                    // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;           // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                 // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;         // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [123:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                  // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                 // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;               // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:in_valid
	wire   [63:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:in_data
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;               // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:in_ready -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid;               // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:out_valid -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire   [63:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data;                // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:out_data -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready;               // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent_rdata_fifo:out_ready
	wire          timer_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;                          // timer_s1_translator:uav_waitrequest -> timer_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire    [2:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;                           // timer_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> timer_s1_translator:uav_burstcount
	wire   [31:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_writedata;                            // timer_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> timer_s1_translator:uav_writedata
	wire   [27:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_address;                              // timer_s1_translator_avalon_universal_slave_0_agent:m0_address -> timer_s1_translator:uav_address
	wire          timer_s1_translator_avalon_universal_slave_0_agent_m0_write;                                // timer_s1_translator_avalon_universal_slave_0_agent:m0_write -> timer_s1_translator:uav_write
	wire          timer_s1_translator_avalon_universal_slave_0_agent_m0_lock;                                 // timer_s1_translator_avalon_universal_slave_0_agent:m0_lock -> timer_s1_translator:uav_lock
	wire          timer_s1_translator_avalon_universal_slave_0_agent_m0_read;                                 // timer_s1_translator_avalon_universal_slave_0_agent:m0_read -> timer_s1_translator:uav_read
	wire   [31:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                             // timer_s1_translator:uav_readdata -> timer_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire          timer_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                        // timer_s1_translator:uav_readdatavalid -> timer_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire          timer_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;                          // timer_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> timer_s1_translator:uav_debugaccess
	wire    [3:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;                           // timer_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> timer_s1_translator:uav_byteenable
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;                   // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;                         // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;                 // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire   [87:0] timer_s1_translator_avalon_universal_slave_0_agent_rf_source_data;                          // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;                         // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> timer_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;                // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                      // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;              // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire   [87:0] timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                       // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                      // timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;                    // timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire   [31:0] timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;                     // timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;                    // timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire          cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket;           // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire          cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_valid;                 // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire          cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket;         // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire   [86:0] cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_data;                  // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire          cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_ready;                 // addr_router:sink_ready -> cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_ready
	wire          cpu_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket;                  // cpu_data_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router_001:sink_endofpacket
	wire          cpu_data_master_translator_avalon_universal_master_0_agent_cp_valid;                        // cpu_data_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router_001:sink_valid
	wire          cpu_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket;                // cpu_data_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router_001:sink_startofpacket
	wire   [86:0] cpu_data_master_translator_avalon_universal_master_0_agent_cp_data;                         // cpu_data_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router_001:sink_data
	wire          cpu_data_master_translator_avalon_universal_master_0_agent_cp_ready;                        // addr_router_001:sink_ready -> cpu_data_master_translator_avalon_universal_master_0_agent:cp_ready
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_endofpacket;             // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_valid;                   // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_startofpacket;           // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire   [86:0] cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_data;                    // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire          cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_ready;                   // id_router:sink_ready -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:rp_ready
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;                     // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_valid;                           // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;                   // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [122:0] ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_data;                            // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire          ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_ready;                           // id_router_001:sink_ready -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;                          // timer_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_002:sink_endofpacket
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rp_valid;                                // timer_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_002:sink_valid
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;                        // timer_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_002:sink_startofpacket
	wire   [86:0] timer_s1_translator_avalon_universal_slave_0_agent_rp_data;                                 // timer_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router_002:sink_data
	wire          timer_s1_translator_avalon_universal_slave_0_agent_rp_ready;                                // id_router_002:sink_ready -> timer_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire          addr_router_src_endofpacket;                                                                // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire          addr_router_src_valid;                                                                      // addr_router:src_valid -> limiter:cmd_sink_valid
	wire          addr_router_src_startofpacket;                                                              // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire   [86:0] addr_router_src_data;                                                                       // addr_router:src_data -> limiter:cmd_sink_data
	wire    [2:0] addr_router_src_channel;                                                                    // addr_router:src_channel -> limiter:cmd_sink_channel
	wire          addr_router_src_ready;                                                                      // limiter:cmd_sink_ready -> addr_router:src_ready
	wire          limiter_rsp_src_endofpacket;                                                                // limiter:rsp_src_endofpacket -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire          limiter_rsp_src_valid;                                                                      // limiter:rsp_src_valid -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_valid
	wire          limiter_rsp_src_startofpacket;                                                              // limiter:rsp_src_startofpacket -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire   [86:0] limiter_rsp_src_data;                                                                       // limiter:rsp_src_data -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_data
	wire    [2:0] limiter_rsp_src_channel;                                                                    // limiter:rsp_src_channel -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_channel
	wire          limiter_rsp_src_ready;                                                                      // cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire          addr_router_001_src_endofpacket;                                                            // addr_router_001:src_endofpacket -> limiter_001:cmd_sink_endofpacket
	wire          addr_router_001_src_valid;                                                                  // addr_router_001:src_valid -> limiter_001:cmd_sink_valid
	wire          addr_router_001_src_startofpacket;                                                          // addr_router_001:src_startofpacket -> limiter_001:cmd_sink_startofpacket
	wire   [86:0] addr_router_001_src_data;                                                                   // addr_router_001:src_data -> limiter_001:cmd_sink_data
	wire    [2:0] addr_router_001_src_channel;                                                                // addr_router_001:src_channel -> limiter_001:cmd_sink_channel
	wire          addr_router_001_src_ready;                                                                  // limiter_001:cmd_sink_ready -> addr_router_001:src_ready
	wire          limiter_001_rsp_src_endofpacket;                                                            // limiter_001:rsp_src_endofpacket -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire          limiter_001_rsp_src_valid;                                                                  // limiter_001:rsp_src_valid -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_valid
	wire          limiter_001_rsp_src_startofpacket;                                                          // limiter_001:rsp_src_startofpacket -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire   [86:0] limiter_001_rsp_src_data;                                                                   // limiter_001:rsp_src_data -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_data
	wire    [2:0] limiter_001_rsp_src_channel;                                                                // limiter_001:rsp_src_channel -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_channel
	wire          limiter_001_rsp_src_ready;                                                                  // cpu_data_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter_001:rsp_src_ready
	wire          burst_adapter_source0_endofpacket;                                                          // burst_adapter:source0_endofpacket -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire          burst_adapter_source0_valid;                                                                // burst_adapter:source0_valid -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_valid
	wire          burst_adapter_source0_startofpacket;                                                        // burst_adapter:source0_startofpacket -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire   [86:0] burst_adapter_source0_data;                                                                 // burst_adapter:source0_data -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_data
	wire          burst_adapter_source0_ready;                                                                // cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter:source0_ready
	wire    [2:0] burst_adapter_source0_channel;                                                              // burst_adapter:source0_channel -> cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:cp_channel
	wire          burst_adapter_001_source0_endofpacket;                                                      // burst_adapter_001:source0_endofpacket -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire          burst_adapter_001_source0_valid;                                                            // burst_adapter_001:source0_valid -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire          burst_adapter_001_source0_startofpacket;                                                    // burst_adapter_001:source0_startofpacket -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [122:0] burst_adapter_001_source0_data;                                                             // burst_adapter_001:source0_data -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire          burst_adapter_001_source0_ready;                                                            // ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter_001:source0_ready
	wire    [2:0] burst_adapter_001_source0_channel;                                                          // burst_adapter_001:source0_channel -> ddr3_128MB_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire          burst_adapter_002_source0_endofpacket;                                                      // burst_adapter_002:source0_endofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire          burst_adapter_002_source0_valid;                                                            // burst_adapter_002:source0_valid -> timer_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire          burst_adapter_002_source0_startofpacket;                                                    // burst_adapter_002:source0_startofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire   [86:0] burst_adapter_002_source0_data;                                                             // burst_adapter_002:source0_data -> timer_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire          burst_adapter_002_source0_ready;                                                            // timer_s1_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter_002:source0_ready
	wire    [2:0] burst_adapter_002_source0_channel;                                                          // burst_adapter_002:source0_channel -> timer_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire          rst_controller_reset_out_reset;                                                             // rst_controller:reset_out -> [addr_router:reset, addr_router_001:reset, burst_adapter:reset, burst_adapter_002:reset, cmd_xbar_demux:reset, cmd_xbar_demux_001:reset, cmd_xbar_mux:reset, cpu:reset_n, cpu_data_master_translator:reset, cpu_data_master_translator_avalon_universal_master_0_agent:reset, cpu_instruction_master_translator:reset, cpu_instruction_master_translator_avalon_universal_master_0_agent:reset, cpu_jtag_debug_module_translator:reset, cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent:reset, cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, id_router:reset, id_router_002:reset, irq_mapper:reset, limiter:reset, limiter_001:reset, rsp_xbar_demux:reset, rsp_xbar_demux_002:reset, rsp_xbar_mux:reset, rsp_xbar_mux_001:reset, timer:reset_n, timer_s1_translator:reset, timer_s1_translator_avalon_universal_slave_0_agent:reset, timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset]
	wire          rst_controller_001_reset_out_reset;                                                         // rst_controller_001:reset_out -> [ddr3_128MB:global_reset_n, ddr3_128MB:soft_reset_n]
	wire          cmd_xbar_demux_src0_endofpacket;                                                            // cmd_xbar_demux:src0_endofpacket -> cmd_xbar_mux:sink0_endofpacket
	wire          cmd_xbar_demux_src0_valid;                                                                  // cmd_xbar_demux:src0_valid -> cmd_xbar_mux:sink0_valid
	wire          cmd_xbar_demux_src0_startofpacket;                                                          // cmd_xbar_demux:src0_startofpacket -> cmd_xbar_mux:sink0_startofpacket
	wire   [86:0] cmd_xbar_demux_src0_data;                                                                   // cmd_xbar_demux:src0_data -> cmd_xbar_mux:sink0_data
	wire    [2:0] cmd_xbar_demux_src0_channel;                                                                // cmd_xbar_demux:src0_channel -> cmd_xbar_mux:sink0_channel
	wire          cmd_xbar_demux_src0_ready;                                                                  // cmd_xbar_mux:sink0_ready -> cmd_xbar_demux:src0_ready
	wire          cmd_xbar_demux_src1_endofpacket;                                                            // cmd_xbar_demux:src1_endofpacket -> cmd_xbar_mux_001:sink0_endofpacket
	wire          cmd_xbar_demux_src1_valid;                                                                  // cmd_xbar_demux:src1_valid -> cmd_xbar_mux_001:sink0_valid
	wire          cmd_xbar_demux_src1_startofpacket;                                                          // cmd_xbar_demux:src1_startofpacket -> cmd_xbar_mux_001:sink0_startofpacket
	wire   [86:0] cmd_xbar_demux_src1_data;                                                                   // cmd_xbar_demux:src1_data -> cmd_xbar_mux_001:sink0_data
	wire    [2:0] cmd_xbar_demux_src1_channel;                                                                // cmd_xbar_demux:src1_channel -> cmd_xbar_mux_001:sink0_channel
	wire          cmd_xbar_demux_src1_ready;                                                                  // cmd_xbar_mux_001:sink0_ready -> cmd_xbar_demux:src1_ready
	wire          cmd_xbar_demux_001_src0_endofpacket;                                                        // cmd_xbar_demux_001:src0_endofpacket -> cmd_xbar_mux:sink1_endofpacket
	wire          cmd_xbar_demux_001_src0_valid;                                                              // cmd_xbar_demux_001:src0_valid -> cmd_xbar_mux:sink1_valid
	wire          cmd_xbar_demux_001_src0_startofpacket;                                                      // cmd_xbar_demux_001:src0_startofpacket -> cmd_xbar_mux:sink1_startofpacket
	wire   [86:0] cmd_xbar_demux_001_src0_data;                                                               // cmd_xbar_demux_001:src0_data -> cmd_xbar_mux:sink1_data
	wire    [2:0] cmd_xbar_demux_001_src0_channel;                                                            // cmd_xbar_demux_001:src0_channel -> cmd_xbar_mux:sink1_channel
	wire          cmd_xbar_demux_001_src0_ready;                                                              // cmd_xbar_mux:sink1_ready -> cmd_xbar_demux_001:src0_ready
	wire          cmd_xbar_demux_001_src1_endofpacket;                                                        // cmd_xbar_demux_001:src1_endofpacket -> cmd_xbar_mux_001:sink1_endofpacket
	wire          cmd_xbar_demux_001_src1_valid;                                                              // cmd_xbar_demux_001:src1_valid -> cmd_xbar_mux_001:sink1_valid
	wire          cmd_xbar_demux_001_src1_startofpacket;                                                      // cmd_xbar_demux_001:src1_startofpacket -> cmd_xbar_mux_001:sink1_startofpacket
	wire   [86:0] cmd_xbar_demux_001_src1_data;                                                               // cmd_xbar_demux_001:src1_data -> cmd_xbar_mux_001:sink1_data
	wire    [2:0] cmd_xbar_demux_001_src1_channel;                                                            // cmd_xbar_demux_001:src1_channel -> cmd_xbar_mux_001:sink1_channel
	wire          cmd_xbar_demux_001_src1_ready;                                                              // cmd_xbar_mux_001:sink1_ready -> cmd_xbar_demux_001:src1_ready
	wire          cmd_xbar_demux_001_src2_endofpacket;                                                        // cmd_xbar_demux_001:src2_endofpacket -> burst_adapter_002:sink0_endofpacket
	wire          cmd_xbar_demux_001_src2_valid;                                                              // cmd_xbar_demux_001:src2_valid -> burst_adapter_002:sink0_valid
	wire          cmd_xbar_demux_001_src2_startofpacket;                                                      // cmd_xbar_demux_001:src2_startofpacket -> burst_adapter_002:sink0_startofpacket
	wire   [86:0] cmd_xbar_demux_001_src2_data;                                                               // cmd_xbar_demux_001:src2_data -> burst_adapter_002:sink0_data
	wire    [2:0] cmd_xbar_demux_001_src2_channel;                                                            // cmd_xbar_demux_001:src2_channel -> burst_adapter_002:sink0_channel
	wire          rsp_xbar_demux_src0_endofpacket;                                                            // rsp_xbar_demux:src0_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire          rsp_xbar_demux_src0_valid;                                                                  // rsp_xbar_demux:src0_valid -> rsp_xbar_mux:sink0_valid
	wire          rsp_xbar_demux_src0_startofpacket;                                                          // rsp_xbar_demux:src0_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire   [86:0] rsp_xbar_demux_src0_data;                                                                   // rsp_xbar_demux:src0_data -> rsp_xbar_mux:sink0_data
	wire    [2:0] rsp_xbar_demux_src0_channel;                                                                // rsp_xbar_demux:src0_channel -> rsp_xbar_mux:sink0_channel
	wire          rsp_xbar_demux_src0_ready;                                                                  // rsp_xbar_mux:sink0_ready -> rsp_xbar_demux:src0_ready
	wire          rsp_xbar_demux_src1_endofpacket;                                                            // rsp_xbar_demux:src1_endofpacket -> rsp_xbar_mux_001:sink0_endofpacket
	wire          rsp_xbar_demux_src1_valid;                                                                  // rsp_xbar_demux:src1_valid -> rsp_xbar_mux_001:sink0_valid
	wire          rsp_xbar_demux_src1_startofpacket;                                                          // rsp_xbar_demux:src1_startofpacket -> rsp_xbar_mux_001:sink0_startofpacket
	wire   [86:0] rsp_xbar_demux_src1_data;                                                                   // rsp_xbar_demux:src1_data -> rsp_xbar_mux_001:sink0_data
	wire    [2:0] rsp_xbar_demux_src1_channel;                                                                // rsp_xbar_demux:src1_channel -> rsp_xbar_mux_001:sink0_channel
	wire          rsp_xbar_demux_src1_ready;                                                                  // rsp_xbar_mux_001:sink0_ready -> rsp_xbar_demux:src1_ready
	wire          rsp_xbar_demux_001_src0_endofpacket;                                                        // rsp_xbar_demux_001:src0_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire          rsp_xbar_demux_001_src0_valid;                                                              // rsp_xbar_demux_001:src0_valid -> rsp_xbar_mux:sink1_valid
	wire          rsp_xbar_demux_001_src0_startofpacket;                                                      // rsp_xbar_demux_001:src0_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire   [86:0] rsp_xbar_demux_001_src0_data;                                                               // rsp_xbar_demux_001:src0_data -> rsp_xbar_mux:sink1_data
	wire    [2:0] rsp_xbar_demux_001_src0_channel;                                                            // rsp_xbar_demux_001:src0_channel -> rsp_xbar_mux:sink1_channel
	wire          rsp_xbar_demux_001_src0_ready;                                                              // rsp_xbar_mux:sink1_ready -> rsp_xbar_demux_001:src0_ready
	wire          rsp_xbar_demux_001_src1_endofpacket;                                                        // rsp_xbar_demux_001:src1_endofpacket -> rsp_xbar_mux_001:sink1_endofpacket
	wire          rsp_xbar_demux_001_src1_valid;                                                              // rsp_xbar_demux_001:src1_valid -> rsp_xbar_mux_001:sink1_valid
	wire          rsp_xbar_demux_001_src1_startofpacket;                                                      // rsp_xbar_demux_001:src1_startofpacket -> rsp_xbar_mux_001:sink1_startofpacket
	wire   [86:0] rsp_xbar_demux_001_src1_data;                                                               // rsp_xbar_demux_001:src1_data -> rsp_xbar_mux_001:sink1_data
	wire    [2:0] rsp_xbar_demux_001_src1_channel;                                                            // rsp_xbar_demux_001:src1_channel -> rsp_xbar_mux_001:sink1_channel
	wire          rsp_xbar_demux_001_src1_ready;                                                              // rsp_xbar_mux_001:sink1_ready -> rsp_xbar_demux_001:src1_ready
	wire          rsp_xbar_demux_002_src0_endofpacket;                                                        // rsp_xbar_demux_002:src0_endofpacket -> rsp_xbar_mux_001:sink2_endofpacket
	wire          rsp_xbar_demux_002_src0_valid;                                                              // rsp_xbar_demux_002:src0_valid -> rsp_xbar_mux_001:sink2_valid
	wire          rsp_xbar_demux_002_src0_startofpacket;                                                      // rsp_xbar_demux_002:src0_startofpacket -> rsp_xbar_mux_001:sink2_startofpacket
	wire   [86:0] rsp_xbar_demux_002_src0_data;                                                               // rsp_xbar_demux_002:src0_data -> rsp_xbar_mux_001:sink2_data
	wire    [2:0] rsp_xbar_demux_002_src0_channel;                                                            // rsp_xbar_demux_002:src0_channel -> rsp_xbar_mux_001:sink2_channel
	wire          rsp_xbar_demux_002_src0_ready;                                                              // rsp_xbar_mux_001:sink2_ready -> rsp_xbar_demux_002:src0_ready
	wire          limiter_cmd_src_endofpacket;                                                                // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire          limiter_cmd_src_startofpacket;                                                              // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire   [86:0] limiter_cmd_src_data;                                                                       // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire    [2:0] limiter_cmd_src_channel;                                                                    // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire          limiter_cmd_src_ready;                                                                      // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire          rsp_xbar_mux_src_endofpacket;                                                               // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire          rsp_xbar_mux_src_valid;                                                                     // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire          rsp_xbar_mux_src_startofpacket;                                                             // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire   [86:0] rsp_xbar_mux_src_data;                                                                      // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire    [2:0] rsp_xbar_mux_src_channel;                                                                   // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire          rsp_xbar_mux_src_ready;                                                                     // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire          limiter_001_cmd_src_endofpacket;                                                            // limiter_001:cmd_src_endofpacket -> cmd_xbar_demux_001:sink_endofpacket
	wire          limiter_001_cmd_src_startofpacket;                                                          // limiter_001:cmd_src_startofpacket -> cmd_xbar_demux_001:sink_startofpacket
	wire   [86:0] limiter_001_cmd_src_data;                                                                   // limiter_001:cmd_src_data -> cmd_xbar_demux_001:sink_data
	wire    [2:0] limiter_001_cmd_src_channel;                                                                // limiter_001:cmd_src_channel -> cmd_xbar_demux_001:sink_channel
	wire          limiter_001_cmd_src_ready;                                                                  // cmd_xbar_demux_001:sink_ready -> limiter_001:cmd_src_ready
	wire          rsp_xbar_mux_001_src_endofpacket;                                                           // rsp_xbar_mux_001:src_endofpacket -> limiter_001:rsp_sink_endofpacket
	wire          rsp_xbar_mux_001_src_valid;                                                                 // rsp_xbar_mux_001:src_valid -> limiter_001:rsp_sink_valid
	wire          rsp_xbar_mux_001_src_startofpacket;                                                         // rsp_xbar_mux_001:src_startofpacket -> limiter_001:rsp_sink_startofpacket
	wire   [86:0] rsp_xbar_mux_001_src_data;                                                                  // rsp_xbar_mux_001:src_data -> limiter_001:rsp_sink_data
	wire    [2:0] rsp_xbar_mux_001_src_channel;                                                               // rsp_xbar_mux_001:src_channel -> limiter_001:rsp_sink_channel
	wire          rsp_xbar_mux_001_src_ready;                                                                 // limiter_001:rsp_sink_ready -> rsp_xbar_mux_001:src_ready
	wire          cmd_xbar_mux_src_endofpacket;                                                               // cmd_xbar_mux:src_endofpacket -> burst_adapter:sink0_endofpacket
	wire          cmd_xbar_mux_src_valid;                                                                     // cmd_xbar_mux:src_valid -> burst_adapter:sink0_valid
	wire          cmd_xbar_mux_src_startofpacket;                                                             // cmd_xbar_mux:src_startofpacket -> burst_adapter:sink0_startofpacket
	wire   [86:0] cmd_xbar_mux_src_data;                                                                      // cmd_xbar_mux:src_data -> burst_adapter:sink0_data
	wire    [2:0] cmd_xbar_mux_src_channel;                                                                   // cmd_xbar_mux:src_channel -> burst_adapter:sink0_channel
	wire          cmd_xbar_mux_src_ready;                                                                     // burst_adapter:sink0_ready -> cmd_xbar_mux:src_ready
	wire          id_router_src_endofpacket;                                                                  // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire          id_router_src_valid;                                                                        // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire          id_router_src_startofpacket;                                                                // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire   [86:0] id_router_src_data;                                                                         // id_router:src_data -> rsp_xbar_demux:sink_data
	wire    [2:0] id_router_src_channel;                                                                      // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire          id_router_src_ready;                                                                        // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire          cmd_xbar_demux_001_src2_ready;                                                              // burst_adapter_002:sink0_ready -> cmd_xbar_demux_001:src2_ready
	wire          id_router_002_src_endofpacket;                                                              // id_router_002:src_endofpacket -> rsp_xbar_demux_002:sink_endofpacket
	wire          id_router_002_src_valid;                                                                    // id_router_002:src_valid -> rsp_xbar_demux_002:sink_valid
	wire          id_router_002_src_startofpacket;                                                            // id_router_002:src_startofpacket -> rsp_xbar_demux_002:sink_startofpacket
	wire   [86:0] id_router_002_src_data;                                                                     // id_router_002:src_data -> rsp_xbar_demux_002:sink_data
	wire    [2:0] id_router_002_src_channel;                                                                  // id_router_002:src_channel -> rsp_xbar_demux_002:sink_channel
	wire          id_router_002_src_ready;                                                                    // rsp_xbar_demux_002:sink_ready -> id_router_002:src_ready
	wire          cmd_xbar_mux_001_src_endofpacket;                                                           // cmd_xbar_mux_001:src_endofpacket -> width_adapter:in_endofpacket
	wire          cmd_xbar_mux_001_src_valid;                                                                 // cmd_xbar_mux_001:src_valid -> width_adapter:in_valid
	wire          cmd_xbar_mux_001_src_startofpacket;                                                         // cmd_xbar_mux_001:src_startofpacket -> width_adapter:in_startofpacket
	wire   [86:0] cmd_xbar_mux_001_src_data;                                                                  // cmd_xbar_mux_001:src_data -> width_adapter:in_data
	wire    [2:0] cmd_xbar_mux_001_src_channel;                                                               // cmd_xbar_mux_001:src_channel -> width_adapter:in_channel
	wire          cmd_xbar_mux_001_src_ready;                                                                 // width_adapter:in_ready -> cmd_xbar_mux_001:src_ready
	wire          width_adapter_src_endofpacket;                                                              // width_adapter:out_endofpacket -> burst_adapter_001:sink0_endofpacket
	wire          width_adapter_src_valid;                                                                    // width_adapter:out_valid -> burst_adapter_001:sink0_valid
	wire          width_adapter_src_startofpacket;                                                            // width_adapter:out_startofpacket -> burst_adapter_001:sink0_startofpacket
	wire  [122:0] width_adapter_src_data;                                                                     // width_adapter:out_data -> burst_adapter_001:sink0_data
	wire          width_adapter_src_ready;                                                                    // burst_adapter_001:sink0_ready -> width_adapter:out_ready
	wire    [2:0] width_adapter_src_channel;                                                                  // width_adapter:out_channel -> burst_adapter_001:sink0_channel
	wire          id_router_001_src_endofpacket;                                                              // id_router_001:src_endofpacket -> width_adapter_001:in_endofpacket
	wire          id_router_001_src_valid;                                                                    // id_router_001:src_valid -> width_adapter_001:in_valid
	wire          id_router_001_src_startofpacket;                                                            // id_router_001:src_startofpacket -> width_adapter_001:in_startofpacket
	wire  [122:0] id_router_001_src_data;                                                                     // id_router_001:src_data -> width_adapter_001:in_data
	wire    [2:0] id_router_001_src_channel;                                                                  // id_router_001:src_channel -> width_adapter_001:in_channel
	wire          id_router_001_src_ready;                                                                    // width_adapter_001:in_ready -> id_router_001:src_ready
	wire          width_adapter_001_src_endofpacket;                                                          // width_adapter_001:out_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire          width_adapter_001_src_valid;                                                                // width_adapter_001:out_valid -> rsp_xbar_demux_001:sink_valid
	wire          width_adapter_001_src_startofpacket;                                                        // width_adapter_001:out_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire   [86:0] width_adapter_001_src_data;                                                                 // width_adapter_001:out_data -> rsp_xbar_demux_001:sink_data
	wire          width_adapter_001_src_ready;                                                                // rsp_xbar_demux_001:sink_ready -> width_adapter_001:out_ready
	wire    [2:0] width_adapter_001_src_channel;                                                              // width_adapter_001:out_channel -> rsp_xbar_demux_001:sink_channel
	wire    [2:0] limiter_cmd_valid_data;                                                                     // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid
	wire    [2:0] limiter_001_cmd_valid_data;                                                                 // limiter_001:cmd_src_valid -> cmd_xbar_demux_001:sink_valid
	wire   [31:0] cpu_d_irq_irq;                                                                              // irq_mapper:sender_irq -> cpu:d_irq

	nios2_agx2_ddr3_cpu cpu (
		.clk                                   (ddr3_128mb_sysclk_clk),                                              //                       clk.clk
		.reset_n                               (~rst_controller_reset_out_reset),                                    //                   reset_n.reset_n
		.d_address                             (cpu_data_master_address),                                            //               data_master.address
		.d_byteenable                          (cpu_data_master_byteenable),                                         //                          .byteenable
		.d_read                                (cpu_data_master_read),                                               //                          .read
		.d_readdata                            (cpu_data_master_readdata),                                           //                          .readdata
		.d_waitrequest                         (cpu_data_master_waitrequest),                                        //                          .waitrequest
		.d_write                               (cpu_data_master_write),                                              //                          .write
		.d_writedata                           (cpu_data_master_writedata),                                          //                          .writedata
		.d_burstcount                          (cpu_data_master_burstcount),                                         //                          .burstcount
		.d_readdatavalid                       (cpu_data_master_readdatavalid),                                      //                          .readdatavalid
		.jtag_debug_module_debugaccess_to_roms (cpu_data_master_debugaccess),                                        //                          .debugaccess
		.i_address                             (cpu_instruction_master_address),                                     //        instruction_master.address
		.i_read                                (cpu_instruction_master_read),                                        //                          .read
		.i_readdata                            (cpu_instruction_master_readdata),                                    //                          .readdata
		.i_waitrequest                         (cpu_instruction_master_waitrequest),                                 //                          .waitrequest
		.i_burstcount                          (cpu_instruction_master_burstcount),                                  //                          .burstcount
		.i_readdatavalid                       (cpu_instruction_master_readdatavalid),                               //                          .readdatavalid
		.d_irq                                 (cpu_d_irq_irq),                                                      //                     d_irq.irq
		.jtag_debug_module_resetrequest        (),                                                                   //   jtag_debug_module_reset.reset
		.jtag_debug_module_address             (cpu_jtag_debug_module_translator_avalon_anti_slave_0_address),       //         jtag_debug_module.address
		.jtag_debug_module_begintransfer       (cpu_jtag_debug_module_translator_avalon_anti_slave_0_begintransfer), //                          .begintransfer
		.jtag_debug_module_byteenable          (cpu_jtag_debug_module_translator_avalon_anti_slave_0_byteenable),    //                          .byteenable
		.jtag_debug_module_debugaccess         (cpu_jtag_debug_module_translator_avalon_anti_slave_0_debugaccess),   //                          .debugaccess
		.jtag_debug_module_readdata            (cpu_jtag_debug_module_translator_avalon_anti_slave_0_readdata),      //                          .readdata
		.jtag_debug_module_select              (cpu_jtag_debug_module_translator_avalon_anti_slave_0_chipselect),    //                          .chipselect
		.jtag_debug_module_write               (cpu_jtag_debug_module_translator_avalon_anti_slave_0_write),         //                          .write
		.jtag_debug_module_writedata           (cpu_jtag_debug_module_translator_avalon_anti_slave_0_writedata),     //                          .writedata
		.no_ci_readra                          ()                                                                    // custom_instruction_master.readra
	);

	nios2_agx2_ddr3_ddr3_128MB ddr3_128mb (
		.local_address         (ddr3_128mb_s1_translator_avalon_anti_slave_0_address),            //                  s1.address
		.local_write_req       (ddr3_128mb_s1_translator_avalon_anti_slave_0_write),              //                    .write
		.local_read_req        (ddr3_128mb_s1_translator_avalon_anti_slave_0_read),               //                    .read
		.local_burstbegin      (ddr3_128mb_s1_translator_avalon_anti_slave_0_beginbursttransfer), //                    .beginbursttransfer
		.local_ready           (ddr3_128mb_s1_translator_avalon_anti_slave_0_waitrequest),        //                    .waitrequest_n
		.local_rdata           (ddr3_128mb_s1_translator_avalon_anti_slave_0_readdata),           //                    .readdata
		.local_rdata_valid     (ddr3_128mb_s1_translator_avalon_anti_slave_0_readdatavalid),      //                    .readdatavalid
		.local_wdata           (ddr3_128mb_s1_translator_avalon_anti_slave_0_writedata),          //                    .writedata
		.local_be              (ddr3_128mb_s1_translator_avalon_anti_slave_0_byteenable),         //                    .byteenable
		.local_size            (ddr3_128mb_s1_translator_avalon_anti_slave_0_burstcount),         //                    .burstcount
		.local_refresh_ack     (),                                                                // external_connection.export
		.local_init_done       (),                                                                //                    .export
		.reset_phy_clk_n       (),                                                                //                    .export
		.dll_reference_clk     (),                                                                //                    .export
		.dqs_delay_ctrl_export (),                                                                //                    .export
		.mem_odt               (),                                                                //              memory.mem_odt
		.mem_clk               (),                                                                //                    .mem_clk
		.mem_clk_n             (),                                                                //                    .mem_clk_n
		.mem_cs_n              (),                                                                //                    .mem_cs_n
		.mem_cke               (),                                                                //                    .mem_cke
		.mem_addr              (),                                                                //                    .mem_addr
		.mem_ba                (),                                                                //                    .mem_ba
		.mem_ras_n             (),                                                                //                    .mem_ras_n
		.mem_cas_n             (),                                                                //                    .mem_cas_n
		.mem_we_n              (),                                                                //                    .mem_we_n
		.mem_dq                (),                                                                //                    .mem_dq
		.mem_dqs               (),                                                                //                    .mem_dqs
		.mem_dqsn              (),                                                                //                    .mem_dqsn
		.mem_dm                (),                                                                //                    .mem_dm
		.mem_reset_n           (),                                                                //                    .mem_reset_n
		.pll_ref_clk           (clk_clk),                                                         //              refclk.clk
		.soft_reset_n          (~rst_controller_001_reset_out_reset),                             //        soft_reset_n.reset_n
		.global_reset_n        (~rst_controller_001_reset_out_reset),                             //      global_reset_n.reset_n
		.reset_request_n       (ddr3_128mb_reset_request_n_reset),                                //     reset_request_n.reset_n
		.phy_clk               (ddr3_128mb_sysclk_clk),                                           //              sysclk.clk
		.aux_full_rate_clk     (),                                                                //             auxfull.clk
		.aux_half_rate_clk     ()                                                                 //             auxhalf.clk
	);

	nios2_agx2_ddr3_timer timer (
		.clk        (ddr3_128mb_sysclk_clk),                              //   clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                    // reset.reset_n
		.address    (timer_s1_translator_avalon_anti_slave_0_address),    //    s1.address
		.writedata  (timer_s1_translator_avalon_anti_slave_0_writedata),  //      .writedata
		.readdata   (timer_s1_translator_avalon_anti_slave_0_readdata),   //      .readdata
		.chipselect (timer_s1_translator_avalon_anti_slave_0_chipselect), //      .chipselect
		.write_n    (~timer_s1_translator_avalon_anti_slave_0_write),     //      .write_n
		.irq        ()                                                    //   irq.irq
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (28),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (4),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (28),
		.UAV_BURSTCOUNT_W            (6),
		.USE_READ                    (1),
		.USE_WRITE                   (0),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (1),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) cpu_instruction_master_translator (
		.clk                   (ddr3_128mb_sysclk_clk),                                                     //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                            //                     reset.reset
		.uav_address           (cpu_instruction_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (cpu_instruction_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (cpu_instruction_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (cpu_instruction_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (cpu_instruction_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (cpu_instruction_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (cpu_instruction_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (cpu_instruction_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (cpu_instruction_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (cpu_instruction_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (cpu_instruction_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (cpu_instruction_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (cpu_instruction_master_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (cpu_instruction_master_burstcount),                                         //                          .burstcount
		.av_read               (cpu_instruction_master_read),                                               //                          .read
		.av_readdata           (cpu_instruction_master_readdata),                                           //                          .readdata
		.av_readdatavalid      (cpu_instruction_master_readdatavalid),                                      //                          .readdatavalid
		.av_byteenable         (4'b1111),                                                                   //               (terminated)
		.av_beginbursttransfer (1'b0),                                                                      //               (terminated)
		.av_begintransfer      (1'b0),                                                                      //               (terminated)
		.av_chipselect         (1'b0),                                                                      //               (terminated)
		.av_write              (1'b0),                                                                      //               (terminated)
		.av_writedata          (32'b00000000000000000000000000000000),                                      //               (terminated)
		.av_lock               (1'b0),                                                                      //               (terminated)
		.av_debugaccess        (1'b0),                                                                      //               (terminated)
		.uav_clken             (),                                                                          //               (terminated)
		.av_clken              (1'b1)                                                                       //               (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (28),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (4),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (28),
		.UAV_BURSTCOUNT_W            (6),
		.USE_READ                    (1),
		.USE_WRITE                   (1),
		.USE_BEGINBURSTTRANSFER      (0),
		.USE_BEGINTRANSFER           (0),
		.USE_CHIPSELECT              (0),
		.USE_BURSTCOUNT              (1),
		.USE_READDATAVALID           (1),
		.USE_WAITREQUEST             (1),
		.AV_SYMBOLS_PER_WORD         (4),
		.AV_ADDRESS_SYMBOLS          (1),
		.AV_BURSTCOUNT_SYMBOLS       (0),
		.AV_CONSTANT_BURST_BEHAVIOR  (1),
		.UAV_CONSTANT_BURST_BEHAVIOR (0),
		.AV_LINEWRAPBURSTS           (0),
		.AV_REGISTERINCOMINGSIGNALS  (0)
	) cpu_data_master_translator (
		.clk                   (ddr3_128mb_sysclk_clk),                                              //                       clk.clk
		.reset                 (rst_controller_reset_out_reset),                                     //                     reset.reset
		.uav_address           (cpu_data_master_translator_avalon_universal_master_0_address),       // avalon_universal_master_0.address
		.uav_burstcount        (cpu_data_master_translator_avalon_universal_master_0_burstcount),    //                          .burstcount
		.uav_read              (cpu_data_master_translator_avalon_universal_master_0_read),          //                          .read
		.uav_write             (cpu_data_master_translator_avalon_universal_master_0_write),         //                          .write
		.uav_waitrequest       (cpu_data_master_translator_avalon_universal_master_0_waitrequest),   //                          .waitrequest
		.uav_readdatavalid     (cpu_data_master_translator_avalon_universal_master_0_readdatavalid), //                          .readdatavalid
		.uav_byteenable        (cpu_data_master_translator_avalon_universal_master_0_byteenable),    //                          .byteenable
		.uav_readdata          (cpu_data_master_translator_avalon_universal_master_0_readdata),      //                          .readdata
		.uav_writedata         (cpu_data_master_translator_avalon_universal_master_0_writedata),     //                          .writedata
		.uav_lock              (cpu_data_master_translator_avalon_universal_master_0_lock),          //                          .lock
		.uav_debugaccess       (cpu_data_master_translator_avalon_universal_master_0_debugaccess),   //                          .debugaccess
		.av_address            (cpu_data_master_address),                                            //      avalon_anti_master_0.address
		.av_waitrequest        (cpu_data_master_waitrequest),                                        //                          .waitrequest
		.av_burstcount         (cpu_data_master_burstcount),                                         //                          .burstcount
		.av_byteenable         (cpu_data_master_byteenable),                                         //                          .byteenable
		.av_read               (cpu_data_master_read),                                               //                          .read
		.av_readdata           (cpu_data_master_readdata),                                           //                          .readdata
		.av_readdatavalid      (cpu_data_master_readdatavalid),                                      //                          .readdatavalid
		.av_write              (cpu_data_master_write),                                              //                          .write
		.av_writedata          (cpu_data_master_writedata),                                          //                          .writedata
		.av_debugaccess        (cpu_data_master_debugaccess),                                        //                          .debugaccess
		.av_beginbursttransfer (1'b0),                                                               //               (terminated)
		.av_begintransfer      (1'b0),                                                               //               (terminated)
		.av_chipselect         (1'b0),                                                               //               (terminated)
		.av_lock               (1'b0),                                                               //               (terminated)
		.uav_clken             (),                                                                   //               (terminated)
		.av_clken              (1'b1)                                                                //               (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (9),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (28),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) cpu_jtag_debug_module_translator (
		.clk                   (ddr3_128mb_sysclk_clk),                                                            //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                                   //                    reset.reset
		.uav_address           (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (cpu_jtag_debug_module_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (cpu_jtag_debug_module_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (cpu_jtag_debug_module_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (cpu_jtag_debug_module_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_begintransfer      (cpu_jtag_debug_module_translator_avalon_anti_slave_0_begintransfer),               //                         .begintransfer
		.av_byteenable         (cpu_jtag_debug_module_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_chipselect         (cpu_jtag_debug_module_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_debugaccess        (cpu_jtag_debug_module_translator_avalon_anti_slave_0_debugaccess),                 //                         .debugaccess
		.av_read               (),                                                                                 //              (terminated)
		.av_beginbursttransfer (),                                                                                 //              (terminated)
		.av_burstcount         (),                                                                                 //              (terminated)
		.av_readdatavalid      (1'b0),                                                                             //              (terminated)
		.av_waitrequest        (1'b0),                                                                             //              (terminated)
		.av_writebyteenable    (),                                                                                 //              (terminated)
		.av_lock               (),                                                                                 //              (terminated)
		.av_clken              (),                                                                                 //              (terminated)
		.uav_clken             (1'b0),                                                                             //              (terminated)
		.av_outputenable       ()                                                                                  //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (24),
		.AV_DATA_W                      (64),
		.UAV_DATA_W                     (64),
		.AV_BURSTCOUNT_W                (3),
		.AV_BYTEENABLE_W                (8),
		.UAV_BYTEENABLE_W               (8),
		.UAV_ADDRESS_W                  (28),
		.UAV_BURSTCOUNT_W               (6),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (1),
		.USE_WAITREQUEST                (1),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (8),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (1),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) ddr3_128mb_s1_translator (
		.clk                   (ddr3_128mb_sysclk_clk),                                                    //                      clk.clk
		.reset                 (~ddr3_128mb_reset_request_n_reset),                                        //                    reset.reset
		.uav_address           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (ddr3_128mb_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (ddr3_128mb_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_read               (ddr3_128mb_s1_translator_avalon_anti_slave_0_read),                        //                         .read
		.av_readdata           (ddr3_128mb_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (ddr3_128mb_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_beginbursttransfer (ddr3_128mb_s1_translator_avalon_anti_slave_0_beginbursttransfer),          //                         .beginbursttransfer
		.av_burstcount         (ddr3_128mb_s1_translator_avalon_anti_slave_0_burstcount),                  //                         .burstcount
		.av_byteenable         (ddr3_128mb_s1_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_readdatavalid      (ddr3_128mb_s1_translator_avalon_anti_slave_0_readdatavalid),               //                         .readdatavalid
		.av_waitrequest        (~ddr3_128mb_s1_translator_avalon_anti_slave_0_waitrequest),                //                         .waitrequest
		.av_begintransfer      (),                                                                         //              (terminated)
		.av_writebyteenable    (),                                                                         //              (terminated)
		.av_lock               (),                                                                         //              (terminated)
		.av_chipselect         (),                                                                         //              (terminated)
		.av_clken              (),                                                                         //              (terminated)
		.uav_clken             (1'b0),                                                                     //              (terminated)
		.av_debugaccess        (),                                                                         //              (terminated)
		.av_outputenable       ()                                                                          //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (3),
		.AV_DATA_W                      (16),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (1),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (28),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (0),
		.USE_READDATAVALID              (0),
		.USE_WAITREQUEST                (0),
		.USE_UAV_CLKEN                  (0),
		.AV_SYMBOLS_PER_WORD            (4),
		.AV_ADDRESS_SYMBOLS             (0),
		.AV_BURSTCOUNT_SYMBOLS          (0),
		.AV_CONSTANT_BURST_BEHAVIOR     (0),
		.UAV_CONSTANT_BURST_BEHAVIOR    (0),
		.AV_REQUIRE_UNALIGNED_ADDRESSES (0),
		.CHIPSELECT_THROUGH_READLATENCY (0),
		.AV_READ_WAIT_CYCLES            (1),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) timer_s1_translator (
		.clk                   (ddr3_128mb_sysclk_clk),                                               //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                      //                    reset.reset
		.uav_address           (timer_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (timer_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (timer_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (timer_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (timer_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (timer_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (timer_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (timer_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (timer_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (timer_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (timer_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (timer_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (timer_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (timer_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (timer_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_chipselect         (timer_s1_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_read               (),                                                                    //              (terminated)
		.av_begintransfer      (),                                                                    //              (terminated)
		.av_beginbursttransfer (),                                                                    //              (terminated)
		.av_burstcount         (),                                                                    //              (terminated)
		.av_byteenable         (),                                                                    //              (terminated)
		.av_readdatavalid      (1'b0),                                                                //              (terminated)
		.av_waitrequest        (1'b0),                                                                //              (terminated)
		.av_writebyteenable    (),                                                                    //              (terminated)
		.av_lock               (),                                                                    //              (terminated)
		.av_clken              (),                                                                    //              (terminated)
		.uav_clken             (1'b0),                                                                //              (terminated)
		.av_debugaccess        (),                                                                    //              (terminated)
		.av_outputenable       ()                                                                     //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.PKT_BEGIN_BURST           (81),
		.PKT_BURSTWRAP_H           (80),
		.PKT_BURSTWRAP_L           (75),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_ADDR_H                (63),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (64),
		.PKT_TRANS_POSTED          (65),
		.PKT_TRANS_WRITE           (66),
		.PKT_TRANS_READ            (67),
		.PKT_TRANS_LOCK            (68),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (83),
		.PKT_SRC_ID_L              (82),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (84),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (3),
		.AV_BURSTCOUNT_W           (6),
		.SUPPRESS_0_BYTEEN_RSP     (1),
		.ID                        (1),
		.BURSTWRAP_VALUE           (31)
	) cpu_instruction_master_translator_avalon_universal_master_0_agent (
		.clk              (ddr3_128mb_sysclk_clk),                                                              //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                                     // clk_reset.reset
		.av_address       (cpu_instruction_master_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (cpu_instruction_master_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (cpu_instruction_master_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (cpu_instruction_master_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (cpu_instruction_master_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (cpu_instruction_master_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (cpu_instruction_master_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (cpu_instruction_master_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (cpu_instruction_master_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (cpu_instruction_master_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (cpu_instruction_master_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_rsp_src_valid),                                                              //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                               //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                            //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                                      //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                        //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                               //          .ready
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.PKT_BEGIN_BURST           (81),
		.PKT_BURSTWRAP_H           (80),
		.PKT_BURSTWRAP_L           (75),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_ADDR_H                (63),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (64),
		.PKT_TRANS_POSTED          (65),
		.PKT_TRANS_WRITE           (66),
		.PKT_TRANS_READ            (67),
		.PKT_TRANS_LOCK            (68),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (83),
		.PKT_SRC_ID_L              (82),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (84),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (3),
		.AV_BURSTCOUNT_W           (6),
		.SUPPRESS_0_BYTEEN_RSP     (1),
		.ID                        (2),
		.BURSTWRAP_VALUE           (63)
	) cpu_data_master_translator_avalon_universal_master_0_agent (
		.clk              (ddr3_128mb_sysclk_clk),                                                       //       clk.clk
		.reset            (rst_controller_reset_out_reset),                                              // clk_reset.reset
		.av_address       (cpu_data_master_translator_avalon_universal_master_0_address),                //        av.address
		.av_write         (cpu_data_master_translator_avalon_universal_master_0_write),                  //          .write
		.av_read          (cpu_data_master_translator_avalon_universal_master_0_read),                   //          .read
		.av_writedata     (cpu_data_master_translator_avalon_universal_master_0_writedata),              //          .writedata
		.av_readdata      (cpu_data_master_translator_avalon_universal_master_0_readdata),               //          .readdata
		.av_waitrequest   (cpu_data_master_translator_avalon_universal_master_0_waitrequest),            //          .waitrequest
		.av_readdatavalid (cpu_data_master_translator_avalon_universal_master_0_readdatavalid),          //          .readdatavalid
		.av_byteenable    (cpu_data_master_translator_avalon_universal_master_0_byteenable),             //          .byteenable
		.av_burstcount    (cpu_data_master_translator_avalon_universal_master_0_burstcount),             //          .burstcount
		.av_debugaccess   (cpu_data_master_translator_avalon_universal_master_0_debugaccess),            //          .debugaccess
		.av_lock          (cpu_data_master_translator_avalon_universal_master_0_lock),                   //          .lock
		.cp_valid         (cpu_data_master_translator_avalon_universal_master_0_agent_cp_valid),         //        cp.valid
		.cp_data          (cpu_data_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.cp_startofpacket (cpu_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.cp_endofpacket   (cpu_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.cp_ready         (cpu_data_master_translator_avalon_universal_master_0_agent_cp_ready),         //          .ready
		.rp_valid         (limiter_001_rsp_src_valid),                                                   //        rp.valid
		.rp_data          (limiter_001_rsp_src_data),                                                    //          .data
		.rp_channel       (limiter_001_rsp_src_channel),                                                 //          .channel
		.rp_startofpacket (limiter_001_rsp_src_startofpacket),                                           //          .startofpacket
		.rp_endofpacket   (limiter_001_rsp_src_endofpacket),                                             //          .endofpacket
		.rp_ready         (limiter_001_rsp_src_ready)                                                    //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (81),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (63),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (64),
		.PKT_TRANS_POSTED          (65),
		.PKT_TRANS_WRITE           (66),
		.PKT_TRANS_READ            (67),
		.PKT_TRANS_LOCK            (68),
		.PKT_SRC_ID_H              (83),
		.PKT_SRC_ID_L              (82),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (84),
		.PKT_BURSTWRAP_H           (80),
		.PKT_BURSTWRAP_L           (75),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (3),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent (
		.clk                     (ddr3_128mb_sysclk_clk),                                                                      //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                             //       clk_reset.reset
		.m0_address              (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (burst_adapter_source0_ready),                                                                //              cp.ready
		.cp_valid                (burst_adapter_source0_valid),                                                                //                .valid
		.cp_data                 (burst_adapter_source0_data),                                                                 //                .data
		.cp_startofpacket        (burst_adapter_source0_startofpacket),                                                        //                .startofpacket
		.cp_endofpacket          (burst_adapter_source0_endofpacket),                                                          //                .endofpacket
		.cp_channel              (burst_adapter_source0_channel),                                                              //                .channel
		.rf_sink_ready           (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (ddr3_128mb_sysclk_clk),                                                                      //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                             // clk_reset.reset
		.in_data           (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                      // (terminated)
		.csr_read          (1'b0),                                                                                       // (terminated)
		.csr_write         (1'b0),                                                                                       // (terminated)
		.csr_readdata      (),                                                                                           // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                       // (terminated)
		.almost_full_data  (),                                                                                           // (terminated)
		.almost_empty_data (),                                                                                           // (terminated)
		.in_empty          (1'b0),                                                                                       // (terminated)
		.out_empty         (),                                                                                           // (terminated)
		.in_error          (1'b0),                                                                                       // (terminated)
		.out_error         (),                                                                                           // (terminated)
		.in_channel        (1'b0),                                                                                       // (terminated)
		.out_channel       ()                                                                                            // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (63),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (117),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (71),
		.PKT_BYTEEN_L              (64),
		.PKT_ADDR_H                (99),
		.PKT_ADDR_L                (72),
		.PKT_TRANS_COMPRESSED_READ (100),
		.PKT_TRANS_POSTED          (101),
		.PKT_TRANS_WRITE           (102),
		.PKT_TRANS_READ            (103),
		.PKT_TRANS_LOCK            (104),
		.PKT_SRC_ID_H              (119),
		.PKT_SRC_ID_L              (118),
		.PKT_DEST_ID_H             (121),
		.PKT_DEST_ID_L             (120),
		.PKT_BURSTWRAP_H           (116),
		.PKT_BURSTWRAP_L           (111),
		.PKT_BYTE_CNT_H            (110),
		.PKT_BYTE_CNT_L            (105),
		.PKT_PROTECTION_H          (122),
		.PKT_PROTECTION_L          (122),
		.ST_CHANNEL_W              (3),
		.ST_DATA_W                 (123),
		.AVS_BURSTCOUNT_W          (6),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) ddr3_128mb_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (ddr3_128mb_sysclk_clk),                                                              //             clk.clk
		.reset                   (~ddr3_128mb_reset_request_n_reset),                                                  //       clk_reset.reset
		.m0_address              (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (burst_adapter_001_source0_ready),                                                    //              cp.ready
		.cp_valid                (burst_adapter_001_source0_valid),                                                    //                .valid
		.cp_data                 (burst_adapter_001_source0_data),                                                     //                .data
		.cp_startofpacket        (burst_adapter_001_source0_startofpacket),                                            //                .startofpacket
		.cp_endofpacket          (burst_adapter_001_source0_endofpacket),                                              //                .endofpacket
		.cp_channel              (burst_adapter_001_source0_channel),                                                  //                .channel
		.rf_sink_ready           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid),       //                .valid
		.rdata_fifo_sink_data    (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),        //                .data
		.rdata_fifo_src_ready    (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (124),
		.FIFO_DEPTH          (33),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (ddr3_128mb_sysclk_clk),                                                              //       clk.clk
		.reset             (~ddr3_128mb_reset_request_n_reset),                                                  // clk_reset.reset
		.in_data           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                              // (terminated)
		.csr_read          (1'b0),                                                                               // (terminated)
		.csr_write         (1'b0),                                                                               // (terminated)
		.csr_readdata      (),                                                                                   // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                               // (terminated)
		.almost_full_data  (),                                                                                   // (terminated)
		.almost_empty_data (),                                                                                   // (terminated)
		.in_empty          (1'b0),                                                                               // (terminated)
		.out_empty         (),                                                                                   // (terminated)
		.in_error          (1'b0),                                                                               // (terminated)
		.out_error         (),                                                                                   // (terminated)
		.in_channel        (1'b0),                                                                               // (terminated)
		.out_channel       ()                                                                                    // (terminated)
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (64),
		.FIFO_DEPTH          (256),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (0),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (3),
		.USE_MEMORY_BLOCKS   (1),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo (
		.clk               (ddr3_128mb_sysclk_clk),                                                        //       clk.clk
		.reset             (~ddr3_128mb_reset_request_n_reset),                                            // clk_reset.reset
		.in_data           (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),  //        in.data
		.in_valid          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid), //          .valid
		.in_ready          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready), //          .ready
		.out_data          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_data),  //       out.data
		.out_valid         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_valid), //          .valid
		.out_ready         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_out_ready), //          .ready
		.csr_address       (2'b00),                                                                        // (terminated)
		.csr_read          (1'b0),                                                                         // (terminated)
		.csr_write         (1'b0),                                                                         // (terminated)
		.csr_readdata      (),                                                                             // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                         // (terminated)
		.almost_full_data  (),                                                                             // (terminated)
		.almost_empty_data (),                                                                             // (terminated)
		.in_startofpacket  (1'b0),                                                                         // (terminated)
		.in_endofpacket    (1'b0),                                                                         // (terminated)
		.out_startofpacket (),                                                                             // (terminated)
		.out_endofpacket   (),                                                                             // (terminated)
		.in_empty          (1'b0),                                                                         // (terminated)
		.out_empty         (),                                                                             // (terminated)
		.in_error          (1'b0),                                                                         // (terminated)
		.out_error         (),                                                                             // (terminated)
		.in_channel        (1'b0),                                                                         // (terminated)
		.out_channel       ()                                                                              // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (81),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (63),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (64),
		.PKT_TRANS_POSTED          (65),
		.PKT_TRANS_WRITE           (66),
		.PKT_TRANS_READ            (67),
		.PKT_TRANS_LOCK            (68),
		.PKT_SRC_ID_H              (83),
		.PKT_SRC_ID_L              (82),
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (84),
		.PKT_BURSTWRAP_H           (80),
		.PKT_BURSTWRAP_L           (75),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_PROTECTION_H          (86),
		.PKT_PROTECTION_L          (86),
		.ST_CHANNEL_W              (3),
		.ST_DATA_W                 (87),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) timer_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (ddr3_128mb_sysclk_clk),                                                         //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                //       clk_reset.reset
		.m0_address              (timer_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (timer_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (timer_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (timer_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (timer_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (timer_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (timer_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (timer_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (timer_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (timer_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (timer_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (timer_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (timer_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (timer_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (timer_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (timer_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (burst_adapter_002_source0_ready),                                               //              cp.ready
		.cp_valid                (burst_adapter_002_source0_valid),                                               //                .valid
		.cp_data                 (burst_adapter_002_source0_data),                                                //                .data
		.cp_startofpacket        (burst_adapter_002_source0_startofpacket),                                       //                .startofpacket
		.cp_endofpacket          (burst_adapter_002_source0_endofpacket),                                         //                .endofpacket
		.cp_channel              (burst_adapter_002_source0_channel),                                             //                .channel
		.rf_sink_ready           (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (88),
		.FIFO_DEPTH          (2),
		.CHANNEL_WIDTH       (0),
		.ERROR_WIDTH         (0),
		.USE_PACKETS         (1),
		.USE_FILL_LEVEL      (0),
		.EMPTY_LATENCY       (1),
		.USE_MEMORY_BLOCKS   (0),
		.USE_STORE_FORWARD   (0),
		.USE_ALMOST_FULL_IF  (0),
		.USE_ALMOST_EMPTY_IF (0)
	) timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (ddr3_128mb_sysclk_clk),                                                         //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                // clk_reset.reset
		.in_data           (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (timer_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                         // (terminated)
		.csr_read          (1'b0),                                                                          // (terminated)
		.csr_write         (1'b0),                                                                          // (terminated)
		.csr_readdata      (),                                                                              // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                          // (terminated)
		.almost_full_data  (),                                                                              // (terminated)
		.almost_empty_data (),                                                                              // (terminated)
		.in_empty          (1'b0),                                                                          // (terminated)
		.out_empty         (),                                                                              // (terminated)
		.in_error          (1'b0),                                                                          // (terminated)
		.out_error         (),                                                                              // (terminated)
		.in_channel        (1'b0),                                                                          // (terminated)
		.out_channel       ()                                                                               // (terminated)
	);

	nios2_agx2_ddr3_addr_router addr_router (
		.sink_ready         (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (ddr3_128mb_sysclk_clk),                                                              //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                     // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                              //       src.ready
		.src_valid          (addr_router_src_valid),                                                              //          .valid
		.src_data           (addr_router_src_data),                                                               //          .data
		.src_channel        (addr_router_src_channel),                                                            //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                                      //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                         //          .endofpacket
	);

	nios2_agx2_ddr3_addr_router_001 addr_router_001 (
		.sink_ready         (cpu_data_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (cpu_data_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (cpu_data_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (cpu_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (ddr3_128mb_sysclk_clk),                                                       //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                              // clk_reset.reset
		.src_ready          (addr_router_001_src_ready),                                                   //       src.ready
		.src_valid          (addr_router_001_src_valid),                                                   //          .valid
		.src_data           (addr_router_001_src_data),                                                    //          .data
		.src_channel        (addr_router_001_src_channel),                                                 //          .channel
		.src_startofpacket  (addr_router_001_src_startofpacket),                                           //          .startofpacket
		.src_endofpacket    (addr_router_001_src_endofpacket)                                              //          .endofpacket
	);

	nios2_agx2_ddr3_id_router id_router (
		.sink_ready         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_jtag_debug_module_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (ddr3_128mb_sysclk_clk),                                                            //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                   // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                              //       src.ready
		.src_valid          (id_router_src_valid),                                                              //          .valid
		.src_data           (id_router_src_data),                                                               //          .data
		.src_channel        (id_router_src_channel),                                                            //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                                      //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                                         //          .endofpacket
	);

	nios2_agx2_ddr3_id_router_001 id_router_001 (
		.sink_ready         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (ddr3_128mb_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (ddr3_128mb_sysclk_clk),                                                    //       clk.clk
		.reset              (~ddr3_128mb_reset_request_n_reset),                                        // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                  //       src.ready
		.src_valid          (id_router_001_src_valid),                                                  //          .valid
		.src_data           (id_router_001_src_data),                                                   //          .data
		.src_channel        (id_router_001_src_channel),                                                //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                          //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                             //          .endofpacket
	);

	nios2_agx2_ddr3_id_router_002 id_router_002 (
		.sink_ready         (timer_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (timer_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (timer_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (timer_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (timer_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (ddr3_128mb_sysclk_clk),                                               //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                      // clk_reset.reset
		.src_ready          (id_router_002_src_ready),                                             //       src.ready
		.src_valid          (id_router_002_src_valid),                                             //          .valid
		.src_data           (id_router_002_src_data),                                              //          .data
		.src_channel        (id_router_002_src_channel),                                           //          .channel
		.src_startofpacket  (id_router_002_src_startofpacket),                                     //          .startofpacket
		.src_endofpacket    (id_router_002_src_endofpacket)                                        //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (84),
		.PKT_TRANS_POSTED          (65),
		.MAX_OUTSTANDING_RESPONSES (38),
		.PIPELINED                 (0),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (3),
		.VALID_WIDTH               (3),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (ddr3_128mb_sysclk_clk),          //       clk.clk
		.reset                  (rst_controller_reset_out_reset), // clk_reset.reset
		.cmd_sink_ready         (addr_router_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_src_data),           //          .data
		.cmd_sink_channel       (addr_router_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_cmd_valid_data)          // cmd_valid.data
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (85),
		.PKT_DEST_ID_L             (84),
		.PKT_TRANS_POSTED          (65),
		.MAX_OUTSTANDING_RESPONSES (38),
		.PIPELINED                 (0),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (3),
		.VALID_WIDTH               (3),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter_001 (
		.clk                    (ddr3_128mb_sysclk_clk),              //       clk.clk
		.reset                  (rst_controller_reset_out_reset),     // clk_reset.reset
		.cmd_sink_ready         (addr_router_001_src_ready),          //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_001_src_valid),          //          .valid
		.cmd_sink_data          (addr_router_001_src_data),           //          .data
		.cmd_sink_channel       (addr_router_001_src_channel),        //          .channel
		.cmd_sink_startofpacket (addr_router_001_src_startofpacket),  //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_001_src_endofpacket),    //          .endofpacket
		.cmd_src_ready          (limiter_001_cmd_src_ready),          //   cmd_src.ready
		.cmd_src_data           (limiter_001_cmd_src_data),           //          .data
		.cmd_src_channel        (limiter_001_cmd_src_channel),        //          .channel
		.cmd_src_startofpacket  (limiter_001_cmd_src_startofpacket),  //          .startofpacket
		.cmd_src_endofpacket    (limiter_001_cmd_src_endofpacket),    //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_mux_001_src_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_mux_001_src_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_mux_001_src_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_mux_001_src_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_mux_001_src_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_mux_001_src_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_001_rsp_src_ready),          //   rsp_src.ready
		.rsp_src_valid          (limiter_001_rsp_src_valid),          //          .valid
		.rsp_src_data           (limiter_001_rsp_src_data),           //          .data
		.rsp_src_channel        (limiter_001_rsp_src_channel),        //          .channel
		.rsp_src_startofpacket  (limiter_001_rsp_src_startofpacket),  //          .startofpacket
		.rsp_src_endofpacket    (limiter_001_rsp_src_endofpacket),    //          .endofpacket
		.cmd_src_valid          (limiter_001_cmd_valid_data)          // cmd_valid.data
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (63),
		.PKT_ADDR_L                (36),
		.PKT_BEGIN_BURST           (81),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_BURSTWRAP_H           (80),
		.PKT_BURSTWRAP_L           (75),
		.PKT_TRANS_COMPRESSED_READ (64),
		.PKT_TRANS_WRITE           (66),
		.PKT_TRANS_READ            (67),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (3),
		.OUT_BYTE_CNT_H            (71),
		.OUT_BURSTWRAP_H           (80),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (31),
		.BURSTWRAP_CONST_VALUE     (31)
	) burst_adapter (
		.clk                   (ddr3_128mb_sysclk_clk),               //       cr0.clk
		.reset                 (rst_controller_reset_out_reset),      // cr0_reset.reset
		.sink0_valid           (cmd_xbar_mux_src_valid),              //     sink0.valid
		.sink0_data            (cmd_xbar_mux_src_data),               //          .data
		.sink0_channel         (cmd_xbar_mux_src_channel),            //          .channel
		.sink0_startofpacket   (cmd_xbar_mux_src_startofpacket),      //          .startofpacket
		.sink0_endofpacket     (cmd_xbar_mux_src_endofpacket),        //          .endofpacket
		.sink0_ready           (cmd_xbar_mux_src_ready),              //          .ready
		.source0_valid         (burst_adapter_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_source0_data),          //          .data
		.source0_channel       (burst_adapter_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_source0_ready)          //          .ready
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (99),
		.PKT_ADDR_L                (72),
		.PKT_BEGIN_BURST           (117),
		.PKT_BYTE_CNT_H            (110),
		.PKT_BYTE_CNT_L            (105),
		.PKT_BYTEEN_H              (71),
		.PKT_BYTEEN_L              (64),
		.PKT_BURSTWRAP_H           (116),
		.PKT_BURSTWRAP_L           (111),
		.PKT_TRANS_COMPRESSED_READ (100),
		.PKT_TRANS_WRITE           (102),
		.PKT_TRANS_READ            (103),
		.ST_DATA_W                 (123),
		.ST_CHANNEL_W              (3),
		.OUT_BYTE_CNT_H            (110),
		.OUT_BURSTWRAP_H           (116),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (31),
		.BURSTWRAP_CONST_VALUE     (31)
	) burst_adapter_001 (
		.clk                   (ddr3_128mb_sysclk_clk),                   //       cr0.clk
		.reset                 (~ddr3_128mb_reset_request_n_reset),       // cr0_reset.reset
		.sink0_valid           (width_adapter_src_valid),                 //     sink0.valid
		.sink0_data            (width_adapter_src_data),                  //          .data
		.sink0_channel         (width_adapter_src_channel),               //          .channel
		.sink0_startofpacket   (width_adapter_src_startofpacket),         //          .startofpacket
		.sink0_endofpacket     (width_adapter_src_endofpacket),           //          .endofpacket
		.sink0_ready           (width_adapter_src_ready),                 //          .ready
		.source0_valid         (burst_adapter_001_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_001_source0_data),          //          .data
		.source0_channel       (burst_adapter_001_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_001_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_001_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_001_source0_ready)          //          .ready
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (63),
		.PKT_ADDR_L                (36),
		.PKT_BEGIN_BURST           (81),
		.PKT_BYTE_CNT_H            (74),
		.PKT_BYTE_CNT_L            (69),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_BURSTWRAP_H           (80),
		.PKT_BURSTWRAP_L           (75),
		.PKT_TRANS_COMPRESSED_READ (64),
		.PKT_TRANS_WRITE           (66),
		.PKT_TRANS_READ            (67),
		.ST_DATA_W                 (87),
		.ST_CHANNEL_W              (3),
		.OUT_BYTE_CNT_H            (71),
		.OUT_BURSTWRAP_H           (80),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (63),
		.BURSTWRAP_CONST_VALUE     (63)
	) burst_adapter_002 (
		.clk                   (ddr3_128mb_sysclk_clk),                   //       cr0.clk
		.reset                 (rst_controller_reset_out_reset),          // cr0_reset.reset
		.sink0_valid           (cmd_xbar_demux_001_src2_valid),           //     sink0.valid
		.sink0_data            (cmd_xbar_demux_001_src2_data),            //          .data
		.sink0_channel         (cmd_xbar_demux_001_src2_channel),         //          .channel
		.sink0_startofpacket   (cmd_xbar_demux_001_src2_startofpacket),   //          .startofpacket
		.sink0_endofpacket     (cmd_xbar_demux_001_src2_endofpacket),     //          .endofpacket
		.sink0_ready           (cmd_xbar_demux_001_src2_ready),           //          .ready
		.source0_valid         (burst_adapter_002_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_002_source0_data),          //          .data
		.source0_channel       (burst_adapter_002_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_002_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_002_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_002_source0_ready)          //          .ready
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~reset_reset_n),                 // reset_in0.reset
		.clk        (ddr3_128mb_sysclk_clk),          //       clk.clk
		.reset_out  (rst_controller_reset_out_reset), // reset_out.reset
		.reset_in1  (1'b0),                           // (terminated)
		.reset_in2  (1'b0),                           // (terminated)
		.reset_in3  (1'b0),                           // (terminated)
		.reset_in4  (1'b0),                           // (terminated)
		.reset_in5  (1'b0),                           // (terminated)
		.reset_in6  (1'b0),                           // (terminated)
		.reset_in7  (1'b0),                           // (terminated)
		.reset_in8  (1'b0),                           // (terminated)
		.reset_in9  (1'b0),                           // (terminated)
		.reset_in10 (1'b0),                           // (terminated)
		.reset_in11 (1'b0),                           // (terminated)
		.reset_in12 (1'b0),                           // (terminated)
		.reset_in13 (1'b0),                           // (terminated)
		.reset_in14 (1'b0),                           // (terminated)
		.reset_in15 (1'b0)                            // (terminated)
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller_001 (
		.reset_in0  (~reset_reset_n),                     // reset_in0.reset
		.clk        (clk_clk),                            //       clk.clk
		.reset_out  (rst_controller_001_reset_out_reset), // reset_out.reset
		.reset_in1  (1'b0),                               // (terminated)
		.reset_in2  (1'b0),                               // (terminated)
		.reset_in3  (1'b0),                               // (terminated)
		.reset_in4  (1'b0),                               // (terminated)
		.reset_in5  (1'b0),                               // (terminated)
		.reset_in6  (1'b0),                               // (terminated)
		.reset_in7  (1'b0),                               // (terminated)
		.reset_in8  (1'b0),                               // (terminated)
		.reset_in9  (1'b0),                               // (terminated)
		.reset_in10 (1'b0),                               // (terminated)
		.reset_in11 (1'b0),                               // (terminated)
		.reset_in12 (1'b0),                               // (terminated)
		.reset_in13 (1'b0),                               // (terminated)
		.reset_in14 (1'b0),                               // (terminated)
		.reset_in15 (1'b0)                                // (terminated)
	);

	nios2_agx2_ddr3_cmd_xbar_demux cmd_xbar_demux (
		.clk                (ddr3_128mb_sysclk_clk),             //        clk.clk
		.reset              (rst_controller_reset_out_reset),    //  clk_reset.reset
		.sink_ready         (limiter_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_cmd_src_channel),           //           .channel
		.sink_data          (limiter_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_src1_endofpacket)    //           .endofpacket
	);

	nios2_agx2_ddr3_cmd_xbar_demux_001 cmd_xbar_demux_001 (
		.clk                (ddr3_128mb_sysclk_clk),                 //        clk.clk
		.reset              (rst_controller_reset_out_reset),        //  clk_reset.reset
		.sink_ready         (limiter_001_cmd_src_ready),             //       sink.ready
		.sink_channel       (limiter_001_cmd_src_channel),           //           .channel
		.sink_data          (limiter_001_cmd_src_data),              //           .data
		.sink_startofpacket (limiter_001_cmd_src_startofpacket),     //           .startofpacket
		.sink_endofpacket   (limiter_001_cmd_src_endofpacket),       //           .endofpacket
		.sink_valid         (limiter_001_cmd_valid_data),            // sink_valid.data
		.src0_ready         (cmd_xbar_demux_001_src0_ready),         //       src0.ready
		.src0_valid         (cmd_xbar_demux_001_src0_valid),         //           .valid
		.src0_data          (cmd_xbar_demux_001_src0_data),          //           .data
		.src0_channel       (cmd_xbar_demux_001_src0_channel),       //           .channel
		.src0_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //           .startofpacket
		.src0_endofpacket   (cmd_xbar_demux_001_src0_endofpacket),   //           .endofpacket
		.src1_ready         (cmd_xbar_demux_001_src1_ready),         //       src1.ready
		.src1_valid         (cmd_xbar_demux_001_src1_valid),         //           .valid
		.src1_data          (cmd_xbar_demux_001_src1_data),          //           .data
		.src1_channel       (cmd_xbar_demux_001_src1_channel),       //           .channel
		.src1_startofpacket (cmd_xbar_demux_001_src1_startofpacket), //           .startofpacket
		.src1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket),   //           .endofpacket
		.src2_ready         (cmd_xbar_demux_001_src2_ready),         //       src2.ready
		.src2_valid         (cmd_xbar_demux_001_src2_valid),         //           .valid
		.src2_data          (cmd_xbar_demux_001_src2_data),          //           .data
		.src2_channel       (cmd_xbar_demux_001_src2_channel),       //           .channel
		.src2_startofpacket (cmd_xbar_demux_001_src2_startofpacket), //           .startofpacket
		.src2_endofpacket   (cmd_xbar_demux_001_src2_endofpacket)    //           .endofpacket
	);

	nios2_agx2_ddr3_cmd_xbar_mux cmd_xbar_mux (
		.clk                 (ddr3_128mb_sysclk_clk),                 //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (cmd_xbar_mux_src_ready),                //       src.ready
		.src_valid           (cmd_xbar_mux_src_valid),                //          .valid
		.src_data            (cmd_xbar_mux_src_data),                 //          .data
		.src_channel         (cmd_xbar_mux_src_channel),              //          .channel
		.src_startofpacket   (cmd_xbar_mux_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (cmd_xbar_mux_src_endofpacket),          //          .endofpacket
		.sink0_ready         (cmd_xbar_demux_src0_ready),             //     sink0.ready
		.sink0_valid         (cmd_xbar_demux_src0_valid),             //          .valid
		.sink0_channel       (cmd_xbar_demux_src0_channel),           //          .channel
		.sink0_data          (cmd_xbar_demux_src0_data),              //          .data
		.sink0_startofpacket (cmd_xbar_demux_src0_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (cmd_xbar_demux_src0_endofpacket),       //          .endofpacket
		.sink1_ready         (cmd_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	nios2_agx2_ddr3_cmd_xbar_mux cmd_xbar_mux_001 (
		.clk                 (ddr3_128mb_sysclk_clk),                 //       clk.clk
		.reset               (~ddr3_128mb_reset_request_n_reset),     // clk_reset.reset
		.src_ready           (cmd_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (cmd_xbar_mux_001_src_valid),            //          .valid
		.src_data            (cmd_xbar_mux_001_src_data),             //          .data
		.src_channel         (cmd_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (cmd_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (cmd_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (cmd_xbar_demux_src1_ready),             //     sink0.ready
		.sink0_valid         (cmd_xbar_demux_src1_valid),             //          .valid
		.sink0_channel       (cmd_xbar_demux_src1_channel),           //          .channel
		.sink0_data          (cmd_xbar_demux_src1_data),              //          .data
		.sink0_startofpacket (cmd_xbar_demux_src1_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (cmd_xbar_demux_src1_endofpacket),       //          .endofpacket
		.sink1_ready         (cmd_xbar_demux_001_src1_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src1_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src1_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src1_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

	nios2_agx2_ddr3_rsp_xbar_demux rsp_xbar_demux (
		.clk                (ddr3_128mb_sysclk_clk),             //       clk.clk
		.reset              (rst_controller_reset_out_reset),    // clk_reset.reset
		.sink_ready         (id_router_src_ready),               //      sink.ready
		.sink_channel       (id_router_src_channel),             //          .channel
		.sink_data          (id_router_src_data),                //          .data
		.sink_startofpacket (id_router_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_src0_endofpacket),   //          .endofpacket
		.src1_ready         (rsp_xbar_demux_src1_ready),         //      src1.ready
		.src1_valid         (rsp_xbar_demux_src1_valid),         //          .valid
		.src1_data          (rsp_xbar_demux_src1_data),          //          .data
		.src1_channel       (rsp_xbar_demux_src1_channel),       //          .channel
		.src1_startofpacket (rsp_xbar_demux_src1_startofpacket), //          .startofpacket
		.src1_endofpacket   (rsp_xbar_demux_src1_endofpacket)    //          .endofpacket
	);

	nios2_agx2_ddr3_rsp_xbar_demux rsp_xbar_demux_001 (
		.clk                (ddr3_128mb_sysclk_clk),                 //       clk.clk
		.reset              (~ddr3_128mb_reset_request_n_reset),     // clk_reset.reset
		.sink_ready         (width_adapter_001_src_ready),           //      sink.ready
		.sink_channel       (width_adapter_001_src_channel),         //          .channel
		.sink_data          (width_adapter_001_src_data),            //          .data
		.sink_startofpacket (width_adapter_001_src_startofpacket),   //          .startofpacket
		.sink_endofpacket   (width_adapter_001_src_endofpacket),     //          .endofpacket
		.sink_valid         (width_adapter_001_src_valid),           //          .valid
		.src0_ready         (rsp_xbar_demux_001_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_001_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_001_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_001_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_001_src0_endofpacket),   //          .endofpacket
		.src1_ready         (rsp_xbar_demux_001_src1_ready),         //      src1.ready
		.src1_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.src1_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.src1_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.src1_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.src1_endofpacket   (rsp_xbar_demux_001_src1_endofpacket)    //          .endofpacket
	);

	nios2_agx2_ddr3_rsp_xbar_demux_002 rsp_xbar_demux_002 (
		.clk                (ddr3_128mb_sysclk_clk),                 //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_002_src_ready),               //      sink.ready
		.sink_channel       (id_router_002_src_channel),             //          .channel
		.sink_data          (id_router_002_src_data),                //          .data
		.sink_startofpacket (id_router_002_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_002_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_002_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_002_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_002_src0_endofpacket)    //          .endofpacket
	);

	nios2_agx2_ddr3_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (ddr3_128mb_sysclk_clk),                 //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (rsp_xbar_mux_src_ready),                //       src.ready
		.src_valid           (rsp_xbar_mux_src_valid),                //          .valid
		.src_data            (rsp_xbar_mux_src_data),                 //          .data
		.src_channel         (rsp_xbar_mux_src_channel),              //          .channel
		.src_startofpacket   (rsp_xbar_mux_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_src_endofpacket),          //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_src0_ready),             //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_src0_valid),             //          .valid
		.sink0_channel       (rsp_xbar_demux_src0_channel),           //          .channel
		.sink0_data          (rsp_xbar_demux_src0_data),              //          .data
		.sink0_startofpacket (rsp_xbar_demux_src0_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_src0_endofpacket),       //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	nios2_agx2_ddr3_rsp_xbar_mux_001 rsp_xbar_mux_001 (
		.clk                 (ddr3_128mb_sysclk_clk),                 //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
		.src_ready           (rsp_xbar_mux_001_src_ready),            //       src.ready
		.src_valid           (rsp_xbar_mux_001_src_valid),            //          .valid
		.src_data            (rsp_xbar_mux_001_src_data),             //          .data
		.src_channel         (rsp_xbar_mux_001_src_channel),          //          .channel
		.src_startofpacket   (rsp_xbar_mux_001_src_startofpacket),    //          .startofpacket
		.src_endofpacket     (rsp_xbar_mux_001_src_endofpacket),      //          .endofpacket
		.sink0_ready         (rsp_xbar_demux_src1_ready),             //     sink0.ready
		.sink0_valid         (rsp_xbar_demux_src1_valid),             //          .valid
		.sink0_channel       (rsp_xbar_demux_src1_channel),           //          .channel
		.sink0_data          (rsp_xbar_demux_src1_data),              //          .data
		.sink0_startofpacket (rsp_xbar_demux_src1_startofpacket),     //          .startofpacket
		.sink0_endofpacket   (rsp_xbar_demux_src1_endofpacket),       //          .endofpacket
		.sink1_ready         (rsp_xbar_demux_001_src1_ready),         //     sink1.ready
		.sink1_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.sink1_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.sink1_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.sink1_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.sink1_endofpacket   (rsp_xbar_demux_001_src1_endofpacket),   //          .endofpacket
		.sink2_ready         (rsp_xbar_demux_002_src0_ready),         //     sink2.ready
		.sink2_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.sink2_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.sink2_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.sink2_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.sink2_endofpacket   (rsp_xbar_demux_002_src0_endofpacket)    //          .endofpacket
	);

	altera_merlin_width_adapter #(
		.IN_PKT_ADDR_H                 (63),
		.IN_PKT_ADDR_L                 (36),
		.IN_PKT_DATA_H                 (31),
		.IN_PKT_DATA_L                 (0),
		.IN_PKT_BYTEEN_H               (35),
		.IN_PKT_BYTEEN_L               (32),
		.IN_PKT_BYTE_CNT_H             (74),
		.IN_PKT_BYTE_CNT_L             (69),
		.IN_PKT_TRANS_COMPRESSED_READ  (64),
		.IN_PKT_BURSTWRAP_H            (80),
		.IN_PKT_BURSTWRAP_L            (75),
		.IN_ST_DATA_W                  (87),
		.OUT_PKT_ADDR_H                (99),
		.OUT_PKT_ADDR_L                (72),
		.OUT_PKT_DATA_H                (63),
		.OUT_PKT_DATA_L                (0),
		.OUT_PKT_BYTEEN_H              (71),
		.OUT_PKT_BYTEEN_L              (64),
		.OUT_PKT_BYTE_CNT_H            (110),
		.OUT_PKT_BYTE_CNT_L            (105),
		.OUT_PKT_TRANS_COMPRESSED_READ (100),
		.OUT_ST_DATA_W                 (123),
		.ST_CHANNEL_W                  (3),
		.OPTIMIZE_FOR_RSP              (0)
	) width_adapter (
		.clk               (ddr3_128mb_sysclk_clk),              //       clk.clk
		.reset             (~ddr3_128mb_reset_request_n_reset),  // clk_reset.reset
		.in_valid          (cmd_xbar_mux_001_src_valid),         //      sink.valid
		.in_channel        (cmd_xbar_mux_001_src_channel),       //          .channel
		.in_startofpacket  (cmd_xbar_mux_001_src_startofpacket), //          .startofpacket
		.in_endofpacket    (cmd_xbar_mux_001_src_endofpacket),   //          .endofpacket
		.in_ready          (cmd_xbar_mux_001_src_ready),         //          .ready
		.in_data           (cmd_xbar_mux_001_src_data),          //          .data
		.out_endofpacket   (width_adapter_src_endofpacket),      //       src.endofpacket
		.out_data          (width_adapter_src_data),             //          .data
		.out_channel       (width_adapter_src_channel),          //          .channel
		.out_valid         (width_adapter_src_valid),            //          .valid
		.out_ready         (width_adapter_src_ready),            //          .ready
		.out_startofpacket (width_adapter_src_startofpacket)     //          .startofpacket
	);

	altera_merlin_width_adapter #(
		.IN_PKT_ADDR_H                 (99),
		.IN_PKT_ADDR_L                 (72),
		.IN_PKT_DATA_H                 (63),
		.IN_PKT_DATA_L                 (0),
		.IN_PKT_BYTEEN_H               (71),
		.IN_PKT_BYTEEN_L               (64),
		.IN_PKT_BYTE_CNT_H             (110),
		.IN_PKT_BYTE_CNT_L             (105),
		.IN_PKT_TRANS_COMPRESSED_READ  (100),
		.IN_PKT_BURSTWRAP_H            (116),
		.IN_PKT_BURSTWRAP_L            (111),
		.IN_ST_DATA_W                  (123),
		.OUT_PKT_ADDR_H                (63),
		.OUT_PKT_ADDR_L                (36),
		.OUT_PKT_DATA_H                (31),
		.OUT_PKT_DATA_L                (0),
		.OUT_PKT_BYTEEN_H              (35),
		.OUT_PKT_BYTEEN_L              (32),
		.OUT_PKT_BYTE_CNT_H            (74),
		.OUT_PKT_BYTE_CNT_L            (69),
		.OUT_PKT_TRANS_COMPRESSED_READ (64),
		.OUT_ST_DATA_W                 (87),
		.ST_CHANNEL_W                  (3),
		.OPTIMIZE_FOR_RSP              (0)
	) width_adapter_001 (
		.clk               (ddr3_128mb_sysclk_clk),               //       clk.clk
		.reset             (~ddr3_128mb_reset_request_n_reset),   // clk_reset.reset
		.in_valid          (id_router_001_src_valid),             //      sink.valid
		.in_channel        (id_router_001_src_channel),           //          .channel
		.in_startofpacket  (id_router_001_src_startofpacket),     //          .startofpacket
		.in_endofpacket    (id_router_001_src_endofpacket),       //          .endofpacket
		.in_ready          (id_router_001_src_ready),             //          .ready
		.in_data           (id_router_001_src_data),              //          .data
		.out_endofpacket   (width_adapter_001_src_endofpacket),   //       src.endofpacket
		.out_data          (width_adapter_001_src_data),          //          .data
		.out_channel       (width_adapter_001_src_channel),       //          .channel
		.out_valid         (width_adapter_001_src_valid),         //          .valid
		.out_ready         (width_adapter_001_src_ready),         //          .ready
		.out_startofpacket (width_adapter_001_src_startofpacket)  //          .startofpacket
	);

	nios2_agx2_ddr3_irq_mapper irq_mapper (
		.clk        (ddr3_128mb_sysclk_clk),          //       clk.clk
		.reset      (rst_controller_reset_out_reset), // clk_reset.reset
		.sender_irq (cpu_d_irq_irq)                   //    sender.irq
	);

endmodule