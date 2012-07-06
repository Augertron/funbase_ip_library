onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 BUS
add wave -noupdate -format Logic /tb_dct_top/bus_av_in
add wave -noupdate -format Literal /tb_dct_top/bus_comm_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/bus_data_in
add wave -noupdate -format Logic /tb_dct_top/bus_full_in
add wave -noupdate -format Logic /tb_dct_top/bus_lock_in
add wave -noupdate -divider -height 30 {DCT TO HIBI}
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_av_out
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_data_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_we_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_full_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_comm_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_av_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_data_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_empty_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_re_out
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/hibi_re_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/hibi_comm_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/rst_n
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/main_state
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/result_send_state
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/control_word_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/quant_param_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/qp_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/loadqp_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/loadqp_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/intra_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/intra_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/chroma_out
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/quant_ready4col_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/dct_ready4col_in
add wave -noupdate -format Literal -radix decimal /tb_dct_top/dct_to_hibi_1_12/rx_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/data_dct_out
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/wr_dct_out
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/result_is_quant_r
add wave -noupdate -format Literal /tb_dct_top/dct_to_hibi_1_12/tx_data_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/tx_fifo_data_from
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_fifo_empty
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_fifo_full
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_fifo_re
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_re
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_data_from
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_we
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_data_to_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/data_idct_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/wr_idct_in
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_empty
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_full
add wave -noupdate -format Literal /tb_dct_top/dct_to_hibi_1_12/tx_i_fifo_value_sel_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_data_from
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_we
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_data_to_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/data_quant_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/wr_quant_in
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_empty
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_full
add wave -noupdate -format Logic /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_re
add wave -noupdate -format Literal /tb_dct_top/dct_to_hibi_1_12/tx_q_fifo_value_sel_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/dct_to_hibi_1_12/wr_dct_out
add wave -noupdate -divider -height 30 CPU
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/av_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/av_out
add wave -noupdate -format Literal -radix hexadecimal -expand /tb_dct_top/tb_dct_cpu_i/data_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/clk
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/clk_dctqidct_fast
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/comm_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/comm_out
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/comm_width_g
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/d_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/data_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/data_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/empty_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/re_out
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/data_out
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/data_width_g
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_chroma_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_data_dct_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_data_idct_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_data_quant_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_intra_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_loadqp_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_qp_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_wr_dct_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_wr_idct_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/dct_wr_quant_in
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/free_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/full_in
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/i_counter_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/intra
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/q_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/qp
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/qp_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/res_i_cnt_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/res_q_cnt_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/result_is_quant_r
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/rst_n
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/rx_counter_r
add wave -noupdate -format Literal -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/send_ctrl
add wave -noupdate -format Logic -radix hexadecimal /tb_dct_top/tb_dct_cpu_i/we_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {131357 ns} 0}
configure wave -namecolwidth 358
configure wave -valuecolwidth 88
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
update
WaveRestoreZoom {131 us} {131538 ns}
bookmark add wave bookmark0 {{155995 ns} {157696 ns}} 8
