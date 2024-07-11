interface arb_if(input bit clk);
    logic           en          ;
    logic  [31:0]    addr        ;  
    
    
    logic  [31:0]    ins ;
    logic  [29:0]    pc ;
    logic add ,load ,store ,imodel ;
    logic [4:0] rs1,rs2,rd;
    logic [31:0] ARsram,AWsram;
    logic PrfWen;

    logic           sram_en          ;
    logic           sram_wr          ;
    logic  [7:0]    sram_wr_data     ;
    logic  [7:0]    sram_rd_data     ;
    logic  [31:0]   sram_addr        ;
	
    modport DUT         
                    (input clk ,en , addr );
    modport testbench   
                    (input clk ,  
                    output en ,addr
					);
    modport monitor
                    ( input clk,en,addr );
                    
    modport SRAM         
            (input clk ,sram_en ,sram_wr ,sram_wr_data , sram_addr ,
            output sram_rd_data);
    modport decoder( 
        input ins ,
     output add ,output load ,output store,
     output imodel,
     output rs1,output rs2,output rd,
     output ARsram,output AWsram,
     output PrfWen
    );

        
endinterface