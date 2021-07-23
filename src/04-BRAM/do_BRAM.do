# Paste it inside simulation/modelsim 
# Execute it using "do ./{this filename}" inside file folder

vcom -reportprogress 300 -work work ./../../BRAM.vhd
vcom -reportprogress 300 -work work ./../../BRAM_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.BRAM_tb

add wave -position insertpoint  \
sim:/bram_tb/DUT/RST \
sim:/bram_tb/DUT/CLK \
sim:/bram_tb/DUT/READDATA \
sim:/bram_tb/DUT/WRITEDATA \
sim:/bram_tb/DUT/WR_EN \
sim:/bram_tb/DUT/RD_EN \
sim:/bram_tb/DUT/CS \
sim:/bram_tb/DUT/ADD \
sim:/bram_tb/address

run 10000 ns
