module is_prime(
        input clk,
        input start,
        input [31:0] value,
        output reg result,
        output reg done = 0
    );

reg [31:0] counter = 0;
reg prev_start = 0;

always @(posedge clk) begin
    prev_start <= start;

    if (start == 1 && prev_start == 0) begin
        counter <= 2;
        done <= 0;
    end 
    else if ( done ) begin
    
    end
    else if (value <= 1) begin
        done <= 1;
        result <= 0;
    end
    else if (counter * counter > value) begin
        done <= 1;
        result <= 1;
    end
    else begin
        if (value % counter == 0) begin
            result <= 0;
            done <= 1;
        end
        counter <= counter + 1;
    end
end

endmodule