interface cpu_interface;
    logic clk;
    logic reset;
    logic [31:0] instruction;
    inout logic [7:0] sram_data;
    logic [7:0] sram_addr;
    logic sram_we;
endinterface

module sram (
    input logic clk,
    input logic [7:0] addr,
    inout logic [7:0] data,
    input logic we
);
    logic [7:0] mem [0:255];

    assign data = we ? 8'bz : mem[addr];

    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr] <= data;
        end
    end
endmodule

module simple_cpu (
    cpu_interface intf
);

    // 寄存器定义
    logic [7:0] reg_file [0:3];

    // 指令字段解析
    logic [1:0] opcode;
    logic [1:0] reg1_id, reg2_id, out_reg_id, des_reg_id;
    logic [7:0] src_addr, des_addr, data;

    assign opcode = intf.instruction[31:30];
    assign reg1_id = intf.instruction[29:28];
    assign reg2_id = intf.instruction[27:26];
    assign out_reg_id = intf.instruction[25:24];
    assign des_reg_id = intf.instruction[23:22];
    assign src_addr = intf.instruction[21:14];
    assign des_addr = intf.instruction[13:6];
    assign data = intf.instruction[7:0];

    always_ff @(posedge intf.clk or posedge intf.reset) begin
        if (intf.reset) begin
            // 重置寄存器
            reg_file[0] <= 8'b0;
            reg_file[1] <= 8'b0;
            reg_file[2] <= 8'b0;
            reg_file[3] <= 8'b0;
        end else begin
            case (opcode)
                2'b00: begin // ADD 指令
                    reg_file[out_reg_id] <= reg_file[reg1_id] + reg_file[reg2_id];
                end
                2'b01: begin // LOAD 指令
                    if (intf.instruction[21]) begin
                        // 从SRAM加载
                        intf.sram_addr <= src_addr;
                        intf.sram_we <= 0;
                        reg_file[des_reg_id] <= intf.sram_data;
                    end else begin
                        // 立即数加载
                        reg_file[des_reg_id] <= data;
                    end
                end
                2'b10: begin // STORE 指令
                    if (intf.instruction[21]) begin
                        // 存储到SRAM
                        intf.sram_addr <= des_addr;
                        intf.sram_data <= reg_file[src_addr];
                        intf.sram_we <= 1;
                    end else begin
                        // 立即数存储
                        intf.sram_addr <= des_addr;
                        intf.sram_data <= data;
                        intf.sram_we <= 1;
                    end
                end
                default: begin
                    // 无效指令，保留
                end
            endcase
        end
    end
endmodule

// module top;
//     cpu_interface intf();

//     // 初始化信号
//     initial begin
//         intf.clk = 0;
//         intf.reset = 1;
//         #5 intf.reset = 0;
//     end

//     always #5 intf.clk = ~intf.clk; // 生成时钟信号

//     simple_cpu cpu_inst (
//         .intf(intf)
//     );

//     sram sram_inst (
//         .clk(intf.clk),
//         .addr(intf.sram_addr),
//         .data(intf.sram_data),
//         .we(intf.sram_we)
//     );
// endmodule
