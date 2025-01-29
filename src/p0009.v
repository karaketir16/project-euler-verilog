module p0009(
        input clk,
        output reg [31:0] result = 0,
        output reg done = 0,
        output reg error = 0
    );

reg [31:0] b = 1;

wire [31:0] a = (1000*(500-b)) / (1000-b);
wire check_a = (1000*(500-b)) % (1000-b) == 0;

wire [31:0] c = 1000 - a - b;

wire check_sq = a*a + b*b == c*c;
wire check_order = a < b && b < c;

always @(posedge clk) begin
    if (check_a && check_sq && check_order) begin
        result <= a*b*c;
        done <= 1;
    end
    else begin
        if (b == 500) begin
            error <= 1;
            done <= 1;
        end
        else begin
            b <= b + 1;
        end
    end
end

endmodule