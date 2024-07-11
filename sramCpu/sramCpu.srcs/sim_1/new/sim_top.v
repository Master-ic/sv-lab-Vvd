
`include "interface.sv"

module sim_top();
    reg [31:0] sramRdata ,ins;
    reg clk ,rstn=0;
    
wire [31:0] sramRaddr;
wire [31:0] sramWaddr;
wire  sramWen  ;
wire [31:0] sramWdata;
   

      Cpu u_Cpu(
    .sramRaddr ( sramRaddr ),
    .sramWaddr ( sramWaddr ),
    .sramWen   ( sramWen   ),
    .sramWdata ( sramWdata ),
    .sramRdata ( sramRdata ),
    .clk       ( clk       ),
    .rstn      ( rstn      ),
    .ins       ( ins       )
);



    
 task instG(output [31:0] sramRdata_t,output [31:0]ins_t);
 begin
 sramRdata_t = 32'b1;
 ins_t       = {15'b00_00001_00010_00011,17'b00000000000000000};//add x3 x2 x1
 end
endtask
    initial begin
       clk = 0;
       rstn = 1;
       #10; 
	   instG(sramRdata,ins);
    end

    initial begin
        forever #5 clk = ~clk;
        #1000 $finish;
        
    end
endmodule
