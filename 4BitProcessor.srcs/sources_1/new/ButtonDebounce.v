`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 03:59:25 PM
// Design Name: 
// Module Name: ButtonDebounce
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


module ButtonDebounce(
    input b,
    input clk,
    output reg d
    );
    
    reg [1:0] state = 2'b00;
    
    always @(posedge clk) begin
        case (state)
            2'b00: begin
                state <= (b ? 2'b01 : 2'b00);
                d <= 0;
            end
            2'b01: begin
                state <= (b ? 2'b11 : 2'b10);
                d <= 0;
            end
            2'b11: begin
                state <= (b ? 2'b11 : 2'b10);
                d <= 0;
            end
            2'b10: begin
                state <= (b ? 2'b01 : 2'b00);
                d <= 1;
            end
            default: begin
                state <= 2'b00;
                d <= 0;
            end
        endcase
    end
endmodule
