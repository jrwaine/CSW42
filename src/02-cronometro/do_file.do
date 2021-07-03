vcom -reportprogress 300 -work work ./../../BCD_7seg.vhd
vcom -reportprogress 300 -work work ./../../button30ms_cron.vhd
vcom -reportprogress 300 -work work ./../../cont4_completo.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg.vhd
vcom -reportprogress 300 -work work ./../../cont6000.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd
vcom -reportprogress 300 -work work ./../../cont6000_7seg_tb.vhd

vsim +altera -do cronometro_run_msim_gate_vhdl.do -l msim_transcript -gui gate_work.cont6000_7seg_tb
do cronometro_run_msim_gate_vhdl.do

add wave -position insertpoint  \
sim:/cont6000_7seg_tb/cron_60_7seg/CLK \
sim:/cont6000_7seg_tb/cron_60_7seg/ZERAR \
sim:/cont6000_7seg_tb/cron_60_7seg/INICIAR \
sim:/cont6000_7seg_tb/cron_60_7seg/EN_INIT \
sim:/cont6000_7seg_tb/cron_60_7seg/EN_ZERAR \
sim:/cont6000_7seg_tb/cron_60_7seg/EN_CONT \
sim:/cont6000_7seg_tb/cron_60_7seg/DS \
sim:/cont6000_7seg_tb/cron_60_7seg/CS \
sim:/cont6000_7seg_tb/cron_60_7seg/UN \
sim:/cont6000_7seg_tb/cron_60_7seg/DZ

run 80000 ns
