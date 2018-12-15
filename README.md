# 4BitProcessor
A 4 Bit Processor using Verilog for implementation on an FPGA board.

There are 2 main modules, both of which are state machines: InstructionFSM and ProcessorFSM.
InstructionFSM is used to output instructions from either the pre-programmed code or the single-run-mode instruction encoded via the rightmost DIP switches on the board (can be changed in the constraints file if necessary). It also controls the "execute" output signal which tells the ProcessorFSM to execute the 8-bit instruction given.
ProcessorFSM is the actual processor and is pretty self-explanatory when you look at the code. It's a basic state machine that uses behavioral Verilog for ALU operations and such.

The pre-programmed code (run-mode) is in the InstructionFSM module. Make sure to change the PROGRAM_LINE_COUNT parameter if you are writing a program.
ButtonDebounce is used to debounce the on-board button and ProcessorTop connects inputs from board/constraints file to FSM modules.

The leftmost DIP switch is used to execute either Run-mode (pre-programmed code) or single-run mode (rightmost DIP switches used for instruction encoding).
The execute button is the center button the Basys3.
