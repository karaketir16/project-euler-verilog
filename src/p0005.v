module p0005(
        input clk,
        output reg [31:0] result,
        output reg done = 0
    );

reg [31:0] multipliers [7:0];

function [31:0] res;
    input reg dummy;
    integer i;
    begin
        res = 1;
        for (i = 0; i < 8; i = i + 1) begin
            res = res * multipliers[i];
        end
    end
endfunction

reg state = 0;

always @(posedge clk) begin
    if (done) begin
        
    end
    else if (state == 0) begin 
        multipliers[0] <= 16;
        multipliers[1] <= 9;
        multipliers[2] <= 5;
        multipliers[3] <= 7;
        multipliers[4] <= 11;
        multipliers[5] <= 13;
        multipliers[6] <= 17;
        multipliers[7] <= 19;

        state <= 1;
    end
    else if (state == 1) begin
        result <= res(1);
        done <= 1;
    end
end

endmodule