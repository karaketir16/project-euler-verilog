`timescale 1ns/1ps

module p0012_tb();

reg clk = 0;
wire [39:0] out;
wire done;
wire error;

always #0.5 clk=~clk;

    p0012 u_p0012(
        .clk(clk),
        .result(out),
        .done(done),
        .error(error)
    );

initial begin
    @(posedge done or posedge error);
    #5;
    $display("out = %d", out);
    $display("done = %d", done);
    $display("error = %d", error);
    $stop;
end

endmodule