module Controller
(
    input  logic [31:0] instruction,
	output logic [3:0] alu_op, 
    output logic [2:0] mask, 
    output logic [2:0] br_type, 
    output logic       reg_wr, 
    output logic       sel_A, 
    output logic       sel_B, 
    output logic       rd_en, 
    output logic       wr_en, 
    output logic       CSR_reg_wr, 
    output logic       CSR_reg_rd, 
    output logic       is_mret, 
    output logic [1:0] wb_sel
    
);
	logic [2:0] func3;
	logic [6:0] func7;
	logic [6:0] opcode;
	
	always_comb begin
		func3 <= instruction[14:12];
		func7 <= instruction[31:25];
		opcode <= instruction[6:0];
	end

    always_comb begin
    	case (opcode)
    		7'b0110011: begin	// R-type instructions
    			reg_wr <= 1;
    			sel_A <= 1;
    			sel_B <= 0;
    			rd_en <= 0;
    			wb_sel <= 0;
				case (func3)
					3'b000: 
                    begin 
                        if (func7 == 7'b0100000) 
                            alu_op <= 9; 
                        else 
                            alu_op <= 0; 
                    end
					3'b001:	alu_op <= 1;
					3'b010:	alu_op <= 2;
					3'b011:	alu_op <= 3;
					3'b100:	alu_op <= 4;
					3'b101: 
                    begin 
                        if (func7 == 7'b0100000) 
                            alu_op <= 6; 
                        else 
                            alu_op <= 5; 
                    end
					3'b110:	alu_op <= 7;
					3'b111:	alu_op <= 8;
				endcase
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
			end
			7'b0010011: begin	// I-type instructions
    			reg_wr <= 1;
    			sel_A <= 1;
    			sel_B <= 1;
    			rd_en <= 0;
    			wb_sel <= 0;
				case (func3)
					3'b000: alu_op <= 0;
					3'b001:	alu_op <= 1;
					3'b010:	alu_op <= 2;
					3'b011:	alu_op <= 3;
					3'b100:	alu_op <= 4;
					3'b101: 
                    begin 
                        if (func7 == 7'b0100000)
                            alu_op <= 6; 
                        else 
                            alu_op <= 5; 
                    end
					3'b110:	alu_op <= 7;
					3'b111:	alu_op <= 8;
				endcase
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
			end
			7'b0000011: begin	// Load instructions
    			reg_wr <= 1;
    			sel_A <= 1;
    			sel_B <= 1;
    			rd_en <= 1;
    			wr_en <= 0;
    			wb_sel <= 1;
    			alu_op <= 0;
    			mask <= func3;
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
			end
			7'b0100011: begin	// S-type instructions
    			reg_wr <= 0;
    			sel_A <= 1;
    			sel_B <= 1;
    			rd_en <= 0;
    			wr_en <= 1;
    			wb_sel <= 1;
    			alu_op <= 0;
    			mask <= func3;
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
			end			
			7'b1100011: begin	// B-type instructions
    			reg_wr <= 0;
    			sel_A <= 0;
    			sel_B <= 1;
    			rd_en <= 0;
    			wr_en <= 0;
    			wb_sel <= 0;
    			alu_op <= 0;
    			br_type <= func3;
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
			end			
			7'b0110111: begin	// U-type instructions
    			reg_wr <= 1;
    			sel_A <= 1;
    			sel_B <= 1;
    			rd_en <= 0;
    			wr_en <= 0;
    			wb_sel <= 0;
    			alu_op <= 0;
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
    		end
			7'b1101111: begin	// J-type instructions
    			reg_wr <= 1;
    			sel_A <= 0;
    			sel_B <= 1;
    			rd_en <= 0;
    			wr_en <= 0;
    			wb_sel <= 2;
    			alu_op <= 0;
				CSR_reg_wr = 0; 
				CSR_reg_rd = 0;
				is_mret = 0;
    		end
			7'b1110011: begin	// CSRRW instructions
    			reg_wr <= 1;
    			sel_A <= 1;
    			sel_B <= 0;
    			rd_en <= 0;
    			wr_en <= 1;
    			wb_sel <= 3;
				case (func3)
					3'b000: begin  is_mret <= 1; CSR_reg_wr = 0; CSR_reg_rd = 0; end // MRET instruction
		        	3'b001: begin  is_mret <= 0; CSR_reg_wr = 1; CSR_reg_rd = 0; end
		        	3'b010: begin  is_mret <= 0; CSR_reg_wr = 0; CSR_reg_rd = 1; end
				endcase
    		end
		endcase
	end
endmodule