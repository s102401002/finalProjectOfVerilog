onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testfixture/u_JAM/Cost
add wave -noupdate /testfixture/u_JAM/counter
add wave -noupdate /testfixture/u_JAM/current_cost
add wave -noupdate /testfixture/u_JAM/current_max_pointer
add wave -noupdate /testfixture/u_JAM/current_max_value
add wave -noupdate /testfixture/u_JAM/MatchCount
add wave -noupdate /testfixture/u_JAM/MinCost
add wave -noupdate /testfixture/u_JAM/p
add wave -noupdate /testfixture/u_JAM/reverse_start_pointer
add wave -noupdate /testfixture/u_JAM/RST
add wave -noupdate /testfixture/u_JAM/SWAP
add wave -noupdate /testfixture/u_JAM/Valid
add wave -noupdate /testfixture/u_JAM/W
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 40
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {29340 ps}
