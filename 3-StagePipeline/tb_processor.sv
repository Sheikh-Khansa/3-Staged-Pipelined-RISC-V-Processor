`timescale 1ns / 1ps

module tb_processor();

    // add x3, x4, x2
    // 00000000001000100000000110110011

    logic clk;
    logic rst;
    logic [1:0] interrupt;

    Processor dut 
    (
        .clk ( clk ),
        .rst ( rst ),
        .interrupt( interrupt)
    );

    // clock generator
    initial 
    begin
        clk = 0;
        forever 
        begin
            #5 clk = ~clk;
        end
    end

    // reset generator
    initial
    begin
        rst = 1;
        #10;
        rst = 0;
        #1000;
        $finish;
    end

    // initialize memory
    initial
    begin
        $readmemh("inst.mem", dut.instr_memory.instruction_memory);
        $readmemh("rf.mem", dut.register_file.registerfile);
    end

    // dumping the waveform
    initial
    begin
        $dumpfile("processor.vcd");
        $dumpvars(0, dut);
    end

    // initialize memory
    final
    begin
        $writememh("inst_out.mem", dut.instr_memory.instruction_memory);
        $writememh("dmem_out.mem", dut.data_memory.memory);
        $writememh("rf_out.mem", dut.register_file.registerfile);
    end

endmodule