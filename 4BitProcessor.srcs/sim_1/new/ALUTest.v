`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 09:08:22 AM
// Design Name: 
// Module Name: ALUTest
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


module ALUTest();

    reg clk;
    reg [3:0 ] a, b;
    reg [1:0] instr;
    reg en;
    
    wire [3:0] z;
    wire cout;
    
    initial begin
        clk = 0;
        a = 0;
        b = 0;
        instr = 2'b00;
        en = 0;
    
        forever #10 clk = ~clk;    
    end
    
    ALU DUT (.clk(clk), .a(a), .b(b), .instr(instr), .en(en), .z(z), .cout(cout));
    
    always @(posedge clk) begin
        en = 1;
        instr = 2'b00;
        a = a + 1;
        b = b + 1;
    end

endmodule
