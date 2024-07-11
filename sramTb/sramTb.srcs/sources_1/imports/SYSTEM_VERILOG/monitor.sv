`include "interface.sv"

module monitor(input [7:0]dutRdata ,arb_if.monitor_ IO);


wire [7:0] ref_rd_data;
ref_1#(
    .WIDTH        ( 8 ),
    .DEPTH        ( 32 )
)u_ref_1(
    . clk       (  IO.clk         ),
    . en        (  IO.en         ),
    . wr        (  IO.wr         ),
    .  wr_data  (   IO.wr_data   ),
    .  addr     (   IO.addr      ),
    .  rd_data  (   ref_rd_data  )
);



    always_ff @( posedge IO.clk ) begin : diiff
        


            if(ref_rd_data != dutRdata)begin
                $display("ref_rd_data = %d , dut_rd_data = %d",ref_rd_data ,dutRdata);
                assert (0) ;
            end
            else begin
                $display("Congratulations test PASS!");
                $display("ref_rd_data = %d , dut_rd_data = %d",ref_rd_data ,dutRdata);
                $display("Congratulations test PASS!");
            end

            
    end


endmodule
