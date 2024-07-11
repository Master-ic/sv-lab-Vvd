module regfile(
    input clk,
    input  rstn,
        
    input[4:0]  Wadd,
    input[31:0]  Wdata,
    input  isWreg,

    input[4:0] Radd1,
    output reg[31:0] Rdata1,

    input[4:0] Radd2,
    output reg[31:0] Rdata2
    
    );

    reg[31:0] regF[0:31];

    always @( posedge clk or negedge rstn)
    if(!rstn)
        begin
        regF[0] <= 32'd0;
        regF[1] <= 32'd0;
        regF[2] <= 32'd0;
        regF[3] <= 32'd0;
        end
    else if(rstn&&isWreg)begin
            regF[Wadd]<=Wdata;
    end

    always @(posedge clk or negedge rstn) begin
        if(~rstn)begin
            Rdata1<=32'b0;
            Rdata2<=32'b0;
        end
        else begin
            Rdata1<=regF[Radd1];
            Rdata2<=regF[Radd2];
        end
            
    end


endmodule