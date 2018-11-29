`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 03:55:33 PM
// Design Name: 
// Module Name: ProcessorFSM
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


module ProcessorFSM (
    input clk,
    input execute,
    input [7:0] instr,
    output reg done = 0,
    output reg [3:0] outputReg = 0
    );
    
    reg [3:0] R3 = 0, R2 = 0, R1 = 0, R0 = 0;
    
    reg [1:0] state = 2'b00;
    parameter LOAD_INSTR = 2'b01, EXECUTE = 2'b10;
    
    always @(posedge clk) begin
        if (execute == 1) begin
            outputReg = instr[3:0];
        end
    end
endmodule
