module InstructionMemory
(
    input  logic [31:0] addr, 
    output logic [31:0] instruction
    
);
    logic [31:0] instruction_memory [31:0];    
    initial begin
        $readmemh("inst.mem", instruction_memory);	
    end
    assign instruction = instruction_memory[addr[31:2]];
endmodule
