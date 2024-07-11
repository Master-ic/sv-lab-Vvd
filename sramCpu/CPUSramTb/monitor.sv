`timescale 1ns / 1ps
`include "interface.sv"

module monitor(arb_if.monitor io);


    reg [9:0] cnt =0;

    always_ff @(posedge io.clk) begin : counnter
        cnt <= cnt + 'b1;
    end
    always_ff @(posedge io.clk ) begin : MonitorCheck
        if(cnt>='d6 && cnt<='d12)begin
            if(io.rs1=='d1 && io.rs2 == 'd2 && io.rd == 'd3)begin
                $display("add pass");
            end
            else assert (0);

        end
        if(cnt>'d12 && cnt<='d15)begin
            if(io.sram_raddr == 'd15)begin
                $display("loadR pass");
            end
            else assert (0);
        end
        if(cnt>'d17 && cnt<='d20)begin
            if(io.rd == 'd5)begin
                $display("loadI pass");
            end
            else assert (0);
        end
        if(cnt>'d21 && cnt<='d26)begin
            if(io.sram_waddr == 'd10  && io.sram_wr && io.rs1 == 'd5)begin
                $display("storeR pass");
            end
            else assert (0);
        end
        if(cnt>'d27 && cnt<='d70)begin
            if(io.sram_waddr == 'd11 && io.sram_wr_data == 'd10 && io.sram_wr)begin
                $display("storeI pass");
            end
            else assert (0);
        end
    end
endmodule
