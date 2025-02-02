module factor_count(
        input clk,
        input start,
        input [31:0] value,
        output reg [31:0] result = 1,
        output reg done = 0
    );

reg [31:0] counter = 2;
reg [31:0] tmp;

reg [31:0] pow_counter;

reg prev_start = 0;

always @(posedge clk) begin
    prev_start <= start;

    if (start == 1 && prev_start == 0) begin
        counter <= 2;
        tmp <= value;
        pow_counter <= 0;

        done <= 0;
        result <= 1;
    end 
    else if ( done ) begin
    
    end
    else if (tmp % counter == 0) begin
        pow_counter <= pow_counter + 1;
        tmp <= tmp / counter;
    end
    else begin
        if (pow_counter > 0) begin
            result <= result * (pow_counter + 1);
            pow_counter <= 0;
        end
        counter <= counter + 1;

        if (tmp <= 1) begin
            done <= 1;
        end
    end
end

endmodule