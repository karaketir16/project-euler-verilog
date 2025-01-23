module p0004(
        input clk,
        output wire [19:0] result,
        output reg done = 0
    );

reg [9:0] multiplier_1 = 10'd999;
reg [9:0] multiplier_2 = 10'd999;

reg [19:0] largest_palindrome = 0;

assign result = largest_palindrome;

function integer reverse_integer;
    input integer a;
    integer reversed;
    integer i;
    begin
        reversed = 0; // Initialize reversed to 0
        for (i = 0; i < 6; i = i + 1) begin
            reversed = reversed * 10 + (a % 10); // Extract and append the last digit
            a = a / 10; // Remove the last digit
        end
        for (i = 0; i < 6; i = i + 1) begin
            if (reversed % 10 == 0) begin
                reversed = reversed / 10;
            end
        end
        reverse_integer = reversed;
    end
endfunction

// Function to find the maximum of two integers
function reg is_palindrome;
    input integer a;
    begin
        is_palindrome = (a == reverse_integer(a));
    end
endfunction


wire [19:0] multiplied = multiplier_1 * multiplier_2;

wire [19:0] control = multiplier_1 * multiplier_1;

always @(posedge clk) begin
    if (done) begin
        
    end
    else begin 
        if (control < largest_palindrome) begin
            done <= 1;
        end
        else if (multiplied > largest_palindrome) begin
            if (is_palindrome(multiplied)) begin
                largest_palindrome = multiplied;
                multiplier_1 <= multiplier_1 - 10'd1;
                multiplier_2 <= multiplier_1 - 10'd1;
            end
            else begin
                multiplier_2 <= multiplier_2 - 10'd1;
            end
        end
        else begin
            multiplier_1 <= multiplier_1 - 10'd1;
            multiplier_2 <= multiplier_1 - 10'd1;
        end
    end
end

endmodule