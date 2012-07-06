force -freeze sim:/tb_dct_top/tb_dct_cpu_i/intra 1 0
run 10 ms
restart -f
force -freeze sim:/tb_dct_top/tb_dct_cpu_i/intra 0 0
run 10 ms
noforce sim:/tb_dct_top/tb_dct_cpu_i/intra
restart -f
