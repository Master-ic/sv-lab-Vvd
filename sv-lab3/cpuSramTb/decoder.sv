`include "interface.sv"
module decoder ( arb_if.decoder io
);
logic   [1:0]opcede2 = io.ins[31:30];

assign   io.add         = ~opcede2[0] & ~opcede2[1];
assign   io.load        =  opcede2[0] & ~opcede2[1];
assign   io.store       = ~opcede2[0] &  opcede2[1];

logic       Imodel = io.ins[29];

assign io.rs1 = {5{io.add }} & io.ins[29:25] ;
assign io.rs2 = {5{io.add }} & io.ins[24:20] ;
assign io.rd  = {5{io.add }} & io.ins[19:15] |
                {5{io.load }} & io.ins[20:13] |
                {5{io.store }} & 5'b00000;
assign io.AWsram =  {32{io.store }} & io.ins[28:21] ;
assign io.ARsram =  {32{io.load }} &  {32{~Imodel }} &io.ins[28:21] ;

assign io.imodel = Imodel;
assign io.PrfWen = io.load | io.add ;


                
// 31 30 29    28      21      20  13
// 11 1        1111_1111
    
endmodule