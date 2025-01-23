`timescale 1ns/1ps

module p0006_tb();

reg clk = 0;
wire [31:0] out;
wire done;

always #0.5 clk=~clk;

    p0006 u_p0006(
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