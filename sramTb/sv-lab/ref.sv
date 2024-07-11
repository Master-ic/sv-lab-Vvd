module ref_1 #(
    parameter WIDTH=8,
    parameter DEPTH =32
) (
    input bit             clk   ,
    input logic           en          ,
    input logic           wr          ,
    input logic  [WIDTH-'d1:0]    wr_data     ,
    input logic  [DEPTH-'d1:0]    addr        ,
    output logic  [WIDTH-'d1:0]    rd_data     
    
);
logic [WIDTH-1:0]mem[DEPTH-1:0];

    //initial begin
    //    for (int i = 0; i < DEPTH; i++) begin
    //        mem[i] = '0;
    //    end
    //end

     always_ff @(negedge clk) begin
        if (en && wr) begin
            mem[addr] <= wr_data;
        end
    end

always_comb begin 
    rd_data = {8{((!wr) && en)}} & mem[addr];
    
end
    
endmodule
