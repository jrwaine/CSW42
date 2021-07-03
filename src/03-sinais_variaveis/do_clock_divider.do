# Paste it inside simulation/modelsim 
# Execute it using "do ./{this filename}" inside file folder

vcom -reportprogress 300 -work work ./../../clock_divider.vhd
vcom -reportprogress 300 -work work ./../../clock_divider_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.clock_divider_tb

add wave -position insertpoint  \
sim:/clock_divider_tb/clock_out

run 3000 ms
