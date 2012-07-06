
force -freeze sim:/tb_dct_top/tb_dct_cpu_i/test_data_type 0 0
do both_intra.do
noforce sim:/tb_dct_top/tb_dct_cpu_i/test_data_type

force -freeze sim:/tb_dct_top/tb_dct_cpu_i/test_data_type 1 0
do both_intra.do
noforce sim:/tb_dct_top/tb_dct_cpu_i/test_data_type

force -freeze sim:/tb_dct_top/tb_dct_cpu_i/test_data_type 2 0
do both_intra.do
noforce sim:/tb_dct_top/tb_dct_cpu_i/test_data_type

