module PipelineControl
(
    input  logic       clk, 
    input  logic       reg_wr, 
    input  logic       wr_en, 
    input  logic       rd_en, 
    input  logic       stall, 
    input  logic       csr_reg_rd, 
    input  logic       csr_reg_wr, 
    input  logic       is_mret, 
    input  logic [1:0] wb_sel, 
	
    output logic       reg_wrMW, 
    output logic       wr_enMW, 
    output logic       rd_enMW, 
    output logic       csr_reg_rdMW,
    output logic       csr_reg_wrMW, 
    output logic       is_mretMW, 
    output logic [1:0] wb_selMW
    
);
	always_ff @(posedge clk) begin
		if (~stall) begin
			reg_wrMW <= reg_wr;
			wr_enMW  <= wr_en;
			rd_enMW  <= rd_en;
			wb_selMW <= wb_sel;
			csr_reg_rdMW <= csr_reg_rd;
			csr_reg_wrMW <= csr_reg_wr;
			is_mretMW <= is_mret;
		end
	end
endmodule