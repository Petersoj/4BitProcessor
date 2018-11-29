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
    parameter PROGRAM_LINE_COUNT = 1; // The lines of the following PROGRAM array
    reg [7:0] PROGRAM [0:PROGRAM_LINE_COUNT - 1] = {
        8'b00_00_1010
    };
    // Program Index Counter
    reg [$clog2(PROGRAM_LINE_COUNT):0] programIndex = 0;
    
    wire btnExecute;
    ButtonDebounce btnDb (.clk(clk), .b(executeBtn), .d(btnExecute));
    
    always @(posedge clk) begin
        
    end
    
    
    reg programExecute = 0;
    wire btnExecute;
    wire execute;
    wire [7:0] instr;
    wire done;
    assign instr = modeSwitch ? PROGRAM[programIndex] : singleInstr;
    assign execute = modeSwitch ? programExecute : btnExecute;
        
    // Program index counter logic
        always @(done) begin
            if (clk == 1 && modeSwitch == 1) begin
                if (programIndex == PROGRAM_LINE_COUNT) begin
                    programIndex = 0;
                    programExecute = 0;
                end else begin
                    programIndex = programIndex + 1;
                    programExecute = 1;
                end
            end
        end
    
endmodule
