// nios2_a2gx_onchip.v


`timescale 1 ps / 1 ps
module nios2_a2gx_onchip (
		input  wire        reset_reset_n,       //        reset.reset_n
		output wire [31:0] parallel_out_export, // parallel_out.export
		input  wire        clk_clk,             //          clk.clk
		input  wire [31:0] parallel_in_export   //  parallel_in.export
	);

	wire   [3:0] cpu_data_master_burstcount;                                                           // cpu:d_burstcount -> cpu_data_master_translator:av_burstcount
	wire         cpu_data_master_waitrequest;                                                          // cpu_data_master_translator:av_waitrequest -> cpu:d_waitrequest
	wire  [31:0] cpu_data_master_writedata;                                                            // cpu:d_writedata -> cpu_data_master_translator:av_writedata
	wire  [16:0] cpu_data_master_address;                                                              // cpu:d_address -> cpu_data_master_translator:av_address
	wire         cpu_data_master_write;                                                                // cpu:d_write -> cpu_data_master_translator:av_write
	wire         cpu_data_master_read;                                                                 // cpu:d_read -> cpu_data_master_translator:av_read
	wire  [31:0] cpu_data_master_readdata;                                                             // cpu_data_master_translator:av_readdata -> cpu:d_readdata
	wire         cpu_data_master_readdatavalid;                                                        // cpu_data_master_translator:av_readdatavalid -> cpu:d_readdatavalid
	wire   [3:0] cpu_data_master_byteenable;                                                           // cpu:d_byteenable -> cpu_data_master_translator:av_byteenable
	wire   [3:0] cpu_instruction_master_burstcount;                                                    // cpu:i_burstcount -> cpu_instruction_master_translator:av_burstcount
	wire         cpu_instruction_master_waitrequest;                                                   // cpu_instruction_master_translator:av_waitrequest -> cpu:i_waitrequest
	wire  [16:0] cpu_instruction_master_address;                                                       // cpu:i_address -> cpu_instruction_master_translator:av_address
	wire         cpu_instruction_master_read;                                                          // cpu:i_read -> cpu_instruction_master_translator:av_read
	wire  [31:0] cpu_instruction_master_readdata;                                                      // cpu_instruction_master_translator:av_readdata -> cpu:i_readdata
	wire         cpu_instruction_master_readdatavalid;                                                 // cpu_instruction_master_translator:av_readdatavalid -> cpu:i_readdatavalid
	wire  [15:0] timer_s1_translator_avalon_anti_slave_0_writedata;                                    // timer_s1_translator:av_writedata -> timer:writedata
	wire   [2:0] timer_s1_translator_avalon_anti_slave_0_address;                                      // timer_s1_translator:av_address -> timer:address
	wire         timer_s1_translator_avalon_anti_slave_0_chipselect;                                   // timer_s1_translator:av_chipselect -> timer:chipselect
	wire         timer_s1_translator_avalon_anti_slave_0_write;                                        // timer_s1_translator:av_write -> timer:write_n
	wire  [15:0] timer_s1_translator_avalon_anti_slave_0_readdata;                                     // timer:readdata -> timer_s1_translator:av_readdata
	wire  [31:0] onchip_mem_0_s1_translator_avalon_anti_slave_0_writedata;                             // onchip_mem_0_s1_translator:av_writedata -> onchip_mem_0:writedata
	wire  [12:0] onchip_mem_0_s1_translator_avalon_anti_slave_0_address;                               // onchip_mem_0_s1_translator:av_address -> onchip_mem_0:address
	wire         onchip_mem_0_s1_translator_avalon_anti_slave_0_chipselect;                            // onchip_mem_0_s1_translator:av_chipselect -> onchip_mem_0:chipselect
	wire         onchip_mem_0_s1_translator_avalon_anti_slave_0_clken;                                 // onchip_mem_0_s1_translator:av_clken -> onchip_mem_0:clken
	wire         onchip_mem_0_s1_translator_avalon_anti_slave_0_write;                                 // onchip_mem_0_s1_translator:av_write -> onchip_mem_0:write
	wire  [31:0] onchip_mem_0_s1_translator_avalon_anti_slave_0_readdata;                              // onchip_mem_0:readdata -> onchip_mem_0_s1_translator:av_readdata
	wire   [3:0] onchip_mem_0_s1_translator_avalon_anti_slave_0_byteenable;                            // onchip_mem_0_s1_translator:av_byteenable -> onchip_mem_0:byteenable
	wire  [31:0] parallel_out_s1_translator_avalon_anti_slave_0_writedata;                             // parallel_out_s1_translator:av_writedata -> parallel_out:writedata
	wire   [1:0] parallel_out_s1_translator_avalon_anti_slave_0_address;                               // parallel_out_s1_translator:av_address -> parallel_out:address
	wire         parallel_out_s1_translator_avalon_anti_slave_0_chipselect;                            // parallel_out_s1_translator:av_chipselect -> parallel_out:chipselect
	wire         parallel_out_s1_translator_avalon_anti_slave_0_write;                                 // parallel_out_s1_translator:av_write -> parallel_out:write_n
	wire  [31:0] parallel_out_s1_translator_avalon_anti_slave_0_readdata;                              // parallel_out:readdata -> parallel_out_s1_translator:av_readdata
	wire  [31:0] parallel_in_s1_translator_avalon_anti_slave_0_writedata;                              // parallel_in_s1_translator:av_writedata -> parallel_in:writedata
	wire   [1:0] parallel_in_s1_translator_avalon_anti_slave_0_address;                                // parallel_in_s1_translator:av_address -> parallel_in:address
	wire         parallel_in_s1_translator_avalon_anti_slave_0_chipselect;                             // parallel_in_s1_translator:av_chipselect -> parallel_in:chipselect
	wire         parallel_in_s1_translator_avalon_anti_slave_0_write;                                  // parallel_in_s1_translator:av_write -> parallel_in:write_n
	wire  [31:0] parallel_in_s1_translator_avalon_anti_slave_0_readdata;                               // parallel_in:readdata -> parallel_in_s1_translator:av_readdata
	wire         cpu_data_master_translator_avalon_universal_master_0_waitrequest;                     // cpu_data_master_translator_avalon_universal_master_0_agent:av_waitrequest -> cpu_data_master_translator:uav_waitrequest
	wire   [5:0] cpu_data_master_translator_avalon_universal_master_0_burstcount;                      // cpu_data_master_translator:uav_burstcount -> cpu_data_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] cpu_data_master_translator_avalon_universal_master_0_writedata;                       // cpu_data_master_translator:uav_writedata -> cpu_data_master_translator_avalon_universal_master_0_agent:av_writedata
	wire  [16:0] cpu_data_master_translator_avalon_universal_master_0_address;                         // cpu_data_master_translator:uav_address -> cpu_data_master_translator_avalon_universal_master_0_agent:av_address
	wire         cpu_data_master_translator_avalon_universal_master_0_lock;                            // cpu_data_master_translator:uav_lock -> cpu_data_master_translator_avalon_universal_master_0_agent:av_lock
	wire         cpu_data_master_translator_avalon_universal_master_0_write;                           // cpu_data_master_translator:uav_write -> cpu_data_master_translator_avalon_universal_master_0_agent:av_write
	wire         cpu_data_master_translator_avalon_universal_master_0_read;                            // cpu_data_master_translator:uav_read -> cpu_data_master_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] cpu_data_master_translator_avalon_universal_master_0_readdata;                        // cpu_data_master_translator_avalon_universal_master_0_agent:av_readdata -> cpu_data_master_translator:uav_readdata
	wire         cpu_data_master_translator_avalon_universal_master_0_debugaccess;                     // cpu_data_master_translator:uav_debugaccess -> cpu_data_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] cpu_data_master_translator_avalon_universal_master_0_byteenable;                      // cpu_data_master_translator:uav_byteenable -> cpu_data_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire         cpu_data_master_translator_avalon_universal_master_0_readdatavalid;                   // cpu_data_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> cpu_data_master_translator:uav_readdatavalid
	wire         cpu_instruction_master_translator_avalon_universal_master_0_waitrequest;              // cpu_instruction_master_translator_avalon_universal_master_0_agent:av_waitrequest -> cpu_instruction_master_translator:uav_waitrequest
	wire   [5:0] cpu_instruction_master_translator_avalon_universal_master_0_burstcount;               // cpu_instruction_master_translator:uav_burstcount -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_burstcount
	wire  [31:0] cpu_instruction_master_translator_avalon_universal_master_0_writedata;                // cpu_instruction_master_translator:uav_writedata -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_writedata
	wire  [16:0] cpu_instruction_master_translator_avalon_universal_master_0_address;                  // cpu_instruction_master_translator:uav_address -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_address
	wire         cpu_instruction_master_translator_avalon_universal_master_0_lock;                     // cpu_instruction_master_translator:uav_lock -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_lock
	wire         cpu_instruction_master_translator_avalon_universal_master_0_write;                    // cpu_instruction_master_translator:uav_write -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_write
	wire         cpu_instruction_master_translator_avalon_universal_master_0_read;                     // cpu_instruction_master_translator:uav_read -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_read
	wire  [31:0] cpu_instruction_master_translator_avalon_universal_master_0_readdata;                 // cpu_instruction_master_translator_avalon_universal_master_0_agent:av_readdata -> cpu_instruction_master_translator:uav_readdata
	wire         cpu_instruction_master_translator_avalon_universal_master_0_debugaccess;              // cpu_instruction_master_translator:uav_debugaccess -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_debugaccess
	wire   [3:0] cpu_instruction_master_translator_avalon_universal_master_0_byteenable;               // cpu_instruction_master_translator:uav_byteenable -> cpu_instruction_master_translator_avalon_universal_master_0_agent:av_byteenable
	wire         cpu_instruction_master_translator_avalon_universal_master_0_readdatavalid;            // cpu_instruction_master_translator_avalon_universal_master_0_agent:av_readdatavalid -> cpu_instruction_master_translator:uav_readdatavalid
	wire         timer_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;                    // timer_s1_translator:uav_waitrequest -> timer_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;                     // timer_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> timer_s1_translator:uav_burstcount
	wire  [31:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_writedata;                      // timer_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> timer_s1_translator:uav_writedata
	wire  [16:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_address;                        // timer_s1_translator_avalon_universal_slave_0_agent:m0_address -> timer_s1_translator:uav_address
	wire         timer_s1_translator_avalon_universal_slave_0_agent_m0_write;                          // timer_s1_translator_avalon_universal_slave_0_agent:m0_write -> timer_s1_translator:uav_write
	wire         timer_s1_translator_avalon_universal_slave_0_agent_m0_lock;                           // timer_s1_translator_avalon_universal_slave_0_agent:m0_lock -> timer_s1_translator:uav_lock
	wire         timer_s1_translator_avalon_universal_slave_0_agent_m0_read;                           // timer_s1_translator_avalon_universal_slave_0_agent:m0_read -> timer_s1_translator:uav_read
	wire  [31:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                       // timer_s1_translator:uav_readdata -> timer_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         timer_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;                  // timer_s1_translator:uav_readdatavalid -> timer_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         timer_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;                    // timer_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> timer_s1_translator:uav_debugaccess
	wire   [3:0] timer_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;                     // timer_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> timer_s1_translator:uav_byteenable
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;             // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;                   // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;           // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [78:0] timer_s1_translator_avalon_universal_slave_0_agent_rf_source_data;                    // timer_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;                   // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> timer_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;          // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;                // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;        // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [78:0] timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;                 // timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;                // timer_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;              // timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;               // timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;              // timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> timer_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;             // onchip_mem_0_s1_translator:uav_waitrequest -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;              // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> onchip_mem_0_s1_translator:uav_burstcount
	wire  [31:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_writedata;               // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> onchip_mem_0_s1_translator:uav_writedata
	wire  [16:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_address;                 // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_address -> onchip_mem_0_s1_translator:uav_address
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_write;                   // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_write -> onchip_mem_0_s1_translator:uav_write
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_lock;                    // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_lock -> onchip_mem_0_s1_translator:uav_lock
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_read;                    // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_read -> onchip_mem_0_s1_translator:uav_read
	wire  [31:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                // onchip_mem_0_s1_translator:uav_readdata -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;           // onchip_mem_0_s1_translator:uav_readdatavalid -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;             // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> onchip_mem_0_s1_translator:uav_debugaccess
	wire   [3:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;              // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> onchip_mem_0_s1_translator:uav_byteenable
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;      // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;            // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;    // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [78:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_data;             // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;            // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;   // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;         // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket; // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [78:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;          // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;         // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;       // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;        // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;       // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;             // parallel_out_s1_translator:uav_waitrequest -> parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;              // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> parallel_out_s1_translator:uav_burstcount
	wire  [31:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_writedata;               // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> parallel_out_s1_translator:uav_writedata
	wire  [16:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_address;                 // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_address -> parallel_out_s1_translator:uav_address
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_write;                   // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_write -> parallel_out_s1_translator:uav_write
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_lock;                    // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_lock -> parallel_out_s1_translator:uav_lock
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_read;                    // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_read -> parallel_out_s1_translator:uav_read
	wire  [31:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                // parallel_out_s1_translator:uav_readdata -> parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;           // parallel_out_s1_translator:uav_readdatavalid -> parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;             // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> parallel_out_s1_translator:uav_debugaccess
	wire   [3:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;              // parallel_out_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> parallel_out_s1_translator:uav_byteenable
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;      // parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;            // parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;    // parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [78:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_data;             // parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;            // parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;   // parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;         // parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket; // parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [78:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;          // parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;         // parallel_out_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;       // parallel_out_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;        // parallel_out_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;       // parallel_out_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest;              // parallel_in_s1_translator:uav_waitrequest -> parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_waitrequest
	wire   [2:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_burstcount;               // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_burstcount -> parallel_in_s1_translator:uav_burstcount
	wire  [31:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_writedata;                // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_writedata -> parallel_in_s1_translator:uav_writedata
	wire  [16:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_address;                  // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_address -> parallel_in_s1_translator:uav_address
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_write;                    // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_write -> parallel_in_s1_translator:uav_write
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_lock;                     // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_lock -> parallel_in_s1_translator:uav_lock
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_read;                     // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_read -> parallel_in_s1_translator:uav_read
	wire  [31:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_readdata;                 // parallel_in_s1_translator:uav_readdata -> parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_readdata
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid;            // parallel_in_s1_translator:uav_readdatavalid -> parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_readdatavalid
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess;              // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_debugaccess -> parallel_in_s1_translator:uav_debugaccess
	wire   [3:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_byteenable;               // parallel_in_s1_translator_avalon_universal_slave_0_agent:m0_byteenable -> parallel_in_s1_translator:uav_byteenable
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket;       // parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_source_endofpacket -> parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_endofpacket
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_valid;             // parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_source_valid -> parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_valid
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket;     // parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_source_startofpacket -> parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_startofpacket
	wire  [78:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_data;              // parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_source_data -> parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_data
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_ready;             // parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:in_ready -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_source_ready
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket;    // parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_endofpacket -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_sink_endofpacket
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid;          // parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_valid -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_sink_valid
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket;  // parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_startofpacket -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_sink_startofpacket
	wire  [78:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data;           // parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_data -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_sink_data
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready;          // parallel_in_s1_translator_avalon_universal_slave_0_agent:rf_sink_ready -> parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:out_ready
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid;        // parallel_in_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_valid -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_valid
	wire  [31:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data;         // parallel_in_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_data -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_data
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready;        // parallel_in_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_sink_ready -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rdata_fifo_src_ready
	wire         cpu_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket;            // cpu_data_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router:sink_endofpacket
	wire         cpu_data_master_translator_avalon_universal_master_0_agent_cp_valid;                  // cpu_data_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router:sink_valid
	wire         cpu_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket;          // cpu_data_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router:sink_startofpacket
	wire  [77:0] cpu_data_master_translator_avalon_universal_master_0_agent_cp_data;                   // cpu_data_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router:sink_data
	wire         cpu_data_master_translator_avalon_universal_master_0_agent_cp_ready;                  // addr_router:sink_ready -> cpu_data_master_translator_avalon_universal_master_0_agent:cp_ready
	wire         cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket;     // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_endofpacket -> addr_router_001:sink_endofpacket
	wire         cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_valid;           // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_valid -> addr_router_001:sink_valid
	wire         cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket;   // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_startofpacket -> addr_router_001:sink_startofpacket
	wire  [77:0] cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_data;            // cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_data -> addr_router_001:sink_data
	wire         cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_ready;           // addr_router_001:sink_ready -> cpu_instruction_master_translator_avalon_universal_master_0_agent:cp_ready
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;                    // timer_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router:sink_endofpacket
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rp_valid;                          // timer_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router:sink_valid
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;                  // timer_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router:sink_startofpacket
	wire  [77:0] timer_s1_translator_avalon_universal_slave_0_agent_rp_data;                           // timer_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router:sink_data
	wire         timer_s1_translator_avalon_universal_slave_0_agent_rp_ready;                          // id_router:sink_ready -> timer_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;             // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_001:sink_endofpacket
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_valid;                   // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_001:sink_valid
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;           // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_001:sink_startofpacket
	wire  [77:0] onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_data;                    // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router_001:sink_data
	wire         onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_ready;                   // id_router_001:sink_ready -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;             // parallel_out_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_002:sink_endofpacket
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_valid;                   // parallel_out_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_002:sink_valid
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;           // parallel_out_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_002:sink_startofpacket
	wire  [77:0] parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_data;                    // parallel_out_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router_002:sink_data
	wire         parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_ready;                   // id_router_002:sink_ready -> parallel_out_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket;              // parallel_in_s1_translator_avalon_universal_slave_0_agent:rp_endofpacket -> id_router_003:sink_endofpacket
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_valid;                    // parallel_in_s1_translator_avalon_universal_slave_0_agent:rp_valid -> id_router_003:sink_valid
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket;            // parallel_in_s1_translator_avalon_universal_slave_0_agent:rp_startofpacket -> id_router_003:sink_startofpacket
	wire  [77:0] parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_data;                     // parallel_in_s1_translator_avalon_universal_slave_0_agent:rp_data -> id_router_003:sink_data
	wire         parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_ready;                    // id_router_003:sink_ready -> parallel_in_s1_translator_avalon_universal_slave_0_agent:rp_ready
	wire         addr_router_src_endofpacket;                                                          // addr_router:src_endofpacket -> limiter:cmd_sink_endofpacket
	wire         addr_router_src_valid;                                                                // addr_router:src_valid -> limiter:cmd_sink_valid
	wire         addr_router_src_startofpacket;                                                        // addr_router:src_startofpacket -> limiter:cmd_sink_startofpacket
	wire  [77:0] addr_router_src_data;                                                                 // addr_router:src_data -> limiter:cmd_sink_data
	wire   [3:0] addr_router_src_channel;                                                              // addr_router:src_channel -> limiter:cmd_sink_channel
	wire         addr_router_src_ready;                                                                // limiter:cmd_sink_ready -> addr_router:src_ready
	wire         limiter_rsp_src_endofpacket;                                                          // limiter:rsp_src_endofpacket -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_rsp_src_valid;                                                                // limiter:rsp_src_valid -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_rsp_src_startofpacket;                                                        // limiter:rsp_src_startofpacket -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [77:0] limiter_rsp_src_data;                                                                 // limiter:rsp_src_data -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_data
	wire   [3:0] limiter_rsp_src_channel;                                                              // limiter:rsp_src_channel -> cpu_data_master_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_rsp_src_ready;                                                                // cpu_data_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter:rsp_src_ready
	wire         addr_router_001_src_endofpacket;                                                      // addr_router_001:src_endofpacket -> limiter_001:cmd_sink_endofpacket
	wire         addr_router_001_src_valid;                                                            // addr_router_001:src_valid -> limiter_001:cmd_sink_valid
	wire         addr_router_001_src_startofpacket;                                                    // addr_router_001:src_startofpacket -> limiter_001:cmd_sink_startofpacket
	wire  [77:0] addr_router_001_src_data;                                                             // addr_router_001:src_data -> limiter_001:cmd_sink_data
	wire   [3:0] addr_router_001_src_channel;                                                          // addr_router_001:src_channel -> limiter_001:cmd_sink_channel
	wire         addr_router_001_src_ready;                                                            // limiter_001:cmd_sink_ready -> addr_router_001:src_ready
	wire         limiter_001_rsp_src_endofpacket;                                                      // limiter_001:rsp_src_endofpacket -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_endofpacket
	wire         limiter_001_rsp_src_valid;                                                            // limiter_001:rsp_src_valid -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_valid
	wire         limiter_001_rsp_src_startofpacket;                                                    // limiter_001:rsp_src_startofpacket -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_startofpacket
	wire  [77:0] limiter_001_rsp_src_data;                                                             // limiter_001:rsp_src_data -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_data
	wire   [3:0] limiter_001_rsp_src_channel;                                                          // limiter_001:rsp_src_channel -> cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_channel
	wire         limiter_001_rsp_src_ready;                                                            // cpu_instruction_master_translator_avalon_universal_master_0_agent:rp_ready -> limiter_001:rsp_src_ready
	wire         burst_adapter_source0_endofpacket;                                                    // burst_adapter:source0_endofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         burst_adapter_source0_valid;                                                          // burst_adapter:source0_valid -> timer_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire         burst_adapter_source0_startofpacket;                                                  // burst_adapter:source0_startofpacket -> timer_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [77:0] burst_adapter_source0_data;                                                           // burst_adapter:source0_data -> timer_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire         burst_adapter_source0_ready;                                                          // timer_s1_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter:source0_ready
	wire   [3:0] burst_adapter_source0_channel;                                                        // burst_adapter:source0_channel -> timer_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire         burst_adapter_001_source0_endofpacket;                                                // burst_adapter_001:source0_endofpacket -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         burst_adapter_001_source0_valid;                                                      // burst_adapter_001:source0_valid -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire         burst_adapter_001_source0_startofpacket;                                              // burst_adapter_001:source0_startofpacket -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [77:0] burst_adapter_001_source0_data;                                                       // burst_adapter_001:source0_data -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire         burst_adapter_001_source0_ready;                                                      // onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter_001:source0_ready
	wire   [3:0] burst_adapter_001_source0_channel;                                                    // burst_adapter_001:source0_channel -> onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire         burst_adapter_002_source0_endofpacket;                                                // burst_adapter_002:source0_endofpacket -> parallel_out_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         burst_adapter_002_source0_valid;                                                      // burst_adapter_002:source0_valid -> parallel_out_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire         burst_adapter_002_source0_startofpacket;                                              // burst_adapter_002:source0_startofpacket -> parallel_out_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [77:0] burst_adapter_002_source0_data;                                                       // burst_adapter_002:source0_data -> parallel_out_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire         burst_adapter_002_source0_ready;                                                      // parallel_out_s1_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter_002:source0_ready
	wire   [3:0] burst_adapter_002_source0_channel;                                                    // burst_adapter_002:source0_channel -> parallel_out_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire         burst_adapter_003_source0_endofpacket;                                                // burst_adapter_003:source0_endofpacket -> parallel_in_s1_translator_avalon_universal_slave_0_agent:cp_endofpacket
	wire         burst_adapter_003_source0_valid;                                                      // burst_adapter_003:source0_valid -> parallel_in_s1_translator_avalon_universal_slave_0_agent:cp_valid
	wire         burst_adapter_003_source0_startofpacket;                                              // burst_adapter_003:source0_startofpacket -> parallel_in_s1_translator_avalon_universal_slave_0_agent:cp_startofpacket
	wire  [77:0] burst_adapter_003_source0_data;                                                       // burst_adapter_003:source0_data -> parallel_in_s1_translator_avalon_universal_slave_0_agent:cp_data
	wire         burst_adapter_003_source0_ready;                                                      // parallel_in_s1_translator_avalon_universal_slave_0_agent:cp_ready -> burst_adapter_003:source0_ready
	wire   [3:0] burst_adapter_003_source0_channel;                                                    // burst_adapter_003:source0_channel -> parallel_in_s1_translator_avalon_universal_slave_0_agent:cp_channel
	wire         rst_controller_reset_out_reset;                                                       // rst_controller:reset_out -> [addr_router:reset, addr_router_001:reset, burst_adapter:reset, burst_adapter_001:reset, burst_adapter_002:reset, burst_adapter_003:reset, cmd_xbar_demux:reset, cmd_xbar_demux_001:reset, cmd_xbar_mux_001:reset, cpu:reset_n, cpu_data_master_translator:reset, cpu_data_master_translator_avalon_universal_master_0_agent:reset, cpu_instruction_master_translator:reset, cpu_instruction_master_translator_avalon_universal_master_0_agent:reset, id_router:reset, id_router_001:reset, id_router_002:reset, id_router_003:reset, irq_mapper:reset, limiter:reset, limiter_001:reset, onchip_mem_0:reset, onchip_mem_0_s1_translator:reset, onchip_mem_0_s1_translator_avalon_universal_slave_0_agent:reset, onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, parallel_in:reset_n, parallel_in_s1_translator:reset, parallel_in_s1_translator_avalon_universal_slave_0_agent:reset, parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, parallel_out:reset_n, parallel_out_s1_translator:reset, parallel_out_s1_translator_avalon_universal_slave_0_agent:reset, parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset, rsp_xbar_demux:reset, rsp_xbar_demux_001:reset, rsp_xbar_demux_002:reset, rsp_xbar_demux_003:reset, rsp_xbar_mux:reset, timer:reset_n, timer_s1_translator:reset, timer_s1_translator_avalon_universal_slave_0_agent:reset, timer_s1_translator_avalon_universal_slave_0_agent_rsp_fifo:reset]
	wire         cmd_xbar_demux_src0_endofpacket;                                                      // cmd_xbar_demux:src0_endofpacket -> burst_adapter:sink0_endofpacket
	wire         cmd_xbar_demux_src0_valid;                                                            // cmd_xbar_demux:src0_valid -> burst_adapter:sink0_valid
	wire         cmd_xbar_demux_src0_startofpacket;                                                    // cmd_xbar_demux:src0_startofpacket -> burst_adapter:sink0_startofpacket
	wire  [77:0] cmd_xbar_demux_src0_data;                                                             // cmd_xbar_demux:src0_data -> burst_adapter:sink0_data
	wire   [3:0] cmd_xbar_demux_src0_channel;                                                          // cmd_xbar_demux:src0_channel -> burst_adapter:sink0_channel
	wire         cmd_xbar_demux_src1_endofpacket;                                                      // cmd_xbar_demux:src1_endofpacket -> cmd_xbar_mux_001:sink0_endofpacket
	wire         cmd_xbar_demux_src1_valid;                                                            // cmd_xbar_demux:src1_valid -> cmd_xbar_mux_001:sink0_valid
	wire         cmd_xbar_demux_src1_startofpacket;                                                    // cmd_xbar_demux:src1_startofpacket -> cmd_xbar_mux_001:sink0_startofpacket
	wire  [77:0] cmd_xbar_demux_src1_data;                                                             // cmd_xbar_demux:src1_data -> cmd_xbar_mux_001:sink0_data
	wire   [3:0] cmd_xbar_demux_src1_channel;                                                          // cmd_xbar_demux:src1_channel -> cmd_xbar_mux_001:sink0_channel
	wire         cmd_xbar_demux_src1_ready;                                                            // cmd_xbar_mux_001:sink0_ready -> cmd_xbar_demux:src1_ready
	wire         cmd_xbar_demux_src2_endofpacket;                                                      // cmd_xbar_demux:src2_endofpacket -> burst_adapter_002:sink0_endofpacket
	wire         cmd_xbar_demux_src2_valid;                                                            // cmd_xbar_demux:src2_valid -> burst_adapter_002:sink0_valid
	wire         cmd_xbar_demux_src2_startofpacket;                                                    // cmd_xbar_demux:src2_startofpacket -> burst_adapter_002:sink0_startofpacket
	wire  [77:0] cmd_xbar_demux_src2_data;                                                             // cmd_xbar_demux:src2_data -> burst_adapter_002:sink0_data
	wire   [3:0] cmd_xbar_demux_src2_channel;                                                          // cmd_xbar_demux:src2_channel -> burst_adapter_002:sink0_channel
	wire         cmd_xbar_demux_src3_endofpacket;                                                      // cmd_xbar_demux:src3_endofpacket -> burst_adapter_003:sink0_endofpacket
	wire         cmd_xbar_demux_src3_valid;                                                            // cmd_xbar_demux:src3_valid -> burst_adapter_003:sink0_valid
	wire         cmd_xbar_demux_src3_startofpacket;                                                    // cmd_xbar_demux:src3_startofpacket -> burst_adapter_003:sink0_startofpacket
	wire  [77:0] cmd_xbar_demux_src3_data;                                                             // cmd_xbar_demux:src3_data -> burst_adapter_003:sink0_data
	wire   [3:0] cmd_xbar_demux_src3_channel;                                                          // cmd_xbar_demux:src3_channel -> burst_adapter_003:sink0_channel
	wire         cmd_xbar_demux_001_src0_endofpacket;                                                  // cmd_xbar_demux_001:src0_endofpacket -> cmd_xbar_mux_001:sink1_endofpacket
	wire         cmd_xbar_demux_001_src0_valid;                                                        // cmd_xbar_demux_001:src0_valid -> cmd_xbar_mux_001:sink1_valid
	wire         cmd_xbar_demux_001_src0_startofpacket;                                                // cmd_xbar_demux_001:src0_startofpacket -> cmd_xbar_mux_001:sink1_startofpacket
	wire  [77:0] cmd_xbar_demux_001_src0_data;                                                         // cmd_xbar_demux_001:src0_data -> cmd_xbar_mux_001:sink1_data
	wire   [3:0] cmd_xbar_demux_001_src0_channel;                                                      // cmd_xbar_demux_001:src0_channel -> cmd_xbar_mux_001:sink1_channel
	wire         cmd_xbar_demux_001_src0_ready;                                                        // cmd_xbar_mux_001:sink1_ready -> cmd_xbar_demux_001:src0_ready
	wire         rsp_xbar_demux_src0_endofpacket;                                                      // rsp_xbar_demux:src0_endofpacket -> rsp_xbar_mux:sink0_endofpacket
	wire         rsp_xbar_demux_src0_valid;                                                            // rsp_xbar_demux:src0_valid -> rsp_xbar_mux:sink0_valid
	wire         rsp_xbar_demux_src0_startofpacket;                                                    // rsp_xbar_demux:src0_startofpacket -> rsp_xbar_mux:sink0_startofpacket
	wire  [77:0] rsp_xbar_demux_src0_data;                                                             // rsp_xbar_demux:src0_data -> rsp_xbar_mux:sink0_data
	wire   [3:0] rsp_xbar_demux_src0_channel;                                                          // rsp_xbar_demux:src0_channel -> rsp_xbar_mux:sink0_channel
	wire         rsp_xbar_demux_src0_ready;                                                            // rsp_xbar_mux:sink0_ready -> rsp_xbar_demux:src0_ready
	wire         rsp_xbar_demux_001_src0_endofpacket;                                                  // rsp_xbar_demux_001:src0_endofpacket -> rsp_xbar_mux:sink1_endofpacket
	wire         rsp_xbar_demux_001_src0_valid;                                                        // rsp_xbar_demux_001:src0_valid -> rsp_xbar_mux:sink1_valid
	wire         rsp_xbar_demux_001_src0_startofpacket;                                                // rsp_xbar_demux_001:src0_startofpacket -> rsp_xbar_mux:sink1_startofpacket
	wire  [77:0] rsp_xbar_demux_001_src0_data;                                                         // rsp_xbar_demux_001:src0_data -> rsp_xbar_mux:sink1_data
	wire   [3:0] rsp_xbar_demux_001_src0_channel;                                                      // rsp_xbar_demux_001:src0_channel -> rsp_xbar_mux:sink1_channel
	wire         rsp_xbar_demux_001_src0_ready;                                                        // rsp_xbar_mux:sink1_ready -> rsp_xbar_demux_001:src0_ready
	wire         rsp_xbar_demux_001_src1_endofpacket;                                                  // rsp_xbar_demux_001:src1_endofpacket -> limiter_001:rsp_sink_endofpacket
	wire         rsp_xbar_demux_001_src1_valid;                                                        // rsp_xbar_demux_001:src1_valid -> limiter_001:rsp_sink_valid
	wire         rsp_xbar_demux_001_src1_startofpacket;                                                // rsp_xbar_demux_001:src1_startofpacket -> limiter_001:rsp_sink_startofpacket
	wire  [77:0] rsp_xbar_demux_001_src1_data;                                                         // rsp_xbar_demux_001:src1_data -> limiter_001:rsp_sink_data
	wire   [3:0] rsp_xbar_demux_001_src1_channel;                                                      // rsp_xbar_demux_001:src1_channel -> limiter_001:rsp_sink_channel
	wire         rsp_xbar_demux_002_src0_endofpacket;                                                  // rsp_xbar_demux_002:src0_endofpacket -> rsp_xbar_mux:sink2_endofpacket
	wire         rsp_xbar_demux_002_src0_valid;                                                        // rsp_xbar_demux_002:src0_valid -> rsp_xbar_mux:sink2_valid
	wire         rsp_xbar_demux_002_src0_startofpacket;                                                // rsp_xbar_demux_002:src0_startofpacket -> rsp_xbar_mux:sink2_startofpacket
	wire  [77:0] rsp_xbar_demux_002_src0_data;                                                         // rsp_xbar_demux_002:src0_data -> rsp_xbar_mux:sink2_data
	wire   [3:0] rsp_xbar_demux_002_src0_channel;                                                      // rsp_xbar_demux_002:src0_channel -> rsp_xbar_mux:sink2_channel
	wire         rsp_xbar_demux_002_src0_ready;                                                        // rsp_xbar_mux:sink2_ready -> rsp_xbar_demux_002:src0_ready
	wire         rsp_xbar_demux_003_src0_endofpacket;                                                  // rsp_xbar_demux_003:src0_endofpacket -> rsp_xbar_mux:sink3_endofpacket
	wire         rsp_xbar_demux_003_src0_valid;                                                        // rsp_xbar_demux_003:src0_valid -> rsp_xbar_mux:sink3_valid
	wire         rsp_xbar_demux_003_src0_startofpacket;                                                // rsp_xbar_demux_003:src0_startofpacket -> rsp_xbar_mux:sink3_startofpacket
	wire  [77:0] rsp_xbar_demux_003_src0_data;                                                         // rsp_xbar_demux_003:src0_data -> rsp_xbar_mux:sink3_data
	wire   [3:0] rsp_xbar_demux_003_src0_channel;                                                      // rsp_xbar_demux_003:src0_channel -> rsp_xbar_mux:sink3_channel
	wire         rsp_xbar_demux_003_src0_ready;                                                        // rsp_xbar_mux:sink3_ready -> rsp_xbar_demux_003:src0_ready
	wire         limiter_cmd_src_endofpacket;                                                          // limiter:cmd_src_endofpacket -> cmd_xbar_demux:sink_endofpacket
	wire         limiter_cmd_src_startofpacket;                                                        // limiter:cmd_src_startofpacket -> cmd_xbar_demux:sink_startofpacket
	wire  [77:0] limiter_cmd_src_data;                                                                 // limiter:cmd_src_data -> cmd_xbar_demux:sink_data
	wire   [3:0] limiter_cmd_src_channel;                                                              // limiter:cmd_src_channel -> cmd_xbar_demux:sink_channel
	wire         limiter_cmd_src_ready;                                                                // cmd_xbar_demux:sink_ready -> limiter:cmd_src_ready
	wire         rsp_xbar_mux_src_endofpacket;                                                         // rsp_xbar_mux:src_endofpacket -> limiter:rsp_sink_endofpacket
	wire         rsp_xbar_mux_src_valid;                                                               // rsp_xbar_mux:src_valid -> limiter:rsp_sink_valid
	wire         rsp_xbar_mux_src_startofpacket;                                                       // rsp_xbar_mux:src_startofpacket -> limiter:rsp_sink_startofpacket
	wire  [77:0] rsp_xbar_mux_src_data;                                                                // rsp_xbar_mux:src_data -> limiter:rsp_sink_data
	wire   [3:0] rsp_xbar_mux_src_channel;                                                             // rsp_xbar_mux:src_channel -> limiter:rsp_sink_channel
	wire         rsp_xbar_mux_src_ready;                                                               // limiter:rsp_sink_ready -> rsp_xbar_mux:src_ready
	wire         limiter_001_cmd_src_endofpacket;                                                      // limiter_001:cmd_src_endofpacket -> cmd_xbar_demux_001:sink_endofpacket
	wire         limiter_001_cmd_src_startofpacket;                                                    // limiter_001:cmd_src_startofpacket -> cmd_xbar_demux_001:sink_startofpacket
	wire  [77:0] limiter_001_cmd_src_data;                                                             // limiter_001:cmd_src_data -> cmd_xbar_demux_001:sink_data
	wire   [3:0] limiter_001_cmd_src_channel;                                                          // limiter_001:cmd_src_channel -> cmd_xbar_demux_001:sink_channel
	wire         limiter_001_cmd_src_ready;                                                            // cmd_xbar_demux_001:sink_ready -> limiter_001:cmd_src_ready
	wire         rsp_xbar_demux_001_src1_ready;                                                        // limiter_001:rsp_sink_ready -> rsp_xbar_demux_001:src1_ready
	wire         cmd_xbar_demux_src0_ready;                                                            // burst_adapter:sink0_ready -> cmd_xbar_demux:src0_ready
	wire         id_router_src_endofpacket;                                                            // id_router:src_endofpacket -> rsp_xbar_demux:sink_endofpacket
	wire         id_router_src_valid;                                                                  // id_router:src_valid -> rsp_xbar_demux:sink_valid
	wire         id_router_src_startofpacket;                                                          // id_router:src_startofpacket -> rsp_xbar_demux:sink_startofpacket
	wire  [77:0] id_router_src_data;                                                                   // id_router:src_data -> rsp_xbar_demux:sink_data
	wire   [3:0] id_router_src_channel;                                                                // id_router:src_channel -> rsp_xbar_demux:sink_channel
	wire         id_router_src_ready;                                                                  // rsp_xbar_demux:sink_ready -> id_router:src_ready
	wire         cmd_xbar_mux_001_src_endofpacket;                                                     // cmd_xbar_mux_001:src_endofpacket -> burst_adapter_001:sink0_endofpacket
	wire         cmd_xbar_mux_001_src_valid;                                                           // cmd_xbar_mux_001:src_valid -> burst_adapter_001:sink0_valid
	wire         cmd_xbar_mux_001_src_startofpacket;                                                   // cmd_xbar_mux_001:src_startofpacket -> burst_adapter_001:sink0_startofpacket
	wire  [77:0] cmd_xbar_mux_001_src_data;                                                            // cmd_xbar_mux_001:src_data -> burst_adapter_001:sink0_data
	wire   [3:0] cmd_xbar_mux_001_src_channel;                                                         // cmd_xbar_mux_001:src_channel -> burst_adapter_001:sink0_channel
	wire         cmd_xbar_mux_001_src_ready;                                                           // burst_adapter_001:sink0_ready -> cmd_xbar_mux_001:src_ready
	wire         id_router_001_src_endofpacket;                                                        // id_router_001:src_endofpacket -> rsp_xbar_demux_001:sink_endofpacket
	wire         id_router_001_src_valid;                                                              // id_router_001:src_valid -> rsp_xbar_demux_001:sink_valid
	wire         id_router_001_src_startofpacket;                                                      // id_router_001:src_startofpacket -> rsp_xbar_demux_001:sink_startofpacket
	wire  [77:0] id_router_001_src_data;                                                               // id_router_001:src_data -> rsp_xbar_demux_001:sink_data
	wire   [3:0] id_router_001_src_channel;                                                            // id_router_001:src_channel -> rsp_xbar_demux_001:sink_channel
	wire         id_router_001_src_ready;                                                              // rsp_xbar_demux_001:sink_ready -> id_router_001:src_ready
	wire         cmd_xbar_demux_src2_ready;                                                            // burst_adapter_002:sink0_ready -> cmd_xbar_demux:src2_ready
	wire         id_router_002_src_endofpacket;                                                        // id_router_002:src_endofpacket -> rsp_xbar_demux_002:sink_endofpacket
	wire         id_router_002_src_valid;                                                              // id_router_002:src_valid -> rsp_xbar_demux_002:sink_valid
	wire         id_router_002_src_startofpacket;                                                      // id_router_002:src_startofpacket -> rsp_xbar_demux_002:sink_startofpacket
	wire  [77:0] id_router_002_src_data;                                                               // id_router_002:src_data -> rsp_xbar_demux_002:sink_data
	wire   [3:0] id_router_002_src_channel;                                                            // id_router_002:src_channel -> rsp_xbar_demux_002:sink_channel
	wire         id_router_002_src_ready;                                                              // rsp_xbar_demux_002:sink_ready -> id_router_002:src_ready
	wire         cmd_xbar_demux_src3_ready;                                                            // burst_adapter_003:sink0_ready -> cmd_xbar_demux:src3_ready
	wire         id_router_003_src_endofpacket;                                                        // id_router_003:src_endofpacket -> rsp_xbar_demux_003:sink_endofpacket
	wire         id_router_003_src_valid;                                                              // id_router_003:src_valid -> rsp_xbar_demux_003:sink_valid
	wire         id_router_003_src_startofpacket;                                                      // id_router_003:src_startofpacket -> rsp_xbar_demux_003:sink_startofpacket
	wire  [77:0] id_router_003_src_data;                                                               // id_router_003:src_data -> rsp_xbar_demux_003:sink_data
	wire   [3:0] id_router_003_src_channel;                                                            // id_router_003:src_channel -> rsp_xbar_demux_003:sink_channel
	wire         id_router_003_src_ready;                                                              // rsp_xbar_demux_003:sink_ready -> id_router_003:src_ready
	wire   [3:0] limiter_cmd_valid_data;                                                               // limiter:cmd_src_valid -> cmd_xbar_demux:sink_valid
	wire   [3:0] limiter_001_cmd_valid_data;                                                           // limiter_001:cmd_src_valid -> cmd_xbar_demux_001:sink_valid
	wire         irq_mapper_receiver0_irq;                                                             // timer:irq -> irq_mapper:receiver0_irq
	wire         irq_mapper_receiver1_irq;                                                             // parallel_in:irq -> irq_mapper:receiver1_irq
	wire  [31:0] cpu_d_irq_irq;                                                                        // irq_mapper:sender_irq -> cpu:d_irq

	nios2_a2gx_onchip_cpu cpu (
		.clk             (clk_clk),                              //                       clk.clk
		.reset_n         (~rst_controller_reset_out_reset),      //                   reset_n.reset_n
		.d_address       (cpu_data_master_address),              //               data_master.address
		.d_byteenable    (cpu_data_master_byteenable),           //                          .byteenable
		.d_read          (cpu_data_master_read),                 //                          .read
		.d_readdata      (cpu_data_master_readdata),             //                          .readdata
		.d_waitrequest   (cpu_data_master_waitrequest),          //                          .waitrequest
		.d_write         (cpu_data_master_write),                //                          .write
		.d_writedata     (cpu_data_master_writedata),            //                          .writedata
		.d_burstcount    (cpu_data_master_burstcount),           //                          .burstcount
		.d_readdatavalid (cpu_data_master_readdatavalid),        //                          .readdatavalid
		.i_address       (cpu_instruction_master_address),       //        instruction_master.address
		.i_read          (cpu_instruction_master_read),          //                          .read
		.i_readdata      (cpu_instruction_master_readdata),      //                          .readdata
		.i_waitrequest   (cpu_instruction_master_waitrequest),   //                          .waitrequest
		.i_burstcount    (cpu_instruction_master_burstcount),    //                          .burstcount
		.i_readdatavalid (cpu_instruction_master_readdatavalid), //                          .readdatavalid
		.d_irq           (cpu_d_irq_irq),                        //                     d_irq.irq
		.no_ci_readra    ()                                      // custom_instruction_master.readra
	);

	nios2_a2gx_onchip_timer timer (
		.clk        (clk_clk),                                            //   clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                    // reset.reset_n
		.address    (timer_s1_translator_avalon_anti_slave_0_address),    //    s1.address
		.writedata  (timer_s1_translator_avalon_anti_slave_0_writedata),  //      .writedata
		.readdata   (timer_s1_translator_avalon_anti_slave_0_readdata),   //      .readdata
		.chipselect (timer_s1_translator_avalon_anti_slave_0_chipselect), //      .chipselect
		.write_n    (~timer_s1_translator_avalon_anti_slave_0_write),     //      .write_n
		.irq        (irq_mapper_receiver0_irq)                            //   irq.irq
	);

	nios2_a2gx_onchip_onchip_mem_0 onchip_mem_0 (
		.clk        (clk_clk),                                                   //   clk1.clk
		.address    (onchip_mem_0_s1_translator_avalon_anti_slave_0_address),    //     s1.address
		.chipselect (onchip_mem_0_s1_translator_avalon_anti_slave_0_chipselect), //       .chipselect
		.clken      (onchip_mem_0_s1_translator_avalon_anti_slave_0_clken),      //       .clken
		.readdata   (onchip_mem_0_s1_translator_avalon_anti_slave_0_readdata),   //       .readdata
		.write      (onchip_mem_0_s1_translator_avalon_anti_slave_0_write),      //       .write
		.writedata  (onchip_mem_0_s1_translator_avalon_anti_slave_0_writedata),  //       .writedata
		.byteenable (onchip_mem_0_s1_translator_avalon_anti_slave_0_byteenable), //       .byteenable
		.reset      (rst_controller_reset_out_reset)                             // reset1.reset
	);

	nios2_a2gx_onchip_parallel_out parallel_out (
		.clk        (clk_clk),                                                   //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                           //               reset.reset_n
		.address    (parallel_out_s1_translator_avalon_anti_slave_0_address),    //                  s1.address
		.write_n    (~parallel_out_s1_translator_avalon_anti_slave_0_write),     //                    .write_n
		.writedata  (parallel_out_s1_translator_avalon_anti_slave_0_writedata),  //                    .writedata
		.chipselect (parallel_out_s1_translator_avalon_anti_slave_0_chipselect), //                    .chipselect
		.readdata   (parallel_out_s1_translator_avalon_anti_slave_0_readdata),   //                    .readdata
		.out_port   (parallel_out_export)                                        // external_connection.export
	);

	nios2_a2gx_onchip_parallel_in parallel_in (
		.clk        (clk_clk),                                                  //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                          //               reset.reset_n
		.address    (parallel_in_s1_translator_avalon_anti_slave_0_address),    //                  s1.address
		.write_n    (~parallel_in_s1_translator_avalon_anti_slave_0_write),     //                    .write_n
		.writedata  (parallel_in_s1_translator_avalon_anti_slave_0_writedata),  //                    .writedata
		.chipselect (parallel_in_s1_translator_avalon_anti_slave_0_chipselect), //                    .chipselect
		.readdata   (parallel_in_s1_translator_avalon_anti_slave_0_readdata),   //                    .readdata
		.in_port    (parallel_in_export),                                       // external_connection.export
		.irq        (irq_mapper_receiver1_irq)                                  //                 irq.irq
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (17),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (4),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (17),
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
		.clk                   (clk_clk),                                                            //                       clk.clk
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
		.av_beginbursttransfer (1'b0),                                                               //               (terminated)
		.av_begintransfer      (1'b0),                                                               //               (terminated)
		.av_chipselect         (1'b0),                                                               //               (terminated)
		.av_lock               (1'b0),                                                               //               (terminated)
		.av_debugaccess        (1'b0),                                                               //               (terminated)
		.uav_clken             (),                                                                   //               (terminated)
		.av_clken              (1'b1)                                                                //               (terminated)
	);

	altera_merlin_master_translator #(
		.AV_ADDRESS_W                (17),
		.AV_DATA_W                   (32),
		.AV_BURSTCOUNT_W             (4),
		.AV_BYTEENABLE_W             (4),
		.UAV_ADDRESS_W               (17),
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
		.clk                   (clk_clk),                                                                   //                       clk.clk
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

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (3),
		.AV_DATA_W                      (16),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (1),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (17),
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
		.clk                   (clk_clk),                                                             //                      clk.clk
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

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (13),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (4),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (17),
		.UAV_BURSTCOUNT_W               (3),
		.AV_READLATENCY                 (1),
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
		.AV_READ_WAIT_CYCLES            (0),
		.AV_WRITE_WAIT_CYCLES           (0),
		.AV_SETUP_WAIT_CYCLES           (0),
		.AV_DATA_HOLD_CYCLES            (0)
	) onchip_mem_0_s1_translator (
		.clk                   (clk_clk),                                                                    //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                             //                    reset.reset
		.uav_address           (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (onchip_mem_0_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (onchip_mem_0_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (onchip_mem_0_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (onchip_mem_0_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_byteenable         (onchip_mem_0_s1_translator_avalon_anti_slave_0_byteenable),                  //                         .byteenable
		.av_chipselect         (onchip_mem_0_s1_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_clken              (onchip_mem_0_s1_translator_avalon_anti_slave_0_clken),                       //                         .clken
		.av_read               (),                                                                           //              (terminated)
		.av_begintransfer      (),                                                                           //              (terminated)
		.av_beginbursttransfer (),                                                                           //              (terminated)
		.av_burstcount         (),                                                                           //              (terminated)
		.av_readdatavalid      (1'b0),                                                                       //              (terminated)
		.av_waitrequest        (1'b0),                                                                       //              (terminated)
		.av_writebyteenable    (),                                                                           //              (terminated)
		.av_lock               (),                                                                           //              (terminated)
		.uav_clken             (1'b0),                                                                       //              (terminated)
		.av_debugaccess        (),                                                                           //              (terminated)
		.av_outputenable       ()                                                                            //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (2),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (1),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (17),
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
	) parallel_out_s1_translator (
		.clk                   (clk_clk),                                                                    //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                             //                    reset.reset
		.uav_address           (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (parallel_out_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (parallel_out_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (parallel_out_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (parallel_out_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_chipselect         (parallel_out_s1_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_read               (),                                                                           //              (terminated)
		.av_begintransfer      (),                                                                           //              (terminated)
		.av_beginbursttransfer (),                                                                           //              (terminated)
		.av_burstcount         (),                                                                           //              (terminated)
		.av_byteenable         (),                                                                           //              (terminated)
		.av_readdatavalid      (1'b0),                                                                       //              (terminated)
		.av_waitrequest        (1'b0),                                                                       //              (terminated)
		.av_writebyteenable    (),                                                                           //              (terminated)
		.av_lock               (),                                                                           //              (terminated)
		.av_clken              (),                                                                           //              (terminated)
		.uav_clken             (1'b0),                                                                       //              (terminated)
		.av_debugaccess        (),                                                                           //              (terminated)
		.av_outputenable       ()                                                                            //              (terminated)
	);

	altera_merlin_slave_translator #(
		.AV_ADDRESS_W                   (2),
		.AV_DATA_W                      (32),
		.UAV_DATA_W                     (32),
		.AV_BURSTCOUNT_W                (1),
		.AV_BYTEENABLE_W                (1),
		.UAV_BYTEENABLE_W               (4),
		.UAV_ADDRESS_W                  (17),
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
	) parallel_in_s1_translator (
		.clk                   (clk_clk),                                                                   //                      clk.clk
		.reset                 (rst_controller_reset_out_reset),                                            //                    reset.reset
		.uav_address           (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_address),       // avalon_universal_slave_0.address
		.uav_burstcount        (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),    //                         .burstcount
		.uav_read              (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_read),          //                         .read
		.uav_write             (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_write),         //                         .write
		.uav_waitrequest       (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),   //                         .waitrequest
		.uav_readdatavalid     (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid), //                         .readdatavalid
		.uav_byteenable        (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),    //                         .byteenable
		.uav_readdata          (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_readdata),      //                         .readdata
		.uav_writedata         (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_writedata),     //                         .writedata
		.uav_lock              (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_lock),          //                         .lock
		.uav_debugaccess       (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),   //                         .debugaccess
		.av_address            (parallel_in_s1_translator_avalon_anti_slave_0_address),                     //      avalon_anti_slave_0.address
		.av_write              (parallel_in_s1_translator_avalon_anti_slave_0_write),                       //                         .write
		.av_readdata           (parallel_in_s1_translator_avalon_anti_slave_0_readdata),                    //                         .readdata
		.av_writedata          (parallel_in_s1_translator_avalon_anti_slave_0_writedata),                   //                         .writedata
		.av_chipselect         (parallel_in_s1_translator_avalon_anti_slave_0_chipselect),                  //                         .chipselect
		.av_read               (),                                                                          //              (terminated)
		.av_begintransfer      (),                                                                          //              (terminated)
		.av_beginbursttransfer (),                                                                          //              (terminated)
		.av_burstcount         (),                                                                          //              (terminated)
		.av_byteenable         (),                                                                          //              (terminated)
		.av_readdatavalid      (1'b0),                                                                      //              (terminated)
		.av_waitrequest        (1'b0),                                                                      //              (terminated)
		.av_writebyteenable    (),                                                                          //              (terminated)
		.av_lock               (),                                                                          //              (terminated)
		.av_clken              (),                                                                          //              (terminated)
		.uav_clken             (1'b0),                                                                      //              (terminated)
		.av_debugaccess        (),                                                                          //              (terminated)
		.av_outputenable       ()                                                                           //              (terminated)
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (77),
		.PKT_PROTECTION_L          (77),
		.PKT_BEGIN_BURST           (70),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_POSTED          (54),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.PKT_TRANS_LOCK            (57),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (73),
		.PKT_SRC_ID_L              (71),
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.AV_BURSTCOUNT_W           (6),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (1),
		.BURSTWRAP_VALUE           (63)
	) cpu_data_master_translator_avalon_universal_master_0_agent (
		.clk              (clk_clk),                                                                     //       clk.clk
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
		.rp_valid         (limiter_rsp_src_valid),                                                       //        rp.valid
		.rp_data          (limiter_rsp_src_data),                                                        //          .data
		.rp_channel       (limiter_rsp_src_channel),                                                     //          .channel
		.rp_startofpacket (limiter_rsp_src_startofpacket),                                               //          .startofpacket
		.rp_endofpacket   (limiter_rsp_src_endofpacket),                                                 //          .endofpacket
		.rp_ready         (limiter_rsp_src_ready)                                                        //          .ready
	);

	altera_merlin_master_agent #(
		.PKT_PROTECTION_H          (77),
		.PKT_PROTECTION_L          (77),
		.PKT_BEGIN_BURST           (70),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_POSTED          (54),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.PKT_TRANS_LOCK            (57),
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_SRC_ID_H              (73),
		.PKT_SRC_ID_L              (71),
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.AV_BURSTCOUNT_W           (6),
		.SUPPRESS_0_BYTEEN_RSP     (0),
		.ID                        (2),
		.BURSTWRAP_VALUE           (31)
	) cpu_instruction_master_translator_avalon_universal_master_0_agent (
		.clk              (clk_clk),                                                                            //       clk.clk
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
		.rp_valid         (limiter_001_rsp_src_valid),                                                          //        rp.valid
		.rp_data          (limiter_001_rsp_src_data),                                                           //          .data
		.rp_channel       (limiter_001_rsp_src_channel),                                                        //          .channel
		.rp_startofpacket (limiter_001_rsp_src_startofpacket),                                                  //          .startofpacket
		.rp_endofpacket   (limiter_001_rsp_src_endofpacket),                                                    //          .endofpacket
		.rp_ready         (limiter_001_rsp_src_ready)                                                           //          .ready
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (70),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_POSTED          (54),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.PKT_TRANS_LOCK            (57),
		.PKT_SRC_ID_H              (73),
		.PKT_SRC_ID_L              (71),
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_PROTECTION_H          (77),
		.PKT_PROTECTION_L          (77),
		.ST_CHANNEL_W              (4),
		.ST_DATA_W                 (78),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) timer_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (clk_clk),                                                                       //             clk.clk
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
		.cp_ready                (burst_adapter_source0_ready),                                                   //              cp.ready
		.cp_valid                (burst_adapter_source0_valid),                                                   //                .valid
		.cp_data                 (burst_adapter_source0_data),                                                    //                .data
		.cp_startofpacket        (burst_adapter_source0_startofpacket),                                           //                .startofpacket
		.cp_endofpacket          (burst_adapter_source0_endofpacket),                                             //                .endofpacket
		.cp_channel              (burst_adapter_source0_channel),                                                 //                .channel
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
		.BITS_PER_SYMBOL     (79),
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
		.clk               (clk_clk),                                                                       //       clk.clk
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

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (70),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_POSTED          (54),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.PKT_TRANS_LOCK            (57),
		.PKT_SRC_ID_H              (73),
		.PKT_SRC_ID_L              (71),
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_PROTECTION_H          (77),
		.PKT_PROTECTION_L          (77),
		.ST_CHANNEL_W              (4),
		.ST_DATA_W                 (78),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) onchip_mem_0_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (clk_clk),                                                                              //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                       //       clk_reset.reset
		.m0_address              (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (burst_adapter_001_source0_ready),                                                      //              cp.ready
		.cp_valid                (burst_adapter_001_source0_valid),                                                      //                .valid
		.cp_data                 (burst_adapter_001_source0_data),                                                       //                .data
		.cp_startofpacket        (burst_adapter_001_source0_startofpacket),                                              //                .startofpacket
		.cp_endofpacket          (burst_adapter_001_source0_endofpacket),                                                //                .endofpacket
		.cp_channel              (burst_adapter_001_source0_channel),                                                    //                .channel
		.rf_sink_ready           (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (79),
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
	) onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clk_clk),                                                                              //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                       // clk_reset.reset
		.in_data           (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                // (terminated)
		.csr_read          (1'b0),                                                                                 // (terminated)
		.csr_write         (1'b0),                                                                                 // (terminated)
		.csr_readdata      (),                                                                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                 // (terminated)
		.almost_full_data  (),                                                                                     // (terminated)
		.almost_empty_data (),                                                                                     // (terminated)
		.in_empty          (1'b0),                                                                                 // (terminated)
		.out_empty         (),                                                                                     // (terminated)
		.in_error          (1'b0),                                                                                 // (terminated)
		.out_error         (),                                                                                     // (terminated)
		.in_channel        (1'b0),                                                                                 // (terminated)
		.out_channel       ()                                                                                      // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (70),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_POSTED          (54),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.PKT_TRANS_LOCK            (57),
		.PKT_SRC_ID_H              (73),
		.PKT_SRC_ID_L              (71),
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_PROTECTION_H          (77),
		.PKT_PROTECTION_L          (77),
		.ST_CHANNEL_W              (4),
		.ST_DATA_W                 (78),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) parallel_out_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (clk_clk),                                                                              //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                       //       clk_reset.reset
		.m0_address              (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (parallel_out_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (burst_adapter_002_source0_ready),                                                      //              cp.ready
		.cp_valid                (burst_adapter_002_source0_valid),                                                      //                .valid
		.cp_data                 (burst_adapter_002_source0_data),                                                       //                .data
		.cp_startofpacket        (burst_adapter_002_source0_startofpacket),                                              //                .startofpacket
		.cp_endofpacket          (burst_adapter_002_source0_endofpacket),                                                //                .endofpacket
		.cp_channel              (burst_adapter_002_source0_channel),                                                    //                .channel
		.rf_sink_ready           (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (parallel_out_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (79),
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
	) parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clk_clk),                                                                              //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                       // clk_reset.reset
		.in_data           (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (parallel_out_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (parallel_out_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                                // (terminated)
		.csr_read          (1'b0),                                                                                 // (terminated)
		.csr_write         (1'b0),                                                                                 // (terminated)
		.csr_readdata      (),                                                                                     // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                 // (terminated)
		.almost_full_data  (),                                                                                     // (terminated)
		.almost_empty_data (),                                                                                     // (terminated)
		.in_empty          (1'b0),                                                                                 // (terminated)
		.out_empty         (),                                                                                     // (terminated)
		.in_error          (1'b0),                                                                                 // (terminated)
		.out_error         (),                                                                                     // (terminated)
		.in_channel        (1'b0),                                                                                 // (terminated)
		.out_channel       ()                                                                                      // (terminated)
	);

	altera_merlin_slave_agent #(
		.PKT_DATA_H                (31),
		.PKT_DATA_L                (0),
		.PKT_BEGIN_BURST           (70),
		.PKT_SYMBOL_W              (8),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_POSTED          (54),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.PKT_TRANS_LOCK            (57),
		.PKT_SRC_ID_H              (73),
		.PKT_SRC_ID_L              (71),
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_PROTECTION_H          (77),
		.PKT_PROTECTION_L          (77),
		.ST_CHANNEL_W              (4),
		.ST_DATA_W                 (78),
		.AVS_BURSTCOUNT_W          (3),
		.SUPPRESS_0_BYTEEN_CMD     (0),
		.PREVENT_FIFO_OVERFLOW     (1)
	) parallel_in_s1_translator_avalon_universal_slave_0_agent (
		.clk                     (clk_clk),                                                                             //             clk.clk
		.reset                   (rst_controller_reset_out_reset),                                                      //       clk_reset.reset
		.m0_address              (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_address),                 //              m0.address
		.m0_burstcount           (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_burstcount),              //                .burstcount
		.m0_byteenable           (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_byteenable),              //                .byteenable
		.m0_debugaccess          (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_debugaccess),             //                .debugaccess
		.m0_lock                 (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_lock),                    //                .lock
		.m0_readdata             (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_readdata),                //                .readdata
		.m0_readdatavalid        (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_readdatavalid),           //                .readdatavalid
		.m0_read                 (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_read),                    //                .read
		.m0_waitrequest          (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_waitrequest),             //                .waitrequest
		.m0_writedata            (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_writedata),               //                .writedata
		.m0_write                (parallel_in_s1_translator_avalon_universal_slave_0_agent_m0_write),                   //                .write
		.rp_endofpacket          (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),             //              rp.endofpacket
		.rp_ready                (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_ready),                   //                .ready
		.rp_valid                (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_valid),                   //                .valid
		.rp_data                 (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_data),                    //                .data
		.rp_startofpacket        (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket),           //                .startofpacket
		.cp_ready                (burst_adapter_003_source0_ready),                                                     //              cp.ready
		.cp_valid                (burst_adapter_003_source0_valid),                                                     //                .valid
		.cp_data                 (burst_adapter_003_source0_data),                                                      //                .data
		.cp_startofpacket        (burst_adapter_003_source0_startofpacket),                                             //                .startofpacket
		.cp_endofpacket          (burst_adapter_003_source0_endofpacket),                                               //                .endofpacket
		.cp_channel              (burst_adapter_003_source0_channel),                                                   //                .channel
		.rf_sink_ready           (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //         rf_sink.ready
		.rf_sink_valid           (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //                .valid
		.rf_sink_startofpacket   (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //                .startofpacket
		.rf_sink_endofpacket     (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //                .endofpacket
		.rf_sink_data            (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //                .data
		.rf_source_ready         (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //       rf_source.ready
		.rf_source_valid         (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //                .valid
		.rf_source_startofpacket (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //                .startofpacket
		.rf_source_endofpacket   (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //                .endofpacket
		.rf_source_data          (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //                .data
		.rdata_fifo_sink_ready   (parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       // rdata_fifo_sink.ready
		.rdata_fifo_sink_valid   (parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_sink_data    (parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data),        //                .data
		.rdata_fifo_src_ready    (parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_ready),       //  rdata_fifo_src.ready
		.rdata_fifo_src_valid    (parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_valid),       //                .valid
		.rdata_fifo_src_data     (parallel_in_s1_translator_avalon_universal_slave_0_agent_rdata_fifo_src_data)         //                .data
	);

	altera_avalon_sc_fifo #(
		.SYMBOLS_PER_BEAT    (1),
		.BITS_PER_SYMBOL     (79),
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
	) parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo (
		.clk               (clk_clk),                                                                             //       clk.clk
		.reset             (rst_controller_reset_out_reset),                                                      // clk_reset.reset
		.in_data           (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_data),             //        in.data
		.in_valid          (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_valid),            //          .valid
		.in_ready          (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_ready),            //          .ready
		.in_startofpacket  (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_startofpacket),    //          .startofpacket
		.in_endofpacket    (parallel_in_s1_translator_avalon_universal_slave_0_agent_rf_source_endofpacket),      //          .endofpacket
		.out_data          (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_data),          //       out.data
		.out_valid         (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_valid),         //          .valid
		.out_ready         (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_ready),         //          .ready
		.out_startofpacket (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_startofpacket), //          .startofpacket
		.out_endofpacket   (parallel_in_s1_translator_avalon_universal_slave_0_agent_rsp_fifo_out_endofpacket),   //          .endofpacket
		.csr_address       (2'b00),                                                                               // (terminated)
		.csr_read          (1'b0),                                                                                // (terminated)
		.csr_write         (1'b0),                                                                                // (terminated)
		.csr_readdata      (),                                                                                    // (terminated)
		.csr_writedata     (32'b00000000000000000000000000000000),                                                // (terminated)
		.almost_full_data  (),                                                                                    // (terminated)
		.almost_empty_data (),                                                                                    // (terminated)
		.in_empty          (1'b0),                                                                                // (terminated)
		.out_empty         (),                                                                                    // (terminated)
		.in_error          (1'b0),                                                                                // (terminated)
		.out_error         (),                                                                                    // (terminated)
		.in_channel        (1'b0),                                                                                // (terminated)
		.out_channel       ()                                                                                     // (terminated)
	);

	nios2_a2gx_onchip_addr_router addr_router (
		.sink_ready         (cpu_data_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (cpu_data_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (cpu_data_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (cpu_data_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_data_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (clk_clk),                                                                     //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                              // clk_reset.reset
		.src_ready          (addr_router_src_ready),                                                       //       src.ready
		.src_valid          (addr_router_src_valid),                                                       //          .valid
		.src_data           (addr_router_src_data),                                                        //          .data
		.src_channel        (addr_router_src_channel),                                                     //          .channel
		.src_startofpacket  (addr_router_src_startofpacket),                                               //          .startofpacket
		.src_endofpacket    (addr_router_src_endofpacket)                                                  //          .endofpacket
	);

	nios2_a2gx_onchip_addr_router_001 addr_router_001 (
		.sink_ready         (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_ready),         //      sink.ready
		.sink_valid         (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_valid),         //          .valid
		.sink_data          (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_data),          //          .data
		.sink_startofpacket (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_startofpacket), //          .startofpacket
		.sink_endofpacket   (cpu_instruction_master_translator_avalon_universal_master_0_agent_cp_endofpacket),   //          .endofpacket
		.clk                (clk_clk),                                                                            //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                                     // clk_reset.reset
		.src_ready          (addr_router_001_src_ready),                                                          //       src.ready
		.src_valid          (addr_router_001_src_valid),                                                          //          .valid
		.src_data           (addr_router_001_src_data),                                                           //          .data
		.src_channel        (addr_router_001_src_channel),                                                        //          .channel
		.src_startofpacket  (addr_router_001_src_startofpacket),                                                  //          .startofpacket
		.src_endofpacket    (addr_router_001_src_endofpacket)                                                     //          .endofpacket
	);

	nios2_a2gx_onchip_id_router id_router (
		.sink_ready         (timer_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (timer_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (timer_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (timer_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (timer_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clk_clk),                                                             //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                      // clk_reset.reset
		.src_ready          (id_router_src_ready),                                                 //       src.ready
		.src_valid          (id_router_src_valid),                                                 //          .valid
		.src_data           (id_router_src_data),                                                  //          .data
		.src_channel        (id_router_src_channel),                                               //          .channel
		.src_startofpacket  (id_router_src_startofpacket),                                         //          .startofpacket
		.src_endofpacket    (id_router_src_endofpacket)                                            //          .endofpacket
	);

	nios2_a2gx_onchip_id_router_001 id_router_001 (
		.sink_ready         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (onchip_mem_0_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clk_clk),                                                                    //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                             // clk_reset.reset
		.src_ready          (id_router_001_src_ready),                                                    //       src.ready
		.src_valid          (id_router_001_src_valid),                                                    //          .valid
		.src_data           (id_router_001_src_data),                                                     //          .data
		.src_channel        (id_router_001_src_channel),                                                  //          .channel
		.src_startofpacket  (id_router_001_src_startofpacket),                                            //          .startofpacket
		.src_endofpacket    (id_router_001_src_endofpacket)                                               //          .endofpacket
	);

	nios2_a2gx_onchip_id_router id_router_002 (
		.sink_ready         (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (parallel_out_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clk_clk),                                                                    //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                             // clk_reset.reset
		.src_ready          (id_router_002_src_ready),                                                    //       src.ready
		.src_valid          (id_router_002_src_valid),                                                    //          .valid
		.src_data           (id_router_002_src_data),                                                     //          .data
		.src_channel        (id_router_002_src_channel),                                                  //          .channel
		.src_startofpacket  (id_router_002_src_startofpacket),                                            //          .startofpacket
		.src_endofpacket    (id_router_002_src_endofpacket)                                               //          .endofpacket
	);

	nios2_a2gx_onchip_id_router id_router_003 (
		.sink_ready         (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_ready),         //      sink.ready
		.sink_valid         (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_valid),         //          .valid
		.sink_data          (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_data),          //          .data
		.sink_startofpacket (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_startofpacket), //          .startofpacket
		.sink_endofpacket   (parallel_in_s1_translator_avalon_universal_slave_0_agent_rp_endofpacket),   //          .endofpacket
		.clk                (clk_clk),                                                                   //       clk.clk
		.reset              (rst_controller_reset_out_reset),                                            // clk_reset.reset
		.src_ready          (id_router_003_src_ready),                                                   //       src.ready
		.src_valid          (id_router_003_src_valid),                                                   //          .valid
		.src_data           (id_router_003_src_data),                                                    //          .data
		.src_channel        (id_router_003_src_channel),                                                 //          .channel
		.src_startofpacket  (id_router_003_src_startofpacket),                                           //          .startofpacket
		.src_endofpacket    (id_router_003_src_endofpacket)                                              //          .endofpacket
	);

	altera_merlin_traffic_limiter #(
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.PKT_TRANS_POSTED          (54),
		.MAX_OUTSTANDING_RESPONSES (7),
		.PIPELINED                 (0),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.VALID_WIDTH               (4),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter (
		.clk                    (clk_clk),                        //       clk.clk
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
		.PKT_DEST_ID_H             (76),
		.PKT_DEST_ID_L             (74),
		.PKT_TRANS_POSTED          (54),
		.MAX_OUTSTANDING_RESPONSES (7),
		.PIPELINED                 (0),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.VALID_WIDTH               (4),
		.ENFORCE_ORDER             (1),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32)
	) limiter_001 (
		.clk                    (clk_clk),                               //       clk.clk
		.reset                  (rst_controller_reset_out_reset),        // clk_reset.reset
		.cmd_sink_ready         (addr_router_001_src_ready),             //  cmd_sink.ready
		.cmd_sink_valid         (addr_router_001_src_valid),             //          .valid
		.cmd_sink_data          (addr_router_001_src_data),              //          .data
		.cmd_sink_channel       (addr_router_001_src_channel),           //          .channel
		.cmd_sink_startofpacket (addr_router_001_src_startofpacket),     //          .startofpacket
		.cmd_sink_endofpacket   (addr_router_001_src_endofpacket),       //          .endofpacket
		.cmd_src_ready          (limiter_001_cmd_src_ready),             //   cmd_src.ready
		.cmd_src_data           (limiter_001_cmd_src_data),              //          .data
		.cmd_src_channel        (limiter_001_cmd_src_channel),           //          .channel
		.cmd_src_startofpacket  (limiter_001_cmd_src_startofpacket),     //          .startofpacket
		.cmd_src_endofpacket    (limiter_001_cmd_src_endofpacket),       //          .endofpacket
		.rsp_sink_ready         (rsp_xbar_demux_001_src1_ready),         //  rsp_sink.ready
		.rsp_sink_valid         (rsp_xbar_demux_001_src1_valid),         //          .valid
		.rsp_sink_channel       (rsp_xbar_demux_001_src1_channel),       //          .channel
		.rsp_sink_data          (rsp_xbar_demux_001_src1_data),          //          .data
		.rsp_sink_startofpacket (rsp_xbar_demux_001_src1_startofpacket), //          .startofpacket
		.rsp_sink_endofpacket   (rsp_xbar_demux_001_src1_endofpacket),   //          .endofpacket
		.rsp_src_ready          (limiter_001_rsp_src_ready),             //   rsp_src.ready
		.rsp_src_valid          (limiter_001_rsp_src_valid),             //          .valid
		.rsp_src_data           (limiter_001_rsp_src_data),              //          .data
		.rsp_src_channel        (limiter_001_rsp_src_channel),           //          .channel
		.rsp_src_startofpacket  (limiter_001_rsp_src_startofpacket),     //          .startofpacket
		.rsp_src_endofpacket    (limiter_001_rsp_src_endofpacket),       //          .endofpacket
		.cmd_src_valid          (limiter_001_cmd_valid_data)             // cmd_valid.data
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_BEGIN_BURST           (70),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.OUT_BYTE_CNT_H            (60),
		.OUT_BURSTWRAP_H           (69),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (63),
		.BURSTWRAP_CONST_VALUE     (63)
	) burst_adapter (
		.clk                   (clk_clk),                             //       cr0.clk
		.reset                 (rst_controller_reset_out_reset),      // cr0_reset.reset
		.sink0_valid           (cmd_xbar_demux_src0_valid),           //     sink0.valid
		.sink0_data            (cmd_xbar_demux_src0_data),            //          .data
		.sink0_channel         (cmd_xbar_demux_src0_channel),         //          .channel
		.sink0_startofpacket   (cmd_xbar_demux_src0_startofpacket),   //          .startofpacket
		.sink0_endofpacket     (cmd_xbar_demux_src0_endofpacket),     //          .endofpacket
		.sink0_ready           (cmd_xbar_demux_src0_ready),           //          .ready
		.source0_valid         (burst_adapter_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_source0_data),          //          .data
		.source0_channel       (burst_adapter_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_source0_ready)          //          .ready
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_BEGIN_BURST           (70),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.OUT_BYTE_CNT_H            (60),
		.OUT_BURSTWRAP_H           (69),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (31),
		.BURSTWRAP_CONST_VALUE     (31)
	) burst_adapter_001 (
		.clk                   (clk_clk),                                 //       cr0.clk
		.reset                 (rst_controller_reset_out_reset),          // cr0_reset.reset
		.sink0_valid           (cmd_xbar_mux_001_src_valid),              //     sink0.valid
		.sink0_data            (cmd_xbar_mux_001_src_data),               //          .data
		.sink0_channel         (cmd_xbar_mux_001_src_channel),            //          .channel
		.sink0_startofpacket   (cmd_xbar_mux_001_src_startofpacket),      //          .startofpacket
		.sink0_endofpacket     (cmd_xbar_mux_001_src_endofpacket),        //          .endofpacket
		.sink0_ready           (cmd_xbar_mux_001_src_ready),              //          .ready
		.source0_valid         (burst_adapter_001_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_001_source0_data),          //          .data
		.source0_channel       (burst_adapter_001_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_001_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_001_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_001_source0_ready)          //          .ready
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_BEGIN_BURST           (70),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.OUT_BYTE_CNT_H            (60),
		.OUT_BURSTWRAP_H           (69),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (63),
		.BURSTWRAP_CONST_VALUE     (63)
	) burst_adapter_002 (
		.clk                   (clk_clk),                                 //       cr0.clk
		.reset                 (rst_controller_reset_out_reset),          // cr0_reset.reset
		.sink0_valid           (cmd_xbar_demux_src2_valid),               //     sink0.valid
		.sink0_data            (cmd_xbar_demux_src2_data),                //          .data
		.sink0_channel         (cmd_xbar_demux_src2_channel),             //          .channel
		.sink0_startofpacket   (cmd_xbar_demux_src2_startofpacket),       //          .startofpacket
		.sink0_endofpacket     (cmd_xbar_demux_src2_endofpacket),         //          .endofpacket
		.sink0_ready           (cmd_xbar_demux_src2_ready),               //          .ready
		.source0_valid         (burst_adapter_002_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_002_source0_data),          //          .data
		.source0_channel       (burst_adapter_002_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_002_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_002_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_002_source0_ready)          //          .ready
	);

	altera_merlin_burst_adapter #(
		.PKT_ADDR_H                (52),
		.PKT_ADDR_L                (36),
		.PKT_BEGIN_BURST           (70),
		.PKT_BYTE_CNT_H            (63),
		.PKT_BYTE_CNT_L            (58),
		.PKT_BYTEEN_H              (35),
		.PKT_BYTEEN_L              (32),
		.PKT_BURSTWRAP_H           (69),
		.PKT_BURSTWRAP_L           (64),
		.PKT_TRANS_COMPRESSED_READ (53),
		.PKT_TRANS_WRITE           (55),
		.PKT_TRANS_READ            (56),
		.ST_DATA_W                 (78),
		.ST_CHANNEL_W              (4),
		.OUT_BYTE_CNT_H            (60),
		.OUT_BURSTWRAP_H           (69),
		.COMPRESSED_READ_SUPPORT   (1),
		.BURSTWRAP_CONST_MASK      (63),
		.BURSTWRAP_CONST_VALUE     (63)
	) burst_adapter_003 (
		.clk                   (clk_clk),                                 //       cr0.clk
		.reset                 (rst_controller_reset_out_reset),          // cr0_reset.reset
		.sink0_valid           (cmd_xbar_demux_src3_valid),               //     sink0.valid
		.sink0_data            (cmd_xbar_demux_src3_data),                //          .data
		.sink0_channel         (cmd_xbar_demux_src3_channel),             //          .channel
		.sink0_startofpacket   (cmd_xbar_demux_src3_startofpacket),       //          .startofpacket
		.sink0_endofpacket     (cmd_xbar_demux_src3_endofpacket),         //          .endofpacket
		.sink0_ready           (cmd_xbar_demux_src3_ready),               //          .ready
		.source0_valid         (burst_adapter_003_source0_valid),         //   source0.valid
		.source0_data          (burst_adapter_003_source0_data),          //          .data
		.source0_channel       (burst_adapter_003_source0_channel),       //          .channel
		.source0_startofpacket (burst_adapter_003_source0_startofpacket), //          .startofpacket
		.source0_endofpacket   (burst_adapter_003_source0_endofpacket),   //          .endofpacket
		.source0_ready         (burst_adapter_003_source0_ready)          //          .ready
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS        (1),
		.OUTPUT_RESET_SYNC_EDGES ("deassert"),
		.SYNC_DEPTH              (2)
	) rst_controller (
		.reset_in0  (~reset_reset_n),                 // reset_in0.reset
		.clk        (clk_clk),                        //       clk.clk
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

	nios2_a2gx_onchip_cmd_xbar_demux cmd_xbar_demux (
		.clk                (clk_clk),                           //        clk.clk
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
		.src1_endofpacket   (cmd_xbar_demux_src1_endofpacket),   //           .endofpacket
		.src2_ready         (cmd_xbar_demux_src2_ready),         //       src2.ready
		.src2_valid         (cmd_xbar_demux_src2_valid),         //           .valid
		.src2_data          (cmd_xbar_demux_src2_data),          //           .data
		.src2_channel       (cmd_xbar_demux_src2_channel),       //           .channel
		.src2_startofpacket (cmd_xbar_demux_src2_startofpacket), //           .startofpacket
		.src2_endofpacket   (cmd_xbar_demux_src2_endofpacket),   //           .endofpacket
		.src3_ready         (cmd_xbar_demux_src3_ready),         //       src3.ready
		.src3_valid         (cmd_xbar_demux_src3_valid),         //           .valid
		.src3_data          (cmd_xbar_demux_src3_data),          //           .data
		.src3_channel       (cmd_xbar_demux_src3_channel),       //           .channel
		.src3_startofpacket (cmd_xbar_demux_src3_startofpacket), //           .startofpacket
		.src3_endofpacket   (cmd_xbar_demux_src3_endofpacket)    //           .endofpacket
	);

	nios2_a2gx_onchip_cmd_xbar_demux_001 cmd_xbar_demux_001 (
		.clk                (clk_clk),                               //        clk.clk
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
		.src0_endofpacket   (cmd_xbar_demux_001_src0_endofpacket)    //           .endofpacket
	);

	nios2_a2gx_onchip_cmd_xbar_mux_001 cmd_xbar_mux_001 (
		.clk                 (clk_clk),                               //       clk.clk
		.reset               (rst_controller_reset_out_reset),        // clk_reset.reset
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
		.sink1_ready         (cmd_xbar_demux_001_src0_ready),         //     sink1.ready
		.sink1_valid         (cmd_xbar_demux_001_src0_valid),         //          .valid
		.sink1_channel       (cmd_xbar_demux_001_src0_channel),       //          .channel
		.sink1_data          (cmd_xbar_demux_001_src0_data),          //          .data
		.sink1_startofpacket (cmd_xbar_demux_001_src0_startofpacket), //          .startofpacket
		.sink1_endofpacket   (cmd_xbar_demux_001_src0_endofpacket)    //          .endofpacket
	);

	nios2_a2gx_onchip_rsp_xbar_demux rsp_xbar_demux (
		.clk                (clk_clk),                           //       clk.clk
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
		.src0_endofpacket   (rsp_xbar_demux_src0_endofpacket)    //          .endofpacket
	);

	nios2_a2gx_onchip_rsp_xbar_demux_001 rsp_xbar_demux_001 (
		.clk                (clk_clk),                               //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_001_src_ready),               //      sink.ready
		.sink_channel       (id_router_001_src_channel),             //          .channel
		.sink_data          (id_router_001_src_data),                //          .data
		.sink_startofpacket (id_router_001_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_001_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_001_src_valid),               //          .valid
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

	nios2_a2gx_onchip_rsp_xbar_demux rsp_xbar_demux_002 (
		.clk                (clk_clk),                               //       clk.clk
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

	nios2_a2gx_onchip_rsp_xbar_demux rsp_xbar_demux_003 (
		.clk                (clk_clk),                               //       clk.clk
		.reset              (rst_controller_reset_out_reset),        // clk_reset.reset
		.sink_ready         (id_router_003_src_ready),               //      sink.ready
		.sink_channel       (id_router_003_src_channel),             //          .channel
		.sink_data          (id_router_003_src_data),                //          .data
		.sink_startofpacket (id_router_003_src_startofpacket),       //          .startofpacket
		.sink_endofpacket   (id_router_003_src_endofpacket),         //          .endofpacket
		.sink_valid         (id_router_003_src_valid),               //          .valid
		.src0_ready         (rsp_xbar_demux_003_src0_ready),         //      src0.ready
		.src0_valid         (rsp_xbar_demux_003_src0_valid),         //          .valid
		.src0_data          (rsp_xbar_demux_003_src0_data),          //          .data
		.src0_channel       (rsp_xbar_demux_003_src0_channel),       //          .channel
		.src0_startofpacket (rsp_xbar_demux_003_src0_startofpacket), //          .startofpacket
		.src0_endofpacket   (rsp_xbar_demux_003_src0_endofpacket)    //          .endofpacket
	);

	nios2_a2gx_onchip_rsp_xbar_mux rsp_xbar_mux (
		.clk                 (clk_clk),                               //       clk.clk
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
		.sink1_endofpacket   (rsp_xbar_demux_001_src0_endofpacket),   //          .endofpacket
		.sink2_ready         (rsp_xbar_demux_002_src0_ready),         //     sink2.ready
		.sink2_valid         (rsp_xbar_demux_002_src0_valid),         //          .valid
		.sink2_channel       (rsp_xbar_demux_002_src0_channel),       //          .channel
		.sink2_data          (rsp_xbar_demux_002_src0_data),          //          .data
		.sink2_startofpacket (rsp_xbar_demux_002_src0_startofpacket), //          .startofpacket
		.sink2_endofpacket   (rsp_xbar_demux_002_src0_endofpacket),   //          .endofpacket
		.sink3_ready         (rsp_xbar_demux_003_src0_ready),         //     sink3.ready
		.sink3_valid         (rsp_xbar_demux_003_src0_valid),         //          .valid
		.sink3_channel       (rsp_xbar_demux_003_src0_channel),       //          .channel
		.sink3_data          (rsp_xbar_demux_003_src0_data),          //          .data
		.sink3_startofpacket (rsp_xbar_demux_003_src0_startofpacket), //          .startofpacket
		.sink3_endofpacket   (rsp_xbar_demux_003_src0_endofpacket)    //          .endofpacket
	);

	nios2_a2gx_onchip_irq_mapper irq_mapper (
		.clk           (clk_clk),                        //       clk.clk
		.reset         (rst_controller_reset_out_reset), // clk_reset.reset
		.receiver0_irq (irq_mapper_receiver0_irq),       // receiver0.irq
		.receiver1_irq (irq_mapper_receiver1_irq),       // receiver1.irq
		.sender_irq    (cpu_d_irq_irq)                   //    sender.irq
	);

endmodule
