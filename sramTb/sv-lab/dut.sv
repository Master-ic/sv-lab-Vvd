`include "interface.sv"
module dut(arb_if.DUT arbif);

    parameter WIDTH=8;
    parameter DEPTH =32;
    
    logic [WIDTH-1:0]mem[DEPTH-1:0];
    

    always@(negedge arbif.clk)begin
        if(arbif.en & arbif.wr)
            mem[arbif.addr]<= arbif.wr_data;
        end
        
    assign arbif.rd_data=((!arbif.wr)& arbif.en)? mem[arbif.addr] : 8'd0;


    


endmodule