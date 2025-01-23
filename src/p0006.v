module p0006(
        input clk,
        output reg [31:0] result,
        output reg done = 0
    );

reg [31:0] sum_of_squares = 0;
reg [31:0] square_of_sum = 0;

function [31:0] square;
    input integer i;
    begin
        square = i * i;
    end
endfunction

reg state = 0;

reg [31:0] val = 1;
reg [31:0] sum = 0;

always @(posedge clk) begin
    if (done) begin
        
    end
    else if (state == 0) begin 
        if (val <= 100) begin
            sum_of_squares <= sum_of_squares + square(val);
            sum <= sum + val;
            val <= val + 1;
        end    
        else begin
            square_of_sum <= square(sum);
            state <= 1;
        end
    end
    else if (state == 1) begin
        result <= square_of_sum - sum_of_squares;
        done <= 1;
    end
end

endmodule