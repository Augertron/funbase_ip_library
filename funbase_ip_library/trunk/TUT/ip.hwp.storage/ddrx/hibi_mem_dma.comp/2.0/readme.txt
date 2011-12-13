-----------------------------------
HIBI_MEM_DMA
-----------------------------------

This directory contains a DMA (direct-memory access) controller
that connects HIBI network to Altera's DDRx memory controller.


Subdirectories:

	alt_mem_ctrl	: Files related to Altera's controller
	doc	      	: Documentation (in Microsoft Wröd format)
	hdl		: VHDL source codes fro DMA and its subblocks (e.g. fifo)
	tb		: Files related to testbenches / Run ModelSim simulation in this directory
	ts		: Quartus projects for test systems


Simulation:
	Go to testbench directory
	      cd tb
	Compile the codes by running 
		> ./create_makefile.scr
	
  Start ModelSim 
	      > vsim &
  
  To estimate the latency and bandwidth of the memory and its controller run the script hibi_mem_dma_perf_test.do
    > do hibi_mem_dma_perf_test.do
	


Synthesis:


Juha Arvio, Erno Salminen
December 2010
