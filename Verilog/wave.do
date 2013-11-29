onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /vectorgen_test/clkin
add wave -noupdate /vectorgen_test/state_clk_out
add wave -noupdate /vectorgen_test/U1/clkin
add wave -noupdate /vectorgen_test/U1/state_clk_out
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/latch0_reg
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/latch1_reg
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/latch2_reg
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/latch3_reg
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/U1/state
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/U2/count_out
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/xdac
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/ydac
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/U5/scale_reg
add wave -noupdate /vectorgen_test/U1/clkdiv
add wave -noupdate /vectorgen_test/U1/reset_ctr
add wave -noupdate /vectorgen_test/U1/reset
add wave -noupdate /vectorgen_test/U1/dmacnt
add wave -noupdate /vectorgen_test/U1/dmago
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/read_addr
add wave -noupdate -radix unsigned /vectorgen_test/U1/count_out
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/rom_out
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/ram_out
add wave -noupdate /vectorgen_test/U1/mem_out
add wave -noupdate /vectorgen_test/U1/scale
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/dvx
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/dvy
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/pos_y/dv
add wave -noupdate /vectorgen_test/U1/timer
add wave -noupdate /vectorgen_test/U1/dmaload
add wave -noupdate /vectorgen_test/U1/dmapush
add wave -noupdate /vectorgen_test/U1/latch0
add wave -noupdate /vectorgen_test/U1/latch1
add wave -noupdate /vectorgen_test/U1/latch2
add wave -noupdate /vectorgen_test/U1/latch3
add wave -noupdate /vectorgen_test/U1/a0
add wave -noupdate /vectorgen_test/U1/go
add wave -noupdate /vectorgen_test/U1/stop
add wave -noupdate /vectorgen_test/U1/haltstrobe
add wave -noupdate /vectorgen_test/U1/pll_out
add wave -noupdate /vectorgen_test/U1/clk
add wave -noupdate /vectorgen_test/U1/alphanum
add wave -noupdate /vectorgen_test/U1/U1/clk
add wave -noupdate /vectorgen_test/U1/U1/reset
add wave -noupdate -radix hexadecimal /vectorgen_test/U1/U1/op
add wave -noupdate /vectorgen_test/U1/U1/dmacnt
add wave -noupdate /vectorgen_test/U1/U1/dmago
add wave -noupdate /vectorgen_test/U1/U1/stop
add wave -noupdate /vectorgen_test/U1/U1/latch0
add wave -noupdate /vectorgen_test/U1/U1/latch1
add wave -noupdate /vectorgen_test/U1/U1/latch2
add wave -noupdate /vectorgen_test/U1/U1/latch3
add wave -noupdate /vectorgen_test/U1/U1/go
add wave -noupdate /vectorgen_test/U1/U1/haltstrobe
add wave -noupdate /vectorgen_test/U1/U1/dmapush
add wave -noupdate /vectorgen_test/U1/U1/dmaload
add wave -noupdate /vectorgen_test/U1/U1/next_state
add wave -noupdate /vectorgen_test/U1/U1/halt
add wave -noupdate /vectorgen_test/U1/U1/vctr_op
add wave -noupdate /vectorgen_test/U1/U1/state_halt
add wave -noupdate /vectorgen_test/U1/U2/count_in
add wave -noupdate /vectorgen_test/U1/U2/dmaload
add wave -noupdate /vectorgen_test/U1/U2/dmapush
add wave -noupdate /vectorgen_test/U1/U2/latch0
add wave -noupdate /vectorgen_test/U1/U2/latch2
add wave -noupdate /vectorgen_test/U1/U2/load_pc
add wave -noupdate /vectorgen_test/U1/U2/clk
add wave -noupdate /vectorgen_test/U1/U2/reset
add wave -noupdate /vectorgen_test/U1/U2/cnt
add wave -noupdate /vectorgen_test/U1/U2/stack_cnt
add wave -noupdate /vectorgen_test/U1/U2/stack_out
add wave -noupdate /vectorgen_test/U1/U2/U1/q
add wave -noupdate /vectorgen_test/U1/U2/U1/a
add wave -noupdate /vectorgen_test/U1/U2/U1/d
add wave -noupdate /vectorgen_test/U1/U2/U1/we
add wave -noupdate /vectorgen_test/U1/U2/U1/clk
add wave -noupdate /vectorgen_test/U1/U3/address
add wave -noupdate /vectorgen_test/U1/U3/clock
add wave -noupdate /vectorgen_test/U1/U3/q
add wave -noupdate /vectorgen_test/U1/U3/sub_wire0
add wave -noupdate /vectorgen_test/U1/U5/timer_val
add wave -noupdate /vectorgen_test/U1/U5/scale
add wave -noupdate /vectorgen_test/U1/U5/dvx11
add wave -noupdate /vectorgen_test/U1/U5/dvy11
add wave -noupdate /vectorgen_test/U1/U5/latch2
add wave -noupdate /vectorgen_test/U1/U5/go
add wave -noupdate /vectorgen_test/U1/U5/clk
add wave -noupdate /vectorgen_test/U1/U5/reset
add wave -noupdate /vectorgen_test/U1/U5/stop
add wave -noupdate /vectorgen_test/U1/U5/alphanum
add wave -noupdate -radix unsigned /vectorgen_test/U1/U5/count
add wave -noupdate /vectorgen_test/U1/U5/count_in
add wave -noupdate /vectorgen_test/U1/U5/mux_out
add wave -noupdate /vectorgen_test/U1/U5/timer_sum
add wave -noupdate /vectorgen_test/U1/U5/decoder_out
add wave -noupdate /vectorgen_test/U1/pos_x/dv
add wave -noupdate /vectorgen_test/U1/pos_x/go
add wave -noupdate /vectorgen_test/U1/pos_x/clk
add wave -noupdate /vectorgen_test/U1/pos_x/reset
add wave -noupdate /vectorgen_test/U1/pos_x/haltstrobe
add wave -noupdate /vectorgen_test/U1/pos_x/timer0
add wave -noupdate /vectorgen_test/U1/pos_x/dacout
add wave -noupdate /vectorgen_test/U1/pos_x/loadstrobe
add wave -noupdate /vectorgen_test/U1/pos_x/acc
add wave -noupdate /vectorgen_test/U1/pos_x/cnt
add wave -noupdate /vectorgen_test/U1/pos_x/xvld
add wave -noupdate /vectorgen_test/U1/pos_y/go
add wave -noupdate /vectorgen_test/U1/pos_y/clk
add wave -noupdate /vectorgen_test/U1/pos_y/reset
add wave -noupdate /vectorgen_test/U1/pos_y/haltstrobe
add wave -noupdate /vectorgen_test/U1/pos_y/timer0
add wave -noupdate /vectorgen_test/U1/pos_y/dacout
add wave -noupdate /vectorgen_test/U1/pos_y/loadstrobe
add wave -noupdate /vectorgen_test/U1/pos_y/acc
add wave -noupdate /vectorgen_test/U1/pos_y/cnt
add wave -noupdate /vectorgen_test/U1/pos_y/xvld
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10990000 ps} 0}
configure wave -namecolwidth 262
configure wave -valuecolwidth 100
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
WaveRestoreZoom {24752 ns} {25459200 ps}
