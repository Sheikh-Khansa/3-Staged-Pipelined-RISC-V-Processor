# 3-Staged-Pipelined-RISC-V-Processor
This repository features a 3-stage pipelined RISC-V processor, designed for efficient instruction execution. Based on the RISC-V ISA, it balances performance and simplicity with the following pipeline stages:

**Stage-1** Instruction Fetch (IF)

**Stage-2** Instruction Decode (ID) and Execute (EX)

**Stage-3** Memory(MEM) and Write Back(WB)

The files decsription is in the [report](https://github.com/Sheikh-Khansa/3-Staged-Pipelined-RISC-V-Processor/blob/main/Report.pdf).

# Guidelines
Follow the following guidlines

# Compilation
To compile the files, write the following command:

`vlog *.sv `

Compilation will create a work folder in your current working directory in which all the files generated after compilation are stored.

# Simulation
The compiled code can be simulated with command:

`vsim -c name_of_toplevel_module -do "run -all"`

This simulation will create a .vcd file. This dumpfile contains all the simulation behaviour of design.

# Viewing the VCD Waveform File
To view the waveform of the design run the command:

`gtkwave dumfile_name.vcd`

This opens a waveform window. Pull the required signals in the waveform and verify the behaviour of the design.
