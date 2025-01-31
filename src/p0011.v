module p0011(
        input clk,
        output reg [31:0] result = 0,
        output reg done = 0,
        output reg error = 0
    );

localparam LEN = 20;

reg [7:0] rom [0:LEN*LEN - 1];

initial $readmemh("p0011.mem", rom);

function [7:0] rom_index;
    input integer i;
    input integer j;
    begin
        if (i < 0 || i >= LEN || j < 0 || j >= LEN) begin
            rom_index = 0;
        end
        else begin
            rom_index = rom[i*LEN + j];
        end
    end
endfunction

integer i = 0;
integer j = 0;

localparam state_down = 3'd0;
localparam state_right = 3'd1;
localparam state_diag = 3'd2;
localparam state_diag_2 = 3'd3;

reg [2:0] state = state_down;
reg [2:0] inner_state = 3'd0;
reg [31:0] tmp = 1;

wire [31:0] debug_reg;
assign debug_reg = rom_index(i + inner_state, j);

always @(posedge clk) begin
    if ( done )begin
    end
    else begin
        if (i < LEN - 3) begin
            if (j < LEN - 3) begin
                case (state)
                    state_down: begin
                        if (inner_state < 4) begin
                            tmp <= tmp * rom_index(i + inner_state, j);
                            inner_state <= inner_state + 1;
                        end
                        else begin
                            result <= result > tmp ? result : tmp;
                            inner_state <= 0;
                            tmp <= 1;
                            state <= state_right;
                        end
                    end
                    state_right: begin
                        if (inner_state < 4) begin
                            tmp <= tmp * rom_index(i, j + inner_state);
                            inner_state <= inner_state + 1;
                        end
                        else begin
                            result <= result > tmp ? result : tmp;
                            inner_state <= 0;
                            tmp <= 1;
                            state <= state_diag_2;
                        end
                    end
                    state_diag_2: begin
                        if (inner_state < 4) begin
                            tmp <= tmp * rom_index(i + inner_state, j - inner_state);
                            inner_state <= inner_state + 1;
                        end
                        else begin
                            result <= result > tmp ? result : tmp;
                            inner_state <= 0;
                            tmp <= 1;
                            state <= state_diag;
                        end
                    end
                    state_diag: begin
                        if (inner_state < 4) begin
                            tmp <= tmp * rom_index(i + inner_state, j + inner_state);
                            inner_state <= inner_state + 1;
                        end
                        else begin
                            result <= result > tmp ? result : tmp;
                            inner_state <= 0;
                            tmp <= 1;
                            state <= state_down;
                            j <= j + 1;
                        end
                    end
                    default: begin
                        error <= 1;
                        done <= 1;
                    end
                endcase
            end
            else begin
                i <= i + 1;
                j <= 0;
            end
        end
        else begin
            done <= 1;
        end
    end
end

endmodule