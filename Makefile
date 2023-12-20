all: 	compile sim

compile:
		vlib work
		vlog -sv Test_bench.sv intf.sv -v RegFile.v
compile_sequencer:
		vlib work
		vlog -sv sequencer.sv
compile_driver:
		vlib work
		vlog -sv driver.sv 
compile_monitor:
		vlib work
		vlog -sv monitor.sv 
compile_scoreboard:
		vlib work
		vlog -sv scoreboard.sv
sim:
		vsim -logfile sim.log -c -do "run -all" work.Test_bench

wave:
		vsim work.trial -voptargs=+acc
