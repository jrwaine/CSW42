# Paste it inside simulation/modelsim and commment the line below
# cd simulation/modelsim
# or execute from this folder with the above line uncommented

# Execute it using "do ./{this filename}" inside file folder


vcom -reportprogress 300 -work work ./../../RAM_1_port.vhd
vcom -reportprogress 300 -work work ./../../BRAM.vhd
vcom -reportprogress 300 -work work ./../../BRAM_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.BRAM_tb

add wave -position insertpoint  \
sim:/bram_tb/state \
sim:/bram_tb/DUT/ram/q \
sim:/bram_tb/DUT/READDATA \
sim:/bram_tb/DUT/ram/data \
sim:/bram_tb/DUT/WRITEDATA \
sim:/bram_tb/DUT/ram/wren \
sim:/bram_tb/DUT/ram/address \
sim:/bram_tb/DUT/WR_EN \
sim:/bram_tb/DUT/RD_EN \
sim:/bram_tb/DUT/CS \
sim:/bram_tb/address \
sim:/bram_tb/DUT/ADD \
sim:/bram_tb/counter_name




run 1000000 ns
# Paste it inside simulation/modelsim and commment the line below
# cd simulation/modelsim
# or execute from this folder with the above line uncommented

# Execute it using "do ./{this filename}" inside file folder


vcom -reportprogress 300 -work work ./../../RAM_1_port.vhd
vcom -reportprogress 300 -work work ./../../BRAM.vhd
vcom -reportprogress 300 -work work ./../../BRAM_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.BRAM_tb

add wave -position insertpoint  \
sim:/bram_tb/state \
sim:/bram_tb/DUT/ram/q \
sim:/bram_tb/DUT/READDATA \
sim:/bram_tb/DUT/ram/data \
sim:/bram_tb/DUT/WRITEDATA \
sim:/bram_tb/DUT/ram/wren \
sim:/bram_tb/DUT/ram/address \
sim:/bram_tb/DUT/WR_EN \
sim:/bram_tb/DUT/RD_EN \
sim:/bram_tb/DUT/CS \
sim:/bram_tb/address \
sim:/bram_tb/DUT/ADD \
sim:/bram_tb/counter_name




run 1000000 ns
# Paste it inside simulation/modelsim and commment the line below
# cd simulation/modelsim
# or execute from this folder with the above line uncommented

# Execute it using "do ./{this filename}" inside file folder


vcom -reportprogress 300 -work work ./../../RAM_1_port.vhd
vcom -reportprogress 300 -work work ./../../BRAM.vhd
vcom -reportprogress 300 -work work ./../../BRAM_tb.vhd

vsim +altera -l msim_transcript -gui gate_work.BRAM_tb

add wave -position insertpoint  \
sim:/bram_tb/state \
sim:/bram_tb/DUT/ram/q \
sim:/bram_tb/DUT/READDATA \
sim:/bram_tb/DUT/ram/data \
sim:/bram_tb/DUT/WRITEDATA \
sim:/bram_tb/DUT/ram/wren \
sim:/bram_tb/DUT/ram/address \
sim:/bram_tb/DUT/WR_EN \
sim:/bram_tb/DUT/RD_EN \
sim:/bram_tb/DUT/CS \
sim:/bram_tb/address \
sim:/bram_tb/DUT/ADD \
sim:/bram_tb/counter_name

run 1000000 ns
