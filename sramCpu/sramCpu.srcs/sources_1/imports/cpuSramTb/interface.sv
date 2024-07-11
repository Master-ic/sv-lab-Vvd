interface arb_if(input bit clk);
    logic           en;
    logic  [31:0]   ins;  
    logic           rstn;
    logic  [29:0]   pc;
    logic  [31:0]   sramRdata;
    logic           add, load, store, imodel;
    logic [4:0]     rs1, rs2, rd;
    logic [31:0]    ARsram, AWsram;
    logic           PrfWen;

    logic           sram_en;
    logic           sram_wr;
    logic  [31:0]    sram_wr_data;
    logic  [31:0]    sram_rd_data;
    logic  [31:0]   sram_raddr;
    logic  [31:0]   sram_waddr;
    

    modport monitor (input clk ,sram_wr_data  , sram_raddr ,sram_waddr , sram_wr,
    input rs1 ,rs2 ,rd );
    modport decoder (input ins, 
    output add, output load, output store, 
    output imodel, 
    output rs1, output rs2, output rd, 
    output ARsram, output AWsram, output PrfWen);
endinterface
