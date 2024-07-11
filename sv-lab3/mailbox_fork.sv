module tb;

    // 定义一个包含数据的消息结构体
    typedef struct {
        int data;
    } message_t;

    // 定义一个全局的邮箱
    mailbox my_mailbox;

    // 生产者线程
    initial begin
        automatic message_t msg;

        // 初始化消息
        msg.data = 0;

        // 生产者循环，发送消息到邮箱
        for (int i = 0; i < 5; i++) begin
            // 延时一段时间
            #10;

            // 修改消息内容
            msg.data = i;

            // 发送消息到邮箱
            if (!my_mailbox.try_put(msg)) begin
                $display("Failed to put message %0d into mailbox", i);
            end else begin
                $display("Produced message %0d", i);
            end
        end
    end

    // 消费者线程
    initial begin
        automatic message_t recv_msg;

        // 消费者循环，从邮箱中接收消息
        while (1) begin
            // 尝试从邮箱中接收消息
            if (my_mailbox.try_get(recv_msg)) begin
                $display("Consumed message %0d", recv_msg.data);
            end else begin
                // 等待一段时间再重试
                #5;
            end
        end
    end

endmodule
