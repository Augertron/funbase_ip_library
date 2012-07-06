# Script compiles all vhdl-files and generates a makefile for them
# This script is tested for Modelsim version 6.6a 

.main clear

echo " Generating libraries for files"

echo "Processing component TUT:ip.hwp.communication:basic_tester_tx:1.0"
echo "Processing file set rtl of component TUT:ip.hwp.communication:basic_tester_tx:1.0."
echo " Adding library work"
vlib work
vcom -check_synthesis D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/basic_tester/1.0/vhd/txt_util.vhd
vcom -check_synthesis D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/basic_tester/1.0/vhd/basic_tester_pkg.vhd
vcom -check_synthesis D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/basic_tester/1.0/vhd/basic_tester_tx.vhd

echo "Processing component TUT:ip.hwp.interface:clk_gen:1.0"
echo "Processing file set behavioral of component TUT:ip.hwp.interface:clk_gen:1.0."
vcom -check_synthesis D:/user/ege/Svn/daci_ip/trunk/ip.hwp.interface/clock/1.0/vhd/clk_gen.vhd

echo "Processing component TUT:ip.hwp.communication:basic_tester_rx:1.0"
echo "Processing file set rtl of component TUT:ip.hwp.communication:basic_tester_rx:1.0."
vcom -check_synthesis D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/basic_tester/1.0/vhd/basic_tester_rx.vhd

echo "Processing component TUT:ip.hwp.interface:rst_gen:1.0"
echo "Processing file set behavioral of component TUT:ip.hwp.interface:rst_gen:1.0."
vcom  D:/user/ege/Svn/daci_ip/trunk/ip.hwp.interface/reset/1.0/vhd/rst_gen.vhd

echo "Processing component TUT:ip.hwp.communication:hibi_segment_small:3.0"
echo "Processing file set hdlSources of component TUT:ip.hwp.communication:hibi_segment_small:3.0."
echo " Adding library hibi"
vlib hibi
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/hibiv3_pkg.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/addr_data_demux_read.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/addr_data_mux_write.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/addr_decoder.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/cfg_init_pkg.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/cfg_mem.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/double_fifo_demux_wr.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/double_fifo_mux_rd.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/dyn_arb.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/fifo_demux_wr.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/fifo_mux_rd.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/lfsr.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/receiver.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/rx_control.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/transmitter.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/tx_control.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/hibi_wrapper_r1.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/hibi_wrapper_r3.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/hibi_wrapper_r4.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/hibi_segment_small.vhd
vcom -quiet -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.communication/hibi/3.0/vhd/hibi_segment_v3.vhd
echo "Processing file set fifo_rtl of component TUT:ip.hwp.communication:hibi_segment_small:3.0."
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/fifo/1.0/vhd/fifo.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/multiclk_fifo/1.0/vhd/mixed_clk_fifo_v3.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/multiclk_fifo/1.0/vhd/multiclk_fifo.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/multiclk_fifo/1.0/vhd/re_pulse_synchronizer.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/multiclk_fifo/1.0/vhd/we_pulse_synchronizer.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/synchronizer/1.0/vhd/aif_we_top.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/synchronizer/1.0/vhd/aif_read_in.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/synchronizer/1.0/vhd/aif_read_out.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/synchronizer/1.0/vhd/aif_read_top.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/synchronizer/1.0/vhd/aif_we_in.vhd
vcom -check_synthesis -work hibi D:/user/ege/Svn/daci_ip/trunk/ip.hwp.storage/fifos/synchronizer/1.0/vhd/aif_we_out.vhd

echo "Processing component TUT:soc:basic_tester_hibi_example:1.0"
echo "Processing file set structural_vhdlSource of component TUT:soc:basic_tester_hibi_example:1.0."
vcom -quiet -check_synthesis -work work D:/user/ege/Svn/daci_ip/trunk/soc/basic_tester_example/1.0/vhd/basic_tester_hibi_example.vhd

echo " Creating a new Makefile"

# remove the old makefile
rm -f Makefile
vmake work > Makefile
echo " Script has been executed "
