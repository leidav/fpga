module Shifter (input wire clk, 
                input wire btn, 
                input wire reset, 
                output wire [7:0] lights);

    reg [7:0] register;
    assign lights = register;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            register<=1;
        end

        else begin 
            if(!btn) begin
                register <=register<<1;
                register[0]<=register[7];
            end
        end
    end
endmodule