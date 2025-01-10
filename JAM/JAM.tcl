# modelsim: source lcd_ctrl.tcl

vlib work
vlog JAM.v

vlog tb.sv +define+tb1
vsim work.test
run -all
quit -sim

vlog tb.sv +define+tb2
vsim work.test
run -all
quit -sim

vlog tb.sv +define+tb3
vsim work.test
run -all
quit -sim
