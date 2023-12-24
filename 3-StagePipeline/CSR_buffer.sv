module CSR_buffer
(
    input  logic        clk, 
    input  logic        rst, 
    input  logic [31:0] in, 
    output logic [31:0] out
    
);
	always_ff @(posedge clk) begin
		if (rst) out <= 0;
		else out <= in;
	end
endmodule
