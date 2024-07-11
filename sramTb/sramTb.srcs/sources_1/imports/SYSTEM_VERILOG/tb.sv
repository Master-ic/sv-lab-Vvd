'include "dut.sv"
'include "interface.sv"

module testbench;
reg clk;
reg en;
reg wr;
reg [4:0] addr;
reg [31:0] w_data;
wire [31:0] r_data;
dut t1(
.clk    (  clk)
.en     (  en  ),
.wr     (  wr  ),
.wr_data(  w_data ),
.rd_data(  r_data ),
.addr   (  addr  )
);
task rom( arb_if.testbench.wr_data, arb_if.testbench.addr, arb_if.testbench.en,arb_if.testbench.wr);
      #10
        arbif.testbench.w_en = 1'b1;
        arbif.testbench.addr     = 5'd1;
        arbif.testbench.wr_data  = 32'd8;
     
        #10
        arbif.testbench.w_en = 1'b1;
        arbif.testbench.addr     = 5'd2;
        arbif.testbench.wr_data  = 32'd5;
        #10
        arbif.testbench.w_en = 1'b1;
        arbif.testbench.addr     = 5'd3;
        arbif.testbench.wr_data  = 32'd7;
        #10
        arbif.testbench.w_en = 1'b1;
        arbif.testbench.addr     = 5'd4;
        arbif.testbench.wr_data  = 32'd9;
        #10
        arbif.testbench.w_en = 1'b0;
        arbif.testbench.en   = 1'b1;
        arbif.testbench.addr     = 5'd1;
       #10
       arbif.testbench.en   = 1'b2;
       #10
       arbif.testbench.en   = 1'b3;
  endtask
  initial begin
      clk     = 0;
en       = 0;
wr       = 0;
w_data     = 0;
addr       = 0;
#10;
 rom (w_data,addr,en,wr);
  end

  initial begin
    forever begin
        #10 clk = ~clk;
    end
  end

endmodule
