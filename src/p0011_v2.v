module p0011_v2(
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

function [31:0] get_down;
    input integer i;
    input integer j;
    begin
        get_down = rom_index(i, j) * rom_index(i + 1, j) * rom_index(i + 2, j) * rom_index(i + 3, j);
    end
endfunction

function [31:0] get_right;
    input integer i;
    input integer j;
    begin
        get_right = rom_index(i, j) * rom_index(i, j + 1) * rom_index(i, j + 2) * rom_index(i, j + 3);
    end
endfunction

function [31:0] get_diag_down_right;
    input integer i;
    input integer j;
    begin
        get_diag_down_right = rom_index(i, j) * rom_index(i + 1, j + 1) * rom_index(i + 2, j + 2) * rom_index(i + 3, j + 3);
    end
endfunction

function [31:0] get_diag_down_left;
    input integer i;
    input integer j;
    begin
        get_diag_down_left = rom_index(i, j) * rom_index(i + 1, j - 1) * rom_index(i + 2, j - 2) * rom_index(i + 3, j - 3);
    end
endfunction

function [31:0] max_5;
    input reg [31:0] a;
    input reg [31:0] b;
    input reg [31:0] c;
    input reg [31:0] d;
    input reg [31:0] e;
    begin
        max_5 = a > b ? a : b;
        max_5 = max_5 > c ? max_5 : c;
        max_5 = max_5 > d ? max_5 : d;
        max_5 = max_5 > e ? max_5 : e;
    end
endfunction

integer index_i = 0;
integer index_j = 0;


wire [31:0] down;
wire [31:0] right;   
wire [31:0] diag_right;
wire [31:0] diag_left;

assign down = get_down(index_i, index_j);
assign right = get_right(index_i, index_j);
assign diag_right = get_diag_down_right(index_i, index_j);
assign diag_left = get_diag_down_left(index_i, index_j);

always @(posedge clk) begin
    if ( done )begin
    end
    else begin
        if (index_i < LEN - 3) begin
            if (index_j < LEN - 3) begin
                result <= max_5(down, right, diag_right, diag_left, result);
                index_j <= index_j + 1;
            end
            else begin
                index_i <= index_i + 1;
                index_j <= 0;
            end
        end
        else begin
            done <= 1;
        end
    end
end

endmodule