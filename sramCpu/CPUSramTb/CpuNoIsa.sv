`include "interface.sv"
`include "decoder.sv"

module Cpu(
    output [31:0] sramRaddr, sramWaddr,
    output sramWen,
    output [31:0] sramWdata,
    input  [31:0] sramRdata,
    input clk,
    input rstn,
    input [31:0] ins
);

logic [31:0] WPrfData;
logic [31:0] rdata_1, rdata_2;
logic [31:0] SRAM_Rdata;
logic [31:0] SRAM_Wdata;

arb_if arb_if_inst(clk);

assign arb_if_inst.ins = ins;
assign arb_if_inst.rstn = rstn;
assign arb_if_inst.sramRdata = sramRdata;

decoder decoder_U(
    .io(arb_if_inst)
);

regfile u_regfile(
    .clk    ( clk               ),
    .rstn   ( rstn              ),
    .Wadd   ( arb_if_inst.rd    ),
    .Wdata  ( WPrfData          ),
    .isWreg ( arb_if_inst.PrfWen),
    .Radd1  ( arb_if_inst.rs1   ),
    .Rdata1 ( rdata_1           ),
    .Radd2  ( arb_if_inst.rs2   ),
    .Rdata2 ( rdata_2           )
);

logic [31:0] aADDb ;
assign aADDb =  rdata_1 + rdata_2;

assign WPrfData = ({32{arb_if_inst.imodel}} & {{24{1'b0}}, ins[28:21]} & {32{arb_if_inst.load}}) | 
                  ({32{~arb_if_inst.imodel}} & sramRdata & {32{arb_if_inst.load}}) |
                  (aADDb & {32{arb_if_inst.add}});

assign SRAM_Wdata = {32{arb_if_inst.imodel}} & {32{arb_if_inst.store}} & {{24{1'b0}}, ins[20:13]};

assign sramRaddr = arb_if_inst.ARsram;
assign sramWaddr = arb_if_inst.AWsram;
assign sramWen   = arb_if_inst.store;
assign sramWdata = SRAM_Wdata;


arb_if monitor_io(clk);
assign monitor_io.sram_wr_data = sramWdata;
assign monitor_io.sram_raddr = sramRaddr;
assign monitor_io.sram_waddr = sramWaddr;
assign monitor_io.sram_wr = sramWen;
assign monitor_io.rs1 = arb_if_inst.rs1;
assign monitor_io.rs2 = arb_if_inst.rs2;
assign monitor_io.rd = arb_if_inst.rd;


monitor monitor_U(
    .io(monitor_io)
);
endmodule
