module TB;
    class transaction;
        rand int len;
        rand int load;


        constraint c_valid {
            len > 50 && len < 200;
            load > 0 && load < 200;
        }
    endclass
 
    class Producer;
        mailbox #(transaction) prod2cons; 

        function new(mailbox #(transaction) prod2cons);
            this.prod2cons = prod2cons;
        endfunction

        task gen(input int num);
            transaction tr;
            for ( int i = 0; i < num; i++) begin
                tr = new();
                if (!tr.randomize()) $display("Randomization failed at iteration %0d", i);
                prod2cons.put(tr); 
                $display("Transaction put by producer: len = %d, load = %d", tr.len, tr.load);
                #1ns;
            end
        endtask
    endclass
 

    class Consumer;
        mailbox #(transaction) prod2cons;

        function new(mailbox #(transaction) prod2cons);
            this.prod2cons = prod2cons;
        endfunction
 
        task consume();
            transaction tr;
            forever begin
                prod2cons.get(tr);  
                $display("Transaction received by consumer: len = %d, load = %d", tr.len, tr.load);
            end
        endtask
    endclass
 

    mailbox #(transaction) prod2cons = new();
    Consumer cons = new(prod2cons);
    Producer prod = new(prod2cons);
 
    initial begin
        fork
            prod.gen(10);  
            cons.consume();    
        join_any
        disable fork;  
    end
endmodule
