`timescale 1ns/1ps

module p0007_tb();

reg clk = 0;
wire [31:0] out;
wire done;
wire error;

always #0.5 clk=~clk;

    p0007 u_p0007(
        .clk(clk),
        .result(out),
        .done(done),
        .error(error)
    );

initial begin
    @(posedge done or posedge error);
    #5;
    $stop;
end

endmodule