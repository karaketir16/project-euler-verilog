`timescale 1ns/1ps

module is_prime_tb();

reg clk = 1;
reg start = 0;
reg [31:0] value = 0;
wire result;
wire done;


always #0.5 clk=~clk;


is_prime u_is_prime(
    .clk(clk),
    .start(start),
    .value(value),
    .done(done),
    .result(result)
);


integer i;
initial begin
    
    for (i = 0; i < 100; i = i + 1) begin
        value = value + 1; #10;
        start = 1; #11;
        start = 0; #10;
        #10000;   
        if (done == 1) begin
            $display("Value %d is %s", value, result ? "prime" : "not prime");
        end
        else begin
            $display("Not Done Yet, error");
            $stop;
        end
    end
    $stop;
end

endmodule