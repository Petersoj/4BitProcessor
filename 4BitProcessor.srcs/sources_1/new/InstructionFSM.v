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
    
    // Program code (Run-Mode)
    parameter PROGRAM_LINE_COUNT = 4; // The lines of the following PROGRAM array
    reg [7:0] PROGRAM [0:PROGRAM_LINE_COUNT - 1] = {
        8'b00_00_0001,
        8'b00_01_0001,
        8'b00_10_0001,
        8'b00_11_0001
    };
    
    // Program Index Counter
    reg [$clog2(PROGRAM_LINE_COUNT):0] programIndex = 0;
    
    wire btnExecute;
    ButtonDebounce btnDb (.clk(clk), .b(executeBtn), .d(btnExecute));
    
    
    // State Machine
    always @(posedge clk) begin
    
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
