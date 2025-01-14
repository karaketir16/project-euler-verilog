`timescale 1ns/1ps



module p0001_tb();

reg clk = 0;
wire [31:0] out;

always #0.5 clk=~clk; //now you create your cyclic clock

    p0001 u_p0001(
        .clk(clk),
        .result(out)
    );


initial begin
    #1005;
    $stop;
end

endmodule