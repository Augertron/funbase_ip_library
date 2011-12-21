//--------------------------------------------------------------------------//
// Title:       a2gx_pcie_top.v                                             //
// Rev:         Rev 3                                                      //
//--------------------------------------------------------------------------//
// Description: Golden Top file contains Stratix IV GX PCI Express Board    //
//              pins and I/O Standards.                                     //
//--------------------------------------------------------------------------//
// Revision History:                                                        //
// 1: Initial															    //
// 2: Swap user_pb[1:0] with ddr2_dimm_a[4:0]								//
// 3: Correct pin locations.												//
//------ 1 ------- 2 ------- 3 ------- 4 ------- 5 ------- 6 ------- 7 ------7
//------ 0 ------- 0 ------- 0 ------- 0 ------- 0 ------- 0 ------- 0 ------8
//Copyright © 2009 Altera Corporation. All rights reserved.  Altera products
//are protected under numerous U.S. and foreign patents, maskwork rights,
//copyrights and other intellectual property laws.
//                 
//This reference design file, and your use thereof, is subject to and
//governed by the terms and conditions of the applicable Altera Reference
//Design License Agreement.  By using this reference design file, you
//indicate your acceptance of such terms and conditions between you and
//Altera Corporation.  In the event that you do not agree with such terms and
//conditions, you may not use the reference design file. Please promptly                         
//destroy any copies you have made.
//
//This reference design file being provided on an "as-is" basis and as an
//accommodation and therefore all warranties, representations or guarantees
//of any kind(whether express, implied or statutory) including, without
//limitation, warranties of merchantability, non-infringement, or fitness for
//a particular purpose, are specifically disclaimed.  By making this
//reference design file available, Altera expressly does not recommend,
//suggest or require that this reference design file be used in combination 
//with any other product not provided by Altera
//----------------------------------------------------------------------------

//`default_nettype none

