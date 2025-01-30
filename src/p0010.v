module p0010(
        input clk,
        output reg [63:0] result = 0,
        output reg done = 0,
        output reg error = 0
    );

reg [0:0] sieve_is_prime [2_000_000:0];

integer i;
initial for (i=0; i<=2_000_000; i=i+1) sieve_is_prime[i] = 1;

reg [1:0] state = 0;
reg [31:0] index = 2;
reg [31:0] muls = 0;

always @(posedge clk) begin
    if ( done )begin
    end
    else begin
        case (state)
            0: begin
                if (index <= 2_000_000) begin
                    if ( sieve_is_prime[index]) begin
                        muls <= index;
                        state <= 1;
                        result <= result + index;
                    end
                    else begin
                        index <= index + 1;
                    end
                end
                else begin
                    done <= 1;
                end
            end
            1: begin
                if (muls > 2_000_000) begin
                    state <= 0;
                    index <= index + 1;
                end
                else begin
                    sieve_is_prime[muls] <= 0;
                    muls <= muls + index;
                end
            end
            default: begin
                error <= 1;
                done <= 1;
            end
        endcase
    end
end

endmodule