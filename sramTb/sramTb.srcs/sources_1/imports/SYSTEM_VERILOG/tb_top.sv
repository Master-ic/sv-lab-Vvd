`include "interface.sv"

module tb_top();
    arb_if tb();  
    dut dut_top(.arbif(tb.DUT));
    monitor monitor_top(.dutRdata(tb.rd_data), .IO(tb.monitor_));

    task Data_from( output logic en, output logic wr, output logic [31:0] addr, output logic [7:0] wr_data);
        en = $urandom%2;
        wr = $urandom%2;
        addr = $urandom_range(0, 31);
        wr_data = $urandom_range(0, 63);
    endtask

    initial begin
        tb.clk = 0;
        forever #5 tb.clk = ~tb.clk; 
    end

    initial begin
      forever begin
          #10 Data_from(tb.en, tb.wr, tb.addr, tb.wr_data);
      end
  end
 

    initial begin
       
        #1000 $finish; 
    end
endmodule
