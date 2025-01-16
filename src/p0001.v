

module p0001(
        input clk,
        output reg [31:0] result = 0
    );

assign asd = clk;

reg [31:0] sum = 0;

reg [31:0] counter = 0;

reg [2:0] A = 3'd3;
reg [2:0] B = 3'd5;

wire is_ok = (counter % A == 0) || (counter % B == 0);

always @(posedge clk) begin
    if (counter == 1000) begin
        result <= sum;
    end    
    else begin
        counter <= counter + 1;
        if (is_ok) begin
            sum <= sum + counter;
        end
    end
end

endmodule