`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2018 01:57:10 PM
// Design Name: 
// Module Name: InstructionFSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InstructionFSM (
    input clk,
    input [7:0] singleInstr,
    input modeSwitch, // Single-Step Mode = 0, Run-Mode = 1
    input executeBtn,
    input executeDone,
    output reg [7:0] instr = 0,
    output reg execute = 0
    );
    
    // Parameterized Processor Instructions
    parameter LOAD = 2'b00,
              STORE = 2'b01,
              MOVE = 2'b10,
              ALU = 2'b11,
              ADD = 2'b00,
              SUB = 2'b01,
              AND = 2'b10,
              NOT = 2'b11,
              REG_0 = 2'b00,
              REG_1 = 2'b01,
              REG_2 = 2'b10,
              REG_3 = 2'b11;
    
    // Program code (Run-Mode)
    parameter PROGRAM_LINE_COUNT = 7; // The lines of the following PROGRAM array
    reg [7:0] PROGRAM [0:PROGRAM_LINE_COUNT - 1] = {
        {LOAD, REG_0, 4'b0001}, // Load 1 into REG_0
        {LOAD, REG_1, 4'b0010}, // Load 2 into REG_1
        {LOAD, REG_2, 4'b1001}, // Load 9 into REG_2
        {LOAD, REG_3, 4'b0100}, // Load 4 into REG_3
        {ALU, REG_0, REG_1, ADD}, // REG_0 = REG_0 + REG_1
        {ALU, REG_2, REG_3, SUB}, // REG_2 = REG_2 - REG_3
        {STORE, REG_2, 4'b0000} // LED & 7-Seg = REG_2 = 5
    };
    
    // Program Index Counter
    reg [$clog2(PROGRAM_LINE_COUNT):0] programIndex = 0;
    
    wire btnExecute;
    ButtonDebounce btnDb (.clk(clk), .b(executeBtn), .d(btnExecute));
    
    reg [2:0] state = 3'b000;
    parameter WAIT = 3'd0,
              EXECUTE = 3'd1,
              RUN_MODE_EXECUTE = 3'd2,
              SINGLE_MODE_EXECUTE = 3'd3,
              RUN_MODE_INSTR_EXECUTE = 3'd4,
              RUN_MODE_INSTR_DONE = 3'd5;

    // State Machine
    always @(posedge clk) begin
        case (state)
            WAIT: begin
                execute <= 0;
                state <= btnExecute ? EXECUTE : WAIT;
            end
            EXECUTE: begin
                state <= modeSwitch ? RUN_MODE_EXECUTE : SINGLE_MODE_EXECUTE;
            end
            RUN_MODE_EXECUTE: begin
                if (programIndex == PROGRAM_LINE_COUNT) begin
                    programIndex <= 0;
                    execute <= 0;
                    state <= WAIT;
                end else begin
                    state <= RUN_MODE_INSTR_EXECUTE;
                end         
            end
            RUN_MODE_INSTR_EXECUTE: begin
                instr <= PROGRAM[programIndex];
                execute <= 1;
                state <= executeDone ? RUN_MODE_INSTR_DONE : RUN_MODE_INSTR_EXECUTE;
            end
            RUN_MODE_INSTR_DONE: begin
                programIndex <= programIndex + 1;
                state <= RUN_MODE_EXECUTE;
            end
            SINGLE_MODE_EXECUTE: begin
                instr <= singleInstr;
                execute <= 1;
                state <= executeDone ? WAIT : SINGLE_MODE_EXECUTE;
            end
        endcase
    end
    
//    reg executingProgram = 0;
    
//    always @(posedge clk) begin
//        if (executeDone) begin // Only change instr if ProcessorFSM is done executing
//            if (modeSwitch) begin // Run-mode
//                if (executingProgram) begin
//                    if (programIndex == PROGRAM_LINE_COUNT - 1) begin
//                        executingProgram <= 0;
//                        programIndex <= 0;
//                        execute <= 0;
//                    end else begin // programIndex < PROGRAM_LINE_COUNT
//                        // #2; // Short delay for ProcessorFSM to execute first
//                        instr <= PROGRAM[programIndex - 1];
//                        programIndex <= programIndex + 1;
//                        execute = 1;
//                    end
//                end else begin // executingProgram == 0
//                    execute = 0;
//                    if (btnExecute) begin // executeBtn pressed
//                        executingProgram = 1;
//                    end 
//                end
//            end else begin // Single-Step mode
//                execute = 0;
//                if (btnExecute) begin
//                    instr = singleInstr;
//                    execute = 1; 
//                end
//            end
//        end
//    end
endmodule
