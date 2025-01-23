`timescale 1ns/1ps

module p0004_tb();

reg clk = 0;
wire [19:0] out;
wire done;

always #0.5 clk=~clk;

    p0004 u_p0004(
        .clk(clk),
        .result(out),
        .done(done)
    );

initial begin
    @(posedge done);
    #5;
    $stop;
end

endmodule