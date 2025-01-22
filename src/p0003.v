module p0003(
        input clk,
        output reg [39:0] result,
        output reg done = 0
    );

reg [39:0] value = 64'd600_851_475_143;

reg [31:0] value_to_test = 2;

reg [39:0] largest_prime_factor = 0;

assign result = largest_prime_factor;

wire is_prime_result;
reg start_is_prime = 0;
wire is_prime_done;


is_prime is_prime_inst(
    .clk(clk),
    .start(start_is_prime),
    .value(value_to_test),
    .result(is_prime_result),
    .done(is_prime_done)
);

reg prev_is_prime_done = 0;

wire rising_is_prime_done = is_prime_done && !prev_is_prime_done;

always @(posedge clk) begin
    prev_is_prime_done <= is_prime_done;

    if (done) begin
        
    end
    else if (value_to_test * value_to_test > value) begin
        done <= 1;
        largest_prime_factor <= value;
    end
    else if (value % value_to_test == 0) begin
        if (start_is_prime) begin
            if( rising_is_prime_done ) begin 
                start_is_prime <= 0;
                if (is_prime_result) begin
                    largest_prime_factor <= value_to_test;
                    value <= value / value_to_test;
                end
                else begin
                    value_to_test <= value_to_test + 1;
                end
            end
        end
        else begin
            start_is_prime <= 1;
        end
    end
    else begin
        value_to_test <= value_to_test + 1;
    end
end

endmodule