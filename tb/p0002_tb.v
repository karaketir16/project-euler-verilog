`timescale 1ns/1ps

module p0002_tb();

reg clk = 0;
wire [31:0] out;
wire [31:0] a;
wire [31:0] b;
wire overflow;
wire done;

always #0.5 clk=~clk;

    p0002 u_p0002(
        .clk(clk),
        .result(out),
        .overflow(overflow),
        .done(done),
        .fib_0(a),
        .fib_1(b)
    );


initial begin
    #1005;
    $stop;
end

endmodule