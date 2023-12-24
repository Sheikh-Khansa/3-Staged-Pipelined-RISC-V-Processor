module Pipeline_Branch
(
    input  logic clk, 
    input  logic stall, 
    input  logic flush, 
    input  logic in, 
	output logic out
    
);
	always_ff @(posedge clk) begin
		if (flush) out <= 0;
		else if (~stall) out <= in;
	end
endmodule