// USB to parallel packet parser

// Framing characters

`define STX 8'h02;
`define DLE 8'h10;
`define ETX 8'h03;

// States

`define STATE_WAIT_STX    2'h0
`define STATE_STX         2'h1
`define STATE_DLE         2'h2

module packetparser (
    clk,
    reset,
    rxf_n,
    rd_n,
    din,
    din_valid,
    len,
    cmd,
    addr_lo,
    addr_hi,
    data,
    data_rdy
);

input clk, reset, rxf_n, rd_n, data_rdy, din_valid;
input [7:0] din;

output [7:0] len;
output [7:0] cmd;
output [7:0] addr_hi;
output [7:0] addr_lo;
output [7:0] data;
output data_rdy;

reg [7:0] state, next_state;
reg [7:0] len, cmd, addr_hi, addr_lo, data;
reg data_rdy;
reg [2:0] parse_cnt;

// State register
always @( posedge clk ) 
begin
    if( reset )
        state <= `STATE_WAIT_STX;
    else
        if( din_valid )
            state <= next_state;
end

// Next state logic
always @( state or din )
begin
    next_state = state;
    case( state )
        `STATE_WAIT_STX:
            if( din == `STX )
                next_state = `STATE_STX;
        `STATE_STX:
            if( din == `ETX )
                next_state = `STATE_WAIT_STX;
            else
            if( din == `DLE )
                next_state = `STATE_DLE;
            else
                next_state = `STATE_STX;
        `STATE_DLE:
            next_state = `STATE_STX;
        default:
            next_state = `STATE_WAIT_STX;
    endcase
end

always @( posedge clk )
begin
    if( reset )
        store_byte = 0;
    else
        if( ( state == `STATE_STX && ( din != `ETX ) && ( din != `DLE ) ) ||
              state == `STATE_DLE )
            store_byte = din_valid;
        else
            store_byte = 0;
end

// Parser

always @( posedge clk )
begin
    if( reset || ( state == `STATE_STX && din == `ETX ) )
        parse_cnt <= 0;
    else
    begin
        if( store_byte )
        begin
            parse_cnt <= parse_cnt + 1;

            case( parse_cnt )
                0:
                    len <= din;
                1:
                    cmd <= din;
                2:
                    addr_lo <= din;
                3:
                    addr_hi <= din;
                4:
                    data <= din;
                default:
                    data <= data;
            endcase
        end
    end
end

endmodule
                
