`timescale 1ns/1ps

module factor_count_tb();

reg clk = 1;
reg start = 0;
reg [31:0] value = 0;
wire [31:0] result;
wire done;


always #0.5 clk=~clk;


factor_count u_factor_count(
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
            $display("Value %d has %d factor", value, result);
        end
        else begin
            $display("Not Done Yet, error");
            $stop;
        end
    end
    $stop;
end

endmodule