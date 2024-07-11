interface arb_if(input bit clk);
    logic           en          ;
    logic           wr          ;
    logic  [7:0]    wr_data     ;
    logic  [7:0]    rd_data     ;
    logic  [31:0]    addr        ;
    // logic [7:0] dutRdata;
    modport DUT         
                    (input clk ,en ,wr ,wr_data , addr ,
                        output rd_data);
    modport testbench   
                    (input clk , rd_data , 
                    output en ,wr ,wr_data , addr);
    modport monitor_
                    (
                        input clk,en,wr,wr_data,addr,
                        output rd_data
                    );
endinterface

// interface arbif(input clk);
// logic access_en;
// logic RD_WR;
// logic[7:0] addr;
// logic [31:0] data_in;
// logic[31:0] data_out;
// modport SRAM(
// input clk,access_en,RD_WR,data_in,
// output data_out);
// modport test (
// input clk,data_out,
// output access_en,RD_WR,data_in);
// modport Monitor (
// input clk,access_en,RD_WR,data_in,data_out);
// endinterface