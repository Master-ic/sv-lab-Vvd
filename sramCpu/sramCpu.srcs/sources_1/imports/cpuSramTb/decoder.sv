`include "interface.sv"

module decoder (arb_if.decoder io);
    logic [1:0] opcode2 ;
    assign opcode2 = io.ins[31:30];

    assign io.add    = ~opcode2[0] & ~opcode2[1];
    assign io.load   =  opcode2[0] & ~opcode2[1];
    assign io.store  = ~opcode2[0] &  opcode2[1];

    logic Imodel ;
    assign  Imodel = io.ins[29];
logic [4:0]test;
assign test = io.ins[29:25];
    assign io.rs1 = {5{io.add }} & io.ins[29:25] |
                    {5{io.store}} & io.ins[20:16] & {5{~Imodel}};
    assign io.rs2 = {5{io.add }} & io.ins[24:20];
    assign io.rd  = ({5{io.add }} & io.ins[19:15]) |
                    ({5{io.load }} & io.ins[20:16]) |
                    ({5{io.store }} & 5'b00000);
    assign io.AWsram = {32{io.store }} & io.ins[28:21];
    assign io.ARsram = {32{io.load }} & {32{~Imodel}} & io.ins[28:21];

    assign io.imodel = Imodel;
    assign io.PrfWen = io.load | io.add;
endmodule
