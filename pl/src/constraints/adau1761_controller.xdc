set_property PACKAGE_PIN AB4 [get_ports adau1761_cclk_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_cclk_0]

set_property PACKAGE_PIN AB1 [get_ports adau1761_clatchn_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_clatchn_0]

set_property PACKAGE_PIN Y5 [get_ports adau1761_cdata_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_cdata_0]

set_property PACKAGE_PIN AB5 [get_ports adau1761_cout_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_cout_0]

set_property IOSTANDARD LVCMOS33 [get_ports adau1761_mclk]
set_property PACKAGE_PIN AB2 [get_ports adau1761_mclk]

set_property PACKAGE_PIN T22 [get_ports led0]
set_property IOSTANDARD LVCMOS33 [get_ports led0]

set_property PACKAGE_PIN AA7 [get_ports adau1761_adc_sdata_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_adc_sdata_0]

set_property PACKAGE_PIN Y8 [get_ports adau1761_dac_sdata_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_dac_sdata_0]

set_property PACKAGE_PIN AA6 [get_ports adau1761_bclk_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_bclk_0]

set_property PACKAGE_PIN Y6 [get_ports adau1761_lrclk_0]
set_property IOSTANDARD LVCMOS33 [get_ports adau1761_lrclk_0]




create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list audio_controller_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 64 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {audio_controller_i/adau1761_controller_0/inst/read_data[0]} {audio_controller_i/adau1761_controller_0/inst/read_data[1]} {audio_controller_i/adau1761_controller_0/inst/read_data[2]} {audio_controller_i/adau1761_controller_0/inst/read_data[3]} {audio_controller_i/adau1761_controller_0/inst/read_data[4]} {audio_controller_i/adau1761_controller_0/inst/read_data[5]} {audio_controller_i/adau1761_controller_0/inst/read_data[6]} {audio_controller_i/adau1761_controller_0/inst/read_data[7]} {audio_controller_i/adau1761_controller_0/inst/read_data[8]} {audio_controller_i/adau1761_controller_0/inst/read_data[9]} {audio_controller_i/adau1761_controller_0/inst/read_data[10]} {audio_controller_i/adau1761_controller_0/inst/read_data[11]} {audio_controller_i/adau1761_controller_0/inst/read_data[12]} {audio_controller_i/adau1761_controller_0/inst/read_data[13]} {audio_controller_i/adau1761_controller_0/inst/read_data[14]} {audio_controller_i/adau1761_controller_0/inst/read_data[15]} {audio_controller_i/adau1761_controller_0/inst/read_data[16]} {audio_controller_i/adau1761_controller_0/inst/read_data[17]} {audio_controller_i/adau1761_controller_0/inst/read_data[18]} {audio_controller_i/adau1761_controller_0/inst/read_data[19]} {audio_controller_i/adau1761_controller_0/inst/read_data[20]} {audio_controller_i/adau1761_controller_0/inst/read_data[21]} {audio_controller_i/adau1761_controller_0/inst/read_data[22]} {audio_controller_i/adau1761_controller_0/inst/read_data[23]} {audio_controller_i/adau1761_controller_0/inst/read_data[24]} {audio_controller_i/adau1761_controller_0/inst/read_data[25]} {audio_controller_i/adau1761_controller_0/inst/read_data[26]} {audio_controller_i/adau1761_controller_0/inst/read_data[27]} {audio_controller_i/adau1761_controller_0/inst/read_data[28]} {audio_controller_i/adau1761_controller_0/inst/read_data[29]} {audio_controller_i/adau1761_controller_0/inst/read_data[30]} {audio_controller_i/adau1761_controller_0/inst/read_data[31]} {audio_controller_i/adau1761_controller_0/inst/read_data[32]} {audio_controller_i/adau1761_controller_0/inst/read_data[33]} {audio_controller_i/adau1761_controller_0/inst/read_data[34]} {audio_controller_i/adau1761_controller_0/inst/read_data[35]} {audio_controller_i/adau1761_controller_0/inst/read_data[36]} {audio_controller_i/adau1761_controller_0/inst/read_data[37]} {audio_controller_i/adau1761_controller_0/inst/read_data[38]} {audio_controller_i/adau1761_controller_0/inst/read_data[39]} {audio_controller_i/adau1761_controller_0/inst/read_data[40]} {audio_controller_i/adau1761_controller_0/inst/read_data[41]} {audio_controller_i/adau1761_controller_0/inst/read_data[42]} {audio_controller_i/adau1761_controller_0/inst/read_data[43]} {audio_controller_i/adau1761_controller_0/inst/read_data[44]} {audio_controller_i/adau1761_controller_0/inst/read_data[45]} {audio_controller_i/adau1761_controller_0/inst/read_data[46]} {audio_controller_i/adau1761_controller_0/inst/read_data[47]} {audio_controller_i/adau1761_controller_0/inst/read_data[48]} {audio_controller_i/adau1761_controller_0/inst/read_data[49]} {audio_controller_i/adau1761_controller_0/inst/read_data[50]} {audio_controller_i/adau1761_controller_0/inst/read_data[51]} {audio_controller_i/adau1761_controller_0/inst/read_data[52]} {audio_controller_i/adau1761_controller_0/inst/read_data[53]} {audio_controller_i/adau1761_controller_0/inst/read_data[54]} {audio_controller_i/adau1761_controller_0/inst/read_data[55]} {audio_controller_i/adau1761_controller_0/inst/read_data[56]} {audio_controller_i/adau1761_controller_0/inst/read_data[57]} {audio_controller_i/adau1761_controller_0/inst/read_data[58]} {audio_controller_i/adau1761_controller_0/inst/read_data[59]} {audio_controller_i/adau1761_controller_0/inst/read_data[60]} {audio_controller_i/adau1761_controller_0/inst/read_data[61]} {audio_controller_i/adau1761_controller_0/inst/read_data[62]} {audio_controller_i/adau1761_controller_0/inst/read_data[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 64 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {audio_controller_i/adau1761_controller_0/inst/write_data[0]} {audio_controller_i/adau1761_controller_0/inst/write_data[1]} {audio_controller_i/adau1761_controller_0/inst/write_data[2]} {audio_controller_i/adau1761_controller_0/inst/write_data[3]} {audio_controller_i/adau1761_controller_0/inst/write_data[4]} {audio_controller_i/adau1761_controller_0/inst/write_data[5]} {audio_controller_i/adau1761_controller_0/inst/write_data[6]} {audio_controller_i/adau1761_controller_0/inst/write_data[7]} {audio_controller_i/adau1761_controller_0/inst/write_data[8]} {audio_controller_i/adau1761_controller_0/inst/write_data[9]} {audio_controller_i/adau1761_controller_0/inst/write_data[10]} {audio_controller_i/adau1761_controller_0/inst/write_data[11]} {audio_controller_i/adau1761_controller_0/inst/write_data[12]} {audio_controller_i/adau1761_controller_0/inst/write_data[13]} {audio_controller_i/adau1761_controller_0/inst/write_data[14]} {audio_controller_i/adau1761_controller_0/inst/write_data[15]} {audio_controller_i/adau1761_controller_0/inst/write_data[16]} {audio_controller_i/adau1761_controller_0/inst/write_data[17]} {audio_controller_i/adau1761_controller_0/inst/write_data[18]} {audio_controller_i/adau1761_controller_0/inst/write_data[19]} {audio_controller_i/adau1761_controller_0/inst/write_data[20]} {audio_controller_i/adau1761_controller_0/inst/write_data[21]} {audio_controller_i/adau1761_controller_0/inst/write_data[22]} {audio_controller_i/adau1761_controller_0/inst/write_data[23]} {audio_controller_i/adau1761_controller_0/inst/write_data[24]} {audio_controller_i/adau1761_controller_0/inst/write_data[25]} {audio_controller_i/adau1761_controller_0/inst/write_data[26]} {audio_controller_i/adau1761_controller_0/inst/write_data[27]} {audio_controller_i/adau1761_controller_0/inst/write_data[28]} {audio_controller_i/adau1761_controller_0/inst/write_data[29]} {audio_controller_i/adau1761_controller_0/inst/write_data[30]} {audio_controller_i/adau1761_controller_0/inst/write_data[31]} {audio_controller_i/adau1761_controller_0/inst/write_data[32]} {audio_controller_i/adau1761_controller_0/inst/write_data[33]} {audio_controller_i/adau1761_controller_0/inst/write_data[34]} {audio_controller_i/adau1761_controller_0/inst/write_data[35]} {audio_controller_i/adau1761_controller_0/inst/write_data[36]} {audio_controller_i/adau1761_controller_0/inst/write_data[37]} {audio_controller_i/adau1761_controller_0/inst/write_data[38]} {audio_controller_i/adau1761_controller_0/inst/write_data[39]} {audio_controller_i/adau1761_controller_0/inst/write_data[40]} {audio_controller_i/adau1761_controller_0/inst/write_data[41]} {audio_controller_i/adau1761_controller_0/inst/write_data[42]} {audio_controller_i/adau1761_controller_0/inst/write_data[43]} {audio_controller_i/adau1761_controller_0/inst/write_data[44]} {audio_controller_i/adau1761_controller_0/inst/write_data[45]} {audio_controller_i/adau1761_controller_0/inst/write_data[46]} {audio_controller_i/adau1761_controller_0/inst/write_data[47]} {audio_controller_i/adau1761_controller_0/inst/write_data[48]} {audio_controller_i/adau1761_controller_0/inst/write_data[49]} {audio_controller_i/adau1761_controller_0/inst/write_data[50]} {audio_controller_i/adau1761_controller_0/inst/write_data[51]} {audio_controller_i/adau1761_controller_0/inst/write_data[52]} {audio_controller_i/adau1761_controller_0/inst/write_data[53]} {audio_controller_i/adau1761_controller_0/inst/write_data[54]} {audio_controller_i/adau1761_controller_0/inst/write_data[55]} {audio_controller_i/adau1761_controller_0/inst/write_data[56]} {audio_controller_i/adau1761_controller_0/inst/write_data[57]} {audio_controller_i/adau1761_controller_0/inst/write_data[58]} {audio_controller_i/adau1761_controller_0/inst/write_data[59]} {audio_controller_i/adau1761_controller_0/inst/write_data[60]} {audio_controller_i/adau1761_controller_0/inst/write_data[61]} {audio_controller_i/adau1761_controller_0/inst/write_data[62]} {audio_controller_i/adau1761_controller_0/inst/write_data[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 3 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {audio_controller_i/adau1761_controller_0/inst/nbytes[0]} {audio_controller_i/adau1761_controller_0/inst/nbytes[1]} {audio_controller_i/adau1761_controller_0/inst/nbytes[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {audio_controller_i/adau1761_controller_0/inst/address[0]} {audio_controller_i/adau1761_controller_0/inst/address[1]} {audio_controller_i/adau1761_controller_0/inst/address[2]} {audio_controller_i/adau1761_controller_0/inst/address[3]} {audio_controller_i/adau1761_controller_0/inst/address[4]} {audio_controller_i/adau1761_controller_0/inst/address[5]} {audio_controller_i/adau1761_controller_0/inst/address[6]} {audio_controller_i/adau1761_controller_0/inst/address[7]} {audio_controller_i/adau1761_controller_0/inst/address[8]} {audio_controller_i/adau1761_controller_0/inst/address[9]} {audio_controller_i/adau1761_controller_0/inst/address[10]} {audio_controller_i/adau1761_controller_0/inst/address[11]} {audio_controller_i/adau1761_controller_0/inst/address[12]} {audio_controller_i/adau1761_controller_0/inst/address[13]} {audio_controller_i/adau1761_controller_0/inst/address[14]} {audio_controller_i/adau1761_controller_0/inst/address[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list audio_controller_i/adau1761_controller_0/inst/adau1761_cclk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list audio_controller_i/adau1761_controller_0/inst/adau1761_cdata]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list audio_controller_i/adau1761_controller_0/inst/adau1761_clatchn]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list audio_controller_i/adau1761_controller_0/inst/adau1761_cout]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list audio_controller_i/adau1761_controller_0/inst/busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list audio_controller_i/adau1761_controller_0/inst/read]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list audio_controller_i/adau1761_controller_0/inst/reset]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list audio_controller_i/adau1761_controller_0/inst/start]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 16384 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list audio_controller_i/clk_wiz_0/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 1 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list audio_controller_i/adau1761_data_0/inst/adau1761_adc_sdata]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 1 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list audio_controller_i/adau1761_data_0/inst/adau1761_bclk]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 1 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list audio_controller_i/adau1761_data_0/inst/adau1761_lrclk]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets adau1761_mclk_OBUF]
