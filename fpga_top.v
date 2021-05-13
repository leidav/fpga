module Top(input wire clk_25mhz,
           input wire [6:0] btn,
           output wire [7:0] led,
           output wire wifi_gpio0);

    // Tie GPIO0, keep board from rebooting
    assign wifi_gpio0 = 1'b1;

    reg [15:0] reset_cnt = 0;
    reg reset = 1'b1;

    always @(posedge clk_25mhz) begin
        if(reset_cnt != 32'hffff) begin
            reset_cnt <= reset_cnt + 1;
        end
        else begin
            reset = 0;
        end
    end

    //blinky bl (clk_25mhz,btn,led);
    Shifter shifter (clk_25mhz,btn[0],btn[1],led);

endmodule
