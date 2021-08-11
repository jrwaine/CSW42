# Paste it inside simulation/modelsim 
# Execute it using "do ./{this filename}" inside file folder

vcom -reportprogress 300 -work work ./../../LFSR.vhd
vcom -reportprogress 300 -work work ./../../LFSR_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.LFSR_tb

add wave -position insertpoint  \
sim:/seed \
sim:/random_number \
sim:/gen_number

run 10000 ns
