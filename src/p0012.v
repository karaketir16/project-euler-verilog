module p0012(
        input clk,
        output reg [39:0] result = 0,
        output reg done = 0,
        output reg error = 0
    );

localparam REQ = 500;


wire [31:0] factor_count_result;
reg start_factor_count = 0;
wire factor_count_done;




reg prev_factor_count_done = 0;

wire rising_factor_count_done = factor_count_done && !prev_factor_count_done;

reg [31:0] counter = 3;
wire [31:0] counter_next = counter + 1;

reg [31:0] a = 0;
reg [31:0] b;

wire [31:0] value_to_test = counter_next % 2 == 0 ? counter_next / 2 : counter_next;


localparam state_CALC = 0;
localparam state_PROCESS = 1;

reg [1:0] param_state = state_CALC;




factor_count factor_count_inst(
    .clk(clk),
    .start(start_factor_count),
    .value(value_to_test),
    .result(factor_count_result),
    .done(factor_count_done)
);

always @(posedge clk) begin
    if (counter_next >= ( 1 << 20))
        error <= 1;

    prev_factor_count_done <= factor_count_done;

    result <= (counter * counter_next) / 2;

    if ( done )begin
    end
    else begin
        case (param_state)
            state_CALC: begin
                if (start_factor_count) begin
                    if( rising_factor_count_done ) begin 
                        start_factor_count <= 0;
                        b <= factor_count_result;
                        param_state <= state_PROCESS;
                    end
                end
                else begin
                    start_factor_count <= 1;
                end
            end
            state_PROCESS: begin
                if ( a * b > REQ ) begin
                    done <= 1;
                end
                else begin
                    counter <= counter + 1;
                    a <= b;
                    param_state <= state_CALC;
                    start_factor_count <= 1;
                end
            end
        endcase
    end
end

endmodule