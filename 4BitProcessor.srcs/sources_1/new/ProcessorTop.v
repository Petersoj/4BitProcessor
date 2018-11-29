`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 08:14:28 AM
// Design Name: 
// Module Name: ProcessorTop
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


module ProcessorTop (
    input clk,
    input [7:0] singleInstr,
    input modeSwitch, // Single-Step Mode = 0, Run-Mode = 1
    input executeBtn,
    output [3:0] led
    );
    
    wire [7:0] instr;
    wire execute;
    wire done;
    
    InstructionFSM iFSM (.clk(clk), .singleInstr(singleInstr), 
                        .modeSwitch(modeSwitch), .executeBtn(executeBtn),
                        .executeDone(done),
                        .instr(instr), .execute(execute));
    
    ProcessorFSM pFSM (.clk(clk), .execute(execute), .instr(instr),
                        .done(done), .outputReg(led));
endmodule
