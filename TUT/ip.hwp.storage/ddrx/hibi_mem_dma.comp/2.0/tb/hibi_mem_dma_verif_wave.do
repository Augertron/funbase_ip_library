onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hibi_mem_dma_tb/clk
add wave -noupdate /hibi_mem_dma_tb/rst_n
add wave -noupdate /hibi_mem_dma_tb/test_start
add wave -noupdate /hibi_mem_dma_tb/test_started
add wave -noupdate /hibi_mem_dma_tb/test_done
add wave -noupdate -radix unsigned /hibi_mem_dma_tb/test_error
add wave -noupdate /hibi_mem_dma_tb/mem_init_done
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_addr_in
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_data_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_comm_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_empty_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_re_out
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_addr_out
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_data_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_comm_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_full_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_we_out
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_addr_in
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_data_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_comm_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_empty_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_re_out
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_data_out
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_addr_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_comm_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_full_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_we_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_init_done_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_wr_req_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_burst_begin_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rd_req_out
add wave -noupdate -radix hexadecimal /hibi_mem_dma_tb/hibi_mem_dma_0/mem_addr_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_ready_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rdata_valid_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_wdata_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rdata_in
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_be_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_burst_size_out
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_re_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_rd_data
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_rd_addr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_rd_data_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_rd_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_rd_empty_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_re_stall_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_we_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_wr_data_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_wr_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_msg_ret_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_re_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_data
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_addr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_comm
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_data_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_comm_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_empty_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_we_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_re_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_addr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_data
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_comm
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_full
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_one_p
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_empty
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_one_d
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_wdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_rdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_re
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_data_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_comm_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_empty_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_one_d_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_we_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_data
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_addr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_data_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_false_wr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_false_wr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_false_rd_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_rd_fifo_false_rd_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_load_state
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_load_index_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_load_index_d1_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_chan_conf_index_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_load_data_part_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_load_data_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/cur_rw_chan_rd_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/cur_rw_chan_wr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/cur_rw_chan_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_state_mem_raddr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_state_mem_rdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_state_mem_waddr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_state_mem_wdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_state_mem_we_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_state_mem_we
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_we_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_we_0_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_we_1_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_addr_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_addr_1_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_wdata_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_wdata_1
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_rdata_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_mem_rdata_1
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_mem_addr_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_amount_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_inc_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_interval_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_interval_cnt_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_interval_inc_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_be_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_started_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_done_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_mem_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_amount_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_inc_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_interval_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_interval_cnt_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_addr_interval_inc_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_be_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_started_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_conf_done_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/load_wr_conf_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/load_wr_conf_d1_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/load_wr_conf_delayed_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_we_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_we_0_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_we_1_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_addr_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_addr_1_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_wdata_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_wdata_1
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_rdata_0
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_mem_rdata_1
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_mem_addr_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_amount_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_inc_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_interval_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_interval_cnt_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_interval_inc_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_hibi_ret_addr_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_started_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_done_rv
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_mem_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_amount_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_inc_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_interval_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_interval_cnt_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_addr_interval_inc_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_hibi_ret_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_started_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_conf_done_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_conf_mem_init_done_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/wr_chan_reserve_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_chan_reserve_busy_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rw_req_type_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_chan_reserve_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_we
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_re_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_wdata_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_rdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_full
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_empty
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/cur_wr_chan_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_wr_chan_init_done_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_data_fifo_re_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_data_fifo_re_tmp
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/hibi_wr_cnt_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/ret_addr_we_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/ret_addr_re_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/ret_addr_re_tmp
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/ret_addr_wdata_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/next_rd_chan_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/free_rd_chan_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/cur_rd_chan_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_chan_empty_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/rd_chan_full_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_wr_req_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rd_req_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_addr_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_wdata_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_be_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_burst_begin_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_wr_delayed_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rd_delayed_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rd_cnt_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/mem_rd_state_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_hibi_rd_data
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_hibi_rd_addr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_hibi_rd_comm
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_hibi_rd_empty
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_hibi_rd_addr_valid
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_conf_mem_rdata
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_mem_addr
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_amount
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_addr_inc
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_addr_interval
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_addr_interval_cnt
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_addr_interval_inc
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_be
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_conf_started
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_conf_done
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_conf_mem_stall_r
add wave -noupdate /hibi_mem_dma_tb/hibi_mem_dma_0/debug_wr_chan_error
add wave -noupdate /hibi_mem_dma_tb/debug_wdata_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49307029 ps} 0}
configure wave -namecolwidth 343
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {49207036 ps} {49393788 ps}
