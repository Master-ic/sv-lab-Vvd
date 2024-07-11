`include "interface.sv"

module Cpu(
    output [31:0] sramRaddr, sramWaddr,
    output sramWen,
    output [31:0] sramWdata,
    input  [31:0] sramRdata,
    input clk,
    input rstn,
    input [31:0]ins
);
logic [31:0] WPrfData;
logic [31:0] rdata_1 , rdata_2;
logic [31:0] SRAM_Rdata;
logic [31:0] SRAM_Wdata;

decoder decoder_U(.ins(ins));
regfile u_regfile(
    .clk    ( clk    ),
    .rstn   ( rstn   ),
    .Wadd   ( decoder_U.rd   ),
    .Wdata  (  WPrfData ),
    .isWreg ( decoder_U.PrfWen ),
    .Radd1  ( decoder_U.rs1  ),
    .Rdata1 ( rdata_1 ),
    .Radd2  ( decoder_U.rs2  ),
    .Rdata2 ( rdata_2  )
);

logic [31:0] aADDb =  rdata_1 + rdata_2;
assign WPrfData = {32{decoder_U.imodel}} & {{24{1'b0}},ins[28:21]} & {32{decoder_U.load}}| 
                  {32{~decoder_U.imodel}} & SRAM_Rdata & {32{decoder_U.load}} |
                  aADDb & {32{decoder_U.add}};
assign SRAM_Wdata = {32{decoder_U.imodel}} & {32{decoder_U.store}} & {{24{1'b0}},ins[20:13]};
logic SRAM_waddr = decoder_U.AWsram ;

assign sramRaddr = decoder_U.ARsram ;
assign sramWaddr = decoder_U.AWsram ;
assign sramWen   = decoder_U.store  ;
assign sramWdata = SRAM_Wdata       ;

endmodule