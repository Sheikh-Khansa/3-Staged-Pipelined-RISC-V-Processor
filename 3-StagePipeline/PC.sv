module PC
(
    input  logic        clk, 
    input  logic        rst, 
    input  logic        stall, 
    input  logic [31:0] B, 
    output logic [31:0] A
    
);
    always_ff @(posedge clk) begin
    	if (rst) A<= 0;
    	else if (~stall) A <= B;
    end
endmodule