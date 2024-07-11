`include "interface.sv"

module sim_top_sv();
    reg [31:0] sramRdata, ins;
    reg clk, rstn;

    wire [31:0] sramRaddr;
    wire [31:0] sramWaddr;
    wire sramWen;
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


    task inst_add(output [31:0] sramRdata_t, output [31:0] ins_t);
    begin
        sramRdata_t = 32'b1;
        ins_t       = 32'b00_00001_00010_00011_0000_0000_0000_000; // add x3 x2 x1
    end
    endtask

    task inst_load_R(output [31:0] sramRdata_t, output [31:0] ins_t);
    begin
        sramRdata_t = 'b1000;
        ins_t       = 32'b01_0_00001111_00100_0000_0000_0000_0000; // load x4 (Addr15) data='d8;
    end
    endtask

    task inst_load_I(output [31:0] sramRdata_t, output [31:0] ins_t);
    begin
        sramRdata_t = 'b1000;
        ins_t       = 32'b01_1_00001111_00101_0000_0000_0000_0000; // load x5  data='d15;
    end
    endtask

    task inst_store_R(output [31:0] sramRdata_t, output [31:0] ins_t);
    begin
        ins_t       = 32'b10_0_00001010_00101_0000_0000_0000_0000;  // store x5  (addr = 'd10);
    end
    endtask

    task inst_store_I(output [31:0] sramRdata_t, output [31:0] ins_t);
    begin
        ins_t       = 32'b10_1_00001011_0000_1010_0_0000_0000_0000; // load 10  (addr = 'd11);
    end
    endtask

    initial begin
        clk = 0;
        rstn = 0;
        #10; 
        rstn = 1;
        #50;
        inst_add(sramRdata, ins);
        #50;
        inst_load_R(sramRdata, ins);
        #50;
        inst_load_I(sramRdata, ins);
        #50;
        inst_store_R(sramRdata, ins);
        #50;
        inst_store_I(sramRdata, ins);
        #20;
    end

    initial begin
        forever #5 clk = ~clk;
    end

    initial begin
        #1000 $finish;
    end
endmodule
