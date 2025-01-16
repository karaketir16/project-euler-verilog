module p0002(
        input clk,
        output wire [31:0] result,
        output wire overflow,
        output reg done = 0,
        reg [31:0] fib_0 = 0,
        reg [31:0] fib_1 = 1
    );

reg [32:0] sum = 0;

assign result = sum[31:0];
assign overflow = sum[32];

always @(posedge clk) begin
    if (fib_1 > 4_000_000 || overflow) begin
        done <= 1;
    end    
    else begin
        fib_0 <= fib_1;
        fib_1 <= fib_0 + fib_1;
        if (fib_1[0] == 0) begin
            sum <= sum + fib_1;
        end
    end
end

endmodule