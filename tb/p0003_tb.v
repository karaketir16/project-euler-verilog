`timescale 1ns/1ps

module p0003_tb();

reg clk = 0;
wire [39:0] out;
wire done;

always #0.5 clk=~clk;

    p0003 u_p0003(
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