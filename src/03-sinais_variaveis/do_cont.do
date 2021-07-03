# Paste it inside simulation/modelsim 
# Execute it using "do ./{this filename}" inside file folder

vcom -reportprogress 300 -work work ./../../cont.vhd
vcom -reportprogress 300 -work work ./../../cont_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.cont_tb

add wave -position insertpoint  \
sim:/cont_3bits_tb/CLK \
sim:/cont_3bits_tb/dado \
sim:/cont_3bits_tb/cont_bit_var \
sim:/cont_3bits_tb/cont_bit_sig \
sim:/cont_3bits_tb/cont_bit_sum

run 10000 ns
