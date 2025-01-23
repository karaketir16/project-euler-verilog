module p0007(
        input clk,
        output reg [31:0] result,
        output reg done = 0,
        output reg error = 0
    );

reg [31:0] max_val = 32'hFFFFFFFF;

reg [13:0] counter = 1;
reg [31:0] value_to_test = 2;

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
    else begin
        if (start_is_prime) begin
            if( rising_is_prime_done ) begin 
                start_is_prime <= 0;
                if (is_prime_result) begin
                    if (counter == 10_001) begin 
                        result <= value_to_test;
                        done <= 1;
                    end
                    else begin
                        counter <= counter + 1;
                        value_to_test <= value_to_test + 1;
                    end
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
end

endmodule