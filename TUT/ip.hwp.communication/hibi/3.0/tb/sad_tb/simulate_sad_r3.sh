#!/usr/bin/sh
#

vsim -novopt -lib msim_libs/sad3_sc_lib -L msim_libs/vhd_lib -L msim_libs/sad3_sc_lib -c sc_main -do "run -all"
