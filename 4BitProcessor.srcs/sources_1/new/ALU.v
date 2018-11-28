`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 08:38:49 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input clk,
    input en,
    input [3:0] a, b,
    input [1:0] instr, // Add = 00, Sub = 01, And = 10, Not = 11.
    output reg [3:0] z = 0,
    output reg cout = 0
    );
    
    always @(posedge clk, en) begin
        if (en == 1) begin
            case (instr)
                2'b00: {cout, z} = {1'b0, a} + {1'b0, b};
                2'b01: z = a - b;
                2'b10: z = a & b;
                2'b11: z = ~a;
                default: z = a;
            endcase
        end
    end
    
endmodule