module a2gx_dev_kit_golden_top(
//CLK-Inputs---------------------------//15 pins
    //wired through XCVR blocks, all AC-coupled)
//    input           clkin_ref_q1_1_p,     //LVDS    //adj. defaut 100.000 MHz osc
//    input           clkin_ref_q1_2_p,     //LVDS    //adj. defaut 125.000 MHz osc
//    input           clkin_ref_q2_p,     //LVDS      //adj. default 125.000 MHz osc
//    input           clkin_ref_q3_p,     //LVDS      //adj. default 125.000 MHz osc
//    input   	    clkin_155_p,	   //LVPECL    //155.520 MHz osc 
    input           clkin_bot_p,       //LVDS      //ADJ default 100.000 MHz osc or sma in(Requires external termination.)
    input           clkin_top_p,       //LVDS      //ADJ default 125.000 MHz osc(Requires external termination.)
    output          clkout_sma,        //1.8V      //PLL CLK sma out

	
////DDR3-SDRAM-PORTS  -> 64Mx16 Interface ---------------------//49 pins
/*    output [14:0]  ddr3_a,          //SSTL15    //Address(1Gb max)
    output [2:0]   ddr3_ba,         //SSTL15    //Bank address
    inout  [15:0]  ddr3_dq,         //SSTL15    //Data
    inout  [1:0]   ddr3_dqs_p,      //SSTL15    //Strobe Pos
    inout  [1:0]   ddr3_dqs_n,      //SSTL15    //Strobe Neg
    output [1:0]   ddr3_dm,         //SSTL15    //Byte write mask
    output         ddr3_wen,        //SSTL15    //Write enable
    output         ddr3_rasn,       //SSTL15    //Row address select
    output         ddr3_casn,       //SSTL15    //Column address select
    inout          ddr3_ck_p,       //SSTL15    //System Clock Pos
    inout          ddr3_ck_n,       //SSTL15    //System Clock Neg
    output         ddr3_cke,        //SSTL15    //Clock Enable
    output         ddr3_csn,        //SSTL15    //Chip Select
    output         ddr3_resetn,     //SSTL15    //Reset
    output         ddr3_odt,        //SSTL15    //On-die termination enable*/
 
 //DDR2 SDRAM SoDIMM -------------------------------------//x64 -> 117 pins(Default)
	//x64 -> 125 pins
    output [15:0]  ddr2_dimm_addr,	    //SSTL18    //Address		OK
    output [2:0]   ddr2_dimm_ba,    //SSTL18    //Bank address  OK
    inout  [63:0]  ddr2_dimm_dq,         //SSTL18    //Data x64 SODIMM		OK
    inout  [7:0]   ddr2_dimm_dqs,      //SSTL18    //Strobe Pos			OK
    inout  [7:0]   ddr2_dimm_dqs_n,      //SSTL18    //Strobe Neg			OK
    output [7:0]   ddr2_dimm_dm,         //SSTL18    //Byte write mask  OK
    output         ddr2_dimm_cke,    //SSTL18   //System Clock Enable  OK
    inout  [1:0]   ddr2_dimm_clk,   //SSTL18   //System Clock Pos     OK
    inout  [1:0]   ddr2_dimm_clk_n,   //SSTL18    //System Clock Neg		OK
    output         ddr2_dimm_we_n,         //SSTL18    //Write enable		OK
    output         ddr2_dimm_ras_n,       //SSTL18    //Row address select		OK
    output         ddr2_dimm_cas_n,       //SSTL18    //Column address select  OK
   output	  ddr2_dimm_cs_n,        //SSTL18    //Chip Select           OK
//    output         ddr2_dimm_resetn,     //SSTL18    //Reset
    output    ddr2_dimm_odt,        //SSTL18    //On-die termination enable	OK

////////////////////////////////////////////////////////////////// 
//ETHERNET-10/100/1000-RGMII-----------
    output  	   enet_gtx_clk,      //2.5V  //RGMII Transmit Clock
    output [3:0]   enet_tx_d,        //2.5V  //TX to PHY
    input  [3:0]   enet_rx_d,        //2.5V  //RX from PHY
    output         enet_tx_en,       //2.5V  //RGMII Transmit Control
    input	       enet_rx_clk,      //2.5V  //Derived Received Clock
    input          enet_rx_dv,       //2.5V  //RGMII Receive Control 
    output         enet_resetn,        //2.5V      //Reset to PHY(TR=0)
    output         enet_mdc,           //2.5V      //MDIO Control(TR=0)
    inout          enet_mdio,          //2.5V      //MDIO Data(TR=0)
    input          enet_intn,           //2.5V      //MDIO Interrupt(TR=0)
///////////////////////////////////////////////////////////////////

//FLASH-SRAM-MAX-------------FSM-Bus---//90 pins
    output [25:0]  fsm_a,              //2.5V      //FSM Address Bus(1Gb Flash)
    inout  [31:0]  fsm_d,              //2.5V      //FSM Data Bus
    output         flash_clk,          //2.5V  
    output         flash_cen,          //2.5V  
    output         flash_oen,          //2.5V
    output         flash_wen,          //2.5V
    output         flash_advn,         //2.5V
    input          flash_rdybsyn,      //2.5V
    output         flash_resetn,       //2.5V     //(TR=0)
    output         sram_clk,           //2.5V
    output         sram_cen,           //2.5V
    inout  [3:0]   sram_dqp,           //2.5V     //Parity bits only go to SRAM
    output [3:0]   sram_bwn,           //2.5V
    output         sram_gwn,           //2.5V
    output         sram_bwen,          //2.5V
    output         sram_oen,           //2.5V
    output         sram_advn,          //2.5V
    output         sram_adspn,         //2.5V
    output         sram_adscn,         //2.5V
    output         sram_zz,            //2.5V     //(TR=0)
/*    output         max2_clk,           //1.8V
    output         max2_csn,           //1.8V
    output [3:0]   max2_ben,           //1.8V
    output         max2_oen,           //1.8V
    output         max2_wen,           //1.8V*/

////LCD----------------------------------//11 pins
    inout  [7:0]   lcd_data,           //2.5V
    output         lcd_d_cn,           //2.5V
    output         lcd_wen,            //2.5V
    output         lcd_csn,            //2.5V
//
////User-IO------------------------------//22 pins
    input  [3:0]   user_dipsw,         //1.8V/2.5V     //(TR=0)
//    output [7:0]   user_led,           //2.5V
    output [3:0]   user_led,           //2.5V
    input  [1:0]   user_pb,            //1.8V/2.5V     //(TR=0)
//    input  [1:0]   user_pb,            //1.8V/2.5V     //(TR=0)
    input          cpu_resetn,         //2.5V(DEV_CLRn)    //(TR=0)
  
//// //PCI-EXPRESS-EDGE---------------------
    input          pcie_refclk_p,      //HCSL
    output [7:0]   pcie_tx_p,          //1.4V PCML
    input  [7:0]   pcie_rx_p,          //1.4V PCML
//    input          pcie_smbclk,        //2.5V     //(TR=0)
//    inout          pcie_smbdat,        //2.5V     //(TR=0)
    input          pcie_perstn,        //2.5V     //(TR=0)
//    output         pcie_waken,         //2.5V     //(TR=0)
    output         pcie_led_x1,        //2.5V
    output         pcie_led_x4,        //2.5V
    output         pcie_led_x8,        //2.5V
//    output         pcie_led_g2,        //2.5V
    input		   cal_blk_clk,         //Virtual Pin
//HIGH-SPEED-MEZZANINE-CARD------------//198 pins(HSMB is only connected on EP2AGX260 devices)
    //Port A -->   single samtec conn  //107 pins  //------------------
//      output [3:0]   hsma_tx_p,    	 //1.4V PCML
//      input  [3:0]   hsma_rx_p,    	 //1.4V PCML
      //Enable below for CMOS HSMC     
      //inout  [79:0]  hsma_d,           //2.5V
      //Enable below for LVDS HSMC
    output [16:0]  hsma_tx_d_p,        //LVDS  //69 pins
    input  [16:0]  hsma_rx_d_p,        //LVDS
    inout  [3:0]   hsma_d,             //2.5V
    input          hsma_clk_in0,       //2.5V
    output         hsma_clk_out0,      //2.5V
    input          hsma_clk_in_p1,     //LVDS //Requires external termination  
    output         hsma_clk_out_p1,    //LVDS
    input          hsma_clk_in_p2,     //LVDS //Requires external termination
    output         hsma_clk_out_p2,    //LVDS
    inout          hsma_sda,           //2.5V     //(TR=0)
    output         hsma_scl,           //2.5V     //(TR=0)
    output         hsma_tx_led,        //2.5V
    output         hsma_rx_led,        //2.5V
    input          hsma_prsntn ,       //2.5V     //(TR=0)
//    //Port B -->   single samtec conn  //107 pins  //------------------
//      //output [3:0]   hsmb_tx_p,    	 //1.4V PCML   
//      //input  [3:0]   hsmb_rx_p,    	 //1.4V PCML   
//      //Enable below for CMOS HSMC     
//      //inout  [79:0]  hsmb_d,           //2.5V
//      //Enable below for LVDS HSMC  
//    output [16:0]  hsmb_tx_d_p,        //LVDS   
//    input  [16:0]  hsmb_rx_d_p,        //LVDS   
//    inout  [3:0]   hsmb_d,             //2.5V
    input          hsmb_clk_in0       //2.5V   
//    output         hsmb_clk_out0,      //2.5V   
//    output         hsmb_clk_out_p1,    //LVDS   
//    output         hsmb_clk_out_p2,    //LVDS   
//    inout          hsmb_sda,           //2.5V     //(TR=0)   
//    output         hsmb_scl,           //2.5V     //(TR=0)   
//    output         hsmb_tx_led,        //2.5V                 
//    output         hsmb_rx_led,        //2.5V                 
//    input          hsmb_prsntn         //2.5V     //(TR=0)  
);  
  
  reg              L0_led;
  reg     [ 25: 0] alive_cnt;
  reg              alive_led;
  wire             any_rstn;
  reg              any_rstn_r /* synthesis ALTERA_ATTRIBUTE = "SUPPRESS_DA_RULE_INTERNAL=R102"  */;
  reg              any_rstn_rr /* synthesis ALTERA_ATTRIBUTE = "SUPPRESS_DA_RULE_INTERNAL=R102"  */;
  wire             clk_out_buf;
  reg              comp_led;
  reg     [  3: 0] lane_active_led;
  wire             local_rstn;
  wire             in_sys_rstn;
  wire             in_sys_source;
  wire             safe_mode;
  wire    [ 39: 0] test_in;
  wire    [  8: 0] test_out_icm;
  wire             lmi_ack;
  wire    [ 11: 0] lmi_addr;
  wire    [ 31: 0] lmi_din;
  wire    [ 31: 0] lmi_dout;
  wire             lmi_rden;
  wire             lmi_wren;
  wire    [  4: 0] pex_msi_num_icm;
  
  
  wire    [  3: 0] tl_cfg_add;
  wire    [ 31: 0] tl_cfg_ctl;
  wire tl_cfg_ctl_wr;
  wire    [ 52: 0] tl_cfg_sts;
  wire             tl_cfg_sts_wr;
  wire pme_to_sr;
  wire    [  3: 0] lane_act;
  wire    [  4: 0] dl_ltssm;
  wire phystatus_ext;
  wire    [  1: 0] powerdown_ext;
  wire rate_ext;
  wire rc_pll_locked;
  wire    [  8: 0] test_out_int;
  wire reconfig_clk;
  wire clk_pcie;
  wire open_rx_st_err0;
  wire rx_stream_ready0;
  wire rx_stream_valid0;
  wire clk_sys_out;
  
  wire             rx_mask0;
  wire    [  7: 0] rx_st_bardec0;
  wire    [ 15: 0] rx_st_be0;
  wire    [127: 0] rx_st_data0;
  wire             rx_st_empty0;
  wire             rx_st_eop0;
  wire             rx_st_sop0;
  wire    [127: 0] tx_st_data0;
  wire             tx_st_empty0;
  wire             tx_st_eop0;
  wire             tx_st_err0;
  wire             tx_st_sop0;
  wire tx_stream_ready0;
  wire tx_stream_valid0;
  wire    [ 35: 0] tx_stream_cred0;
  wire             app_int_ack_icm;
  wire             app_int_sts_icm;
  wire             app_msi_ack;
  wire    [  4: 0] app_msi_num;
  wire             app_msi_req;
  wire    [  2: 0] app_msi_tc;
  
  wire             srstn;
  
  wire [6:0] cpl_err_in;
  wire [6:0] cpl_err_icm;
  wire open_cplerr_lmi_busy;
  wire [127:0] err_desc;
  
  assign cpl_err_in = 0;
  assign err_desc = 0;
  
  assign tx_st_err0 = 0;
  
  assign safe_mode = 0;
  assign local_rstn = safe_mode | user_pb[0];
  assign in_sys_rstn = local_rstn & in_sys_source;
  assign any_rstn = pcie_perstn & local_rstn;
  assign test_in[39 : 32] = 0;
  assign test_in[31 : 9] = 0;
  assign test_in[8 : 5] = safe_mode ? 4'b0101 : user_dipsw[3:0];
  assign test_in[4 : 0] = 5'b01000;
  
  in_sys_sp  in_sys_sp_0 (
    .probe(0),
    .source(in_sys_source)
  );
  
  //reset Synchronizer
  always @(posedge clk_out_buf or negedge any_rstn)
    begin
      if (any_rstn == 0)
        begin
          any_rstn_r <= 0;
          any_rstn_rr <= 0;
        end
      else 
        begin
          any_rstn_r <= 1;
          any_rstn_rr <= any_rstn_r;
        end
    end


  //LED logic
  always @(posedge clk_out_buf or negedge any_rstn_rr)
    begin
      if (any_rstn_rr == 0)
        begin
          alive_cnt <= 0;
          alive_led <= 0;
          comp_led <= 0;
          L0_led <= 0;
          lane_active_led <= 0;
        end
      else 
        begin
          alive_cnt <= alive_cnt +1;
          alive_led <= alive_cnt[25];
          comp_led <= ~(test_out_icm[4 : 0] == 5'b00011);
          L0_led <= ~(test_out_icm[4 : 0] == 5'b01111);
          lane_active_led[3 : 0] <= ~(test_out_icm[8 : 5]);
        end
    end


  pll_125To50  pll_125To50(      //for reconfig_clk   
	.areset (local_rstn),
	.inclk0 (clkin_top_p),       //input  clk
	.c0 	(reconfig_clk)   //output clk
   );
  
  top_plus a2_pex_x8_plus_0 (
  .local_rstn(local_rstn),
  .pcie_rstn(pcie_perstn),
  .refclk(pcie_refclk_p),
  .core_clk_out(clk_pcie),
  .pld_clk(clk_pcie),
  
  .rx_st_bardec0 (rx_st_bardec0),
  .rx_st_be0 (rx_st_be0),
  .rx_st_data0 (rx_st_data0),
  .rx_st_empty0 (rx_st_empty0),
  .rx_st_eop0 (rx_st_eop0),
  .rx_st_err0 (open_rx_st_err0),
  .rx_st_mask0 (rx_mask0),
  .rx_st_ready0 (rx_stream_ready0),
  .rx_st_sop0 (rx_st_sop0),
  .rx_st_valid0 (rx_stream_valid0),
  .tx_st_data0 (tx_st_data0),
  .tx_st_empty0 (tx_st_empty0),
  .tx_st_eop0 (tx_st_eop0),
  .tx_st_err0 (tx_st_err0),
  .tx_st_ready0 (tx_stream_ready0),
  .tx_st_sop0 (tx_st_sop0),
  .tx_st_valid0 (tx_stream_valid0),
  
  .tx_cred0 (tx_stream_cred0),
  
  .rx_in0(pcie_rx_p[0]),
  .rx_in1(pcie_rx_p[1]),
  .rx_in2(pcie_rx_p[2]),
  .rx_in3(pcie_rx_p[3]),
  .rx_in4(pcie_rx_p[4]),
  .rx_in5(pcie_rx_p[5]),
  .rx_in6(pcie_rx_p[6]),
  .rx_in7(pcie_rx_p[7]),
  .tx_out0(pcie_tx_p[0]),
  .tx_out1(pcie_tx_p[1]),
  .tx_out2(pcie_tx_p[2]),
  .tx_out3(pcie_tx_p[3]),
  .tx_out4(pcie_tx_p[4]),
  .tx_out5(pcie_tx_p[5]),
  .tx_out6(pcie_tx_p[6]),
  .tx_out7(pcie_tx_p[7]),
  
  .app_int_ack(app_int_ack_icm),
  .app_int_sts(app_int_sts_icm),
  .app_msi_ack(app_msi_ack),
  .app_msi_num(app_msi_num),
  .app_msi_req(app_msi_req),
  .app_msi_tc(app_msi_tc),
  
  .tl_cfg_add (tl_cfg_add),
  .tl_cfg_ctl (tl_cfg_ctl),
  .tl_cfg_ctl_wr (tl_cfg_ctl_wr),
   
  .reconfig_clk(reconfig_clk),
//  .reconfig_clk_locked(reconfig_clk_locked),
  
  .pme_to_cr (pme_to_sr),
  .pme_to_sr (pme_to_sr),
  .test_in(40'b010101000),
  .pipe_mode(1'b0),
  .pm_auxpwr(1'b0),
  .pm_data(0),
  .pm_event(1'b0),
  .srstn(srstn),
  
      .cpl_err (cpl_err_icm),
      .cpl_pending (1'b0),
//      .fixedclk_serdes (fixedclk_serdes),
      .lane_act (lane_act),
      .lmi_ack (lmi_ack),
      .lmi_addr (lmi_addr),
      .lmi_din (lmi_din),
      .lmi_dout (lmi_dout),
      .lmi_rden (lmi_rden),
      .lmi_wren (lmi_wren),
      .ltssm (dl_ltssm),
      .pex_msi_num (pex_msi_num_icm),
      .phystatus_ext (phystatus_ext),
      .powerdown_ext (powerdown_ext),
      .rate_ext (rate_ext),
      .rc_pll_locked (rc_pll_locked),
      .test_out(test_out_int),
      .tl_cfg_sts (tl_cfg_sts),
      .tl_cfg_sts_wr (tl_cfg_sts_wr)
//      .tx_fifo_empty0 (tx_fifo_empty0)
  );
  
/*  top_plus ep_plus (
      .app_int_ack (app_int_ack_icm),
      .app_int_sts (app_int_sts_icm),
      .app_msi_ack (app_msi_ack),
      .app_msi_num (app_msi_num),
      .app_msi_req (app_msi_req),
      .app_msi_tc (app_msi_tc),
      .clk250_out (clk250_out),
      .clk500_out (clk500_out),
      .core_clk_out (core_clk_out),
      .cpl_err (cpl_err_icm),
      .cpl_pending (cpl_pending_icm),
      .lane_act (lane_act),
      .lmi_ack (lmi_ack),
      .lmi_addr (lmi_addr),
      .lmi_din (lmi_din),
      .lmi_dout (lmi_dout),
      .lmi_rden (lmi_rden),
      .lmi_wren (lmi_wren),
      .local_rstn (local_rstn),
      .ltssm (dl_ltssm),
      .pcie_rstn (pcie_perstn),
      .pclk_in (pclk_in),
      .pex_msi_num (pex_msi_num_icm),
      .phystatus_ext (phystatus_ext),
      .pipe_mode (pipe_mode),
      .pld_clk (pld_clk),
      .pm_auxpwr (1'b0),
      .pm_data (gnd_pm_data),
      .pm_event (1'b0),
      .pme_to_cr (pme_to_sr),
      .pme_to_sr (pme_to_sr),
      .powerdown_ext (powerdown_ext),
      .rate_ext (rate_ext),
      .rc_pll_locked (rc_pll_locked),
      .reconfig_clk (reconfig_clk),
      .refclk (pcie_refclk_p),
      .rx_in0 (pcie_rx_p[0]),
      .rx_in1 (pcie_rx_p[1]),
      .rx_in2 (pcie_rx_p[2]),
      .rx_in3 (pcie_rx_p[3]),
      .rx_in4 (pcie_rx_p[4]),
      .rx_in5 (pcie_rx_p[5]),
      .rx_in6 (pcie_rx_p[6]),
      .rx_in7 (pcie_rx_p[7]),
      .rx_st_bardec0 (rx_st_bardec0),
      .rx_st_be0 (rx_st_be0),
      .rx_st_data0 (rx_st_data0),
      .rx_st_empty0 (rx_st_empty0),
      .rx_st_eop0 (rx_st_eop0),
      .rx_st_err0 (open_rx_st_err0),
      .rx_st_mask0 (rx_mask0),
      .rx_st_ready0 (rx_stream_ready0),
      .rx_st_sop0 (rx_st_sop0),
      .rx_st_valid0 (rx_stream_valid0),
      .rxdata0_ext (rxdata0_ext),
      .rxdata1_ext (rxdata1_ext),
      .rxdata2_ext (rxdata2_ext),
      .rxdata3_ext (rxdata3_ext),
      .rxdata4_ext (rxdata4_ext),
      .rxdata5_ext (rxdata5_ext),
      .rxdata6_ext (rxdata6_ext),
      .rxdata7_ext (rxdata7_ext),
      .rxdatak0_ext (rxdatak0_ext),
      .rxdatak1_ext (rxdatak1_ext),
      .rxdatak2_ext (rxdatak2_ext),
      .rxdatak3_ext (rxdatak3_ext),
      .rxdatak4_ext (rxdatak4_ext),
      .rxdatak5_ext (rxdatak5_ext),
      .rxdatak6_ext (rxdatak6_ext),
      .rxdatak7_ext (rxdatak7_ext),
      .rxelecidle0_ext (rxelecidle0_ext),
      .rxelecidle1_ext (rxelecidle1_ext),
      .rxelecidle2_ext (rxelecidle2_ext),
      .rxelecidle3_ext (rxelecidle3_ext),
      .rxelecidle4_ext (rxelecidle4_ext),
      .rxelecidle5_ext (rxelecidle5_ext),
      .rxelecidle6_ext (rxelecidle6_ext),
      .rxelecidle7_ext (rxelecidle7_ext),
      .rxpolarity0_ext (rxpolarity0_ext),
      .rxpolarity1_ext (rxpolarity1_ext),
      .rxpolarity2_ext (rxpolarity2_ext),
      .rxpolarity3_ext (rxpolarity3_ext),
      .rxpolarity4_ext (rxpolarity4_ext),
      .rxpolarity5_ext (rxpolarity5_ext),
      .rxpolarity6_ext (rxpolarity6_ext),
      .rxpolarity7_ext (rxpolarity7_ext),
      .rxstatus0_ext (rxstatus0_ext),
      .rxstatus1_ext (rxstatus1_ext),
      .rxstatus2_ext (rxstatus2_ext),
      .rxstatus3_ext (rxstatus3_ext),
      .rxstatus4_ext (rxstatus4_ext),
      .rxstatus5_ext (rxstatus5_ext),
      .rxstatus6_ext (rxstatus6_ext),
      .rxstatus7_ext (rxstatus7_ext),
      .rxvalid0_ext (rxvalid0_ext),
      .rxvalid1_ext (rxvalid1_ext),
      .rxvalid2_ext (rxvalid2_ext),
      .rxvalid3_ext (rxvalid3_ext),
      .rxvalid4_ext (rxvalid4_ext),
      .rxvalid5_ext (rxvalid5_ext),
      .rxvalid6_ext (rxvalid6_ext),
      .rxvalid7_ext (rxvalid7_ext),
      .srstn (srstn),
      .test_in (test_in),
      .test_out (test_out_int),
      .tl_cfg_add (tl_cfg_add),
      .tl_cfg_ctl (tl_cfg_ctl),
      .tl_cfg_ctl_wr (tl_cfg_ctl_wr),
      .tl_cfg_sts (tl_cfg_sts),
      .tl_cfg_sts_wr (tl_cfg_sts_wr),
      .tx_cred0 (tx_stream_cred0),
      .tx_fifo_empty0 (tx_fifo_empty0),
      .tx_out0 (pcie_tx_p[0]),
      .tx_out1 (pcie_tx_p[1]),
      .tx_out2 (pcie_tx_p[2]),
      .tx_out3 (pcie_tx_p[3]),
      .tx_out4 (pcie_tx_p[4]),
      .tx_out5 (pcie_tx_p[5]),
      .tx_out6 (pcie_tx_p[6]),
      .tx_out7 (pcie_tx_p[7]),
      .tx_st_data0 (tx_st_data0),
      .tx_st_empty0 (tx_st_empty0),
      .tx_st_eop0 (tx_st_eop0),
      .tx_st_err0 (tx_st_err0),
      .tx_st_ready0 (tx_stream_ready0),
      .tx_st_sop0 (tx_st_sop0),
      .tx_st_valid0 (tx_stream_valid0),
      .txcompl0_ext (txcompl0_ext),
      .txcompl1_ext (txcompl1_ext),
      .txcompl2_ext (txcompl2_ext),
      .txcompl3_ext (txcompl3_ext),
      .txcompl4_ext (txcompl4_ext),
      .txcompl5_ext (txcompl5_ext),
      .txcompl6_ext (txcompl6_ext),
      .txcompl7_ext (txcompl7_ext),
      .txdata0_ext (txdata0_ext),
      .txdata1_ext (txdata1_ext),
      .txdata2_ext (txdata2_ext),
      .txdata3_ext (txdata3_ext),
      .txdata4_ext (txdata4_ext),
      .txdata5_ext (txdata5_ext),
      .txdata6_ext (txdata6_ext),
      .txdata7_ext (txdata7_ext),
      .txdatak0_ext (txdatak0_ext),
      .txdatak1_ext (txdatak1_ext),
      .txdatak2_ext (txdatak2_ext),
      .txdatak3_ext (txdatak3_ext),
      .txdatak4_ext (txdatak4_ext),
      .txdatak5_ext (txdatak5_ext),
      .txdatak6_ext (txdatak6_ext),
      .txdatak7_ext (txdatak7_ext),
      .txdetectrx_ext (txdetectrx_ext),
      .txelecidle0_ext (txelecidle0_ext),
      .txelecidle1_ext (txelecidle1_ext),
      .txelecidle2_ext (txelecidle2_ext),
      .txelecidle3_ext (txelecidle3_ext),
      .txelecidle4_ext (txelecidle4_ext),
      .txelecidle5_ext (txelecidle5_ext),
      .txelecidle6_ext (txelecidle6_ext),
      .txelecidle7_ext (txelecidle7_ext) );*/


/*  altpcierd_tl_cfg_sample cfgbus (
      .cfg_busdev (cfg_busdev_icm),
      .cfg_devcsr (cfg_devcsr_icm),
      .cfg_io_bas (cfg_io_bas),
      .cfg_linkcsr (cfg_linkcsr_icm),
      .cfg_msicsr (cfg_msicsr),
      .cfg_np_bas (cfg_np_bas),
      .cfg_pr_bas (cfg_pr_bas),
      .cfg_prmcsr (cfg_prmcsr_icm),
      .cfg_tcvcmap (open_cfg_tcvcmap),
      .pld_clk (pld_clk),
      .rstn (srstn),
      .tl_cfg_add (tl_cfg_add),
      .tl_cfg_ctl (tl_cfg_ctl),
      .tl_cfg_ctl_wr (tl_cfg_ctl_wr),
      .tl_cfg_sts (tl_cfg_sts),
      .tl_cfg_sts_wr (tl_cfg_sts_wr) );

  defparam cfgbus.HIP_SV = 0;*/

  altpcierd_cplerr_lmi lmi_blk (
      .clk_in(clk_pcie),
      .cpl_err_in (cpl_err_in),
      .cpl_err_out (cpl_err_icm),
      .cplerr_lmi_busy (open_cplerr_lmi_busy),
      .err_desc (err_desc),
      .lmi_ack (lmi_ack),
      .lmi_addr (lmi_addr),
      .lmi_din (lmi_din),
      .lmi_rden (lmi_rden),
      .lmi_wren (lmi_wren),
      .rstn (srstn) );

  
  pcie_to_hibi_test_app
    #( .HIBI_DATA_WIDTH(32),
       .HIBI_ADDR_SPACE_WIDTH(11),
       
       .PCIE_DATA_WIDTH(128),
       .PCIE_ADDR_WIDTH(64),
       .PCIE_LOWER_ADDR_WIDTH(7),
       .PCIE_RW_LENGTH_WIDTH(13),
       .PCIE_ID_WIDTH(16),
       .PCIE_FUNC_WIDTH(3),
       .PCIE_TAG_WIDTH(6),
//       .PKT_TAG_WIDTH(9),
       .PCIE_CRED_WIDTH(36),
       
       .PCIE_CPL_LENGTH_MIN(128),
       
       .P2H_ADDR_SPACES(4),
       .P2H_HDMA_ADDR_SPACES(1),
       
       .HIBI_IF_ADDR(32'h10000000),
       
       .P2H_ADDR_0_WIDTH(16),
       .P2H_ADDR_0_PCIE_BASE(64'h0),
       .P2H_ADDR_0_HIBI_BASE(32'h00000000),
       .P2H_ADDR_1_WIDTH(8),
       .P2H_ADDR_1_PCIE_BASE(64'h0000000000010000),
       .P2H_ADDR_1_HIBI_BASE(32'h00020000),
       .P2H_ADDR_2_WIDTH(8),
       .P2H_ADDR_2_PCIE_BASE(64'h0000000000010100),
       .P2H_ADDR_2_HIBI_BASE(32'h00020100),
       .P2H_ADDR_3_WIDTH(8),
       .P2H_ADDR_3_PCIE_BASE(64'h0000000000010200),
       .P2H_ADDR_3_HIBI_BASE(32'h00020200),
       
       .HDMA_REQS_MIN(4),
            
       .H2P_WR_CHANS(16),
       .H2P_RD_CHANS(16),
       .P2H_WR_CHANS(16),
       .P2H_RD_CHANS(16) )

  test_app (
       .clk_pcie(clk_pcie),
       .clk_ref(clkin_bot_p),
       .rst_n(in_sys_rstn),
       .rst_n_pcie(local_rstn),
       .clk_sys_out(clk_sys_out),
       
       .rx_st_data_i(rx_st_data0),
       .rx_st_valid_i(rx_stream_valid0),
       .rx_st_sop_i(rx_st_sop0),
       .rx_st_eop_i(rx_st_eop0),
       .rx_st_empty_i(rx_st_empty0),
       .rx_st_bardec_i(rx_st_bardec0),
       .rx_st_ready_o(rx_stream_ready0),
       .rx_st_mask_o(rx_mask0),
       
       .tx_st_sop_o(tx_st_sop0),
       .tx_st_eop_o(tx_st_eop0),
       .tx_st_empty_o(tx_st_empty0),
       .tx_st_valid_o(tx_stream_valid0),
       .tx_st_data_o(tx_st_data0),
       .tx_st_ready_i(tx_stream_ready0),
       .txcred_i(tx_stream_cred0),
       
       .app_msi_req_out(app_msi_req),
       .app_msi_ack_in(app_msi_ack),
       .app_msi_tc_out(app_msi_tc),
       .app_msi_num_out(app_msi_num),
       .pex_msi_num_out(pex_msi_num_icm),
       .app_int_sts_out(app_int_sts_icm),
       .app_int_ack_in(app_int_ack_icm),
       
       .tl_cfg_add(tl_cfg_add),
       .tl_cfg_ctl(tl_cfg_ctl),
       .tl_cfg_ctl_wr(tl_cfg_ctl_wr),
       
       .ddr2_clk(ddr2_dimm_clk),
       .ddr2_clk_n(ddr2_dimm_clk_n),
       .ddr2_odt(ddr2_dimm_odt),
       .ddr2_cs_n(ddr2_dimm_cs_n),
       .ddr2_cke(ddr2_dimm_cke),
       .ddr2_addr(ddr2_dimm_addr),
       .ddr2_ba(ddr2_dimm_ba),
       .ddr2_ras_n(ddr2_dimm_ras_n),
       .ddr2_cas_n(ddr2_dimm_cas_n),
       .ddr2_we_n(ddr2_dimm_we_n),
       .ddr2_dm(ddr2_dimm_dm),
       .ddr2_dq(ddr2_dimm_dq),
       .ddr2_dqs(ddr2_dimm_dqs),
       .ddr2_dqs_n(ddr2_dimm_dqs_n),
		  
		 .dummy_debug_out(user_led[0]),
		 .debug_out(debug) );
  
  

wire clk;
wire [31:0] sys_count;

sys_cnt sys_cnt_0 (
  .rst_n(user_pb[0]),
  .clk(clk_sys_out),
  
  .cont(1),
  .clear(debug),
  
  .sys_cnt_out(sys_count) );

/*a2_pex_x8_app_if a2_pex_x8_app (
  .rst_n(user_pb[0]),
  .rst_n_pcie(pcie_perstn),
  .rst_n_debug(user_pb[1]),
  
  .clk_free_100(clkin_bot_p),
  .clk_pcie_ref(pcie_refclk_p),
  .clk_ddr2_ref(clkin_top_p),
  .clk_sys_out(clk),
  
  .pcie_rx_in(pcie_rx_p),
  .pcie_tx_out(pcie_tx_p),
   
  .ddr2_clk(ddr2_dimm_clk),
  .ddr2_clk_n(ddr2_dimm_clk_n),
  .ddr2_odt(ddr2_dimm_odt),
  .ddr2_cs_n(ddr2_dimm_cs_n),
  .ddr2_cke(ddr2_dimm_cke),
  .ddr2_addr(ddr2_dimm_addr[13:0]),
  .ddr2_ba(ddr2_dimm_ba),
  .ddr2_ras_n(ddr2_dimm_ras_n),
  .ddr2_cas_n(ddr2_dimm_cas_n),
  .ddr2_we_n(ddr2_dimm_we_n),
  .ddr2_dm(ddr2_dimm_dm),
  .ddr2_dq(ddr2_dimm_dq),
  .ddr2_dqs(ddr2_dimm_dqs),
  .ddr2_dqs_n(ddr2_dimm_dqs_n) );*/

endmodule
