`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2018 06:26:53 PM
// Design Name: 
// Module Name: ProcessorTest
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


module ProcessorTest();

    reg clk;
    reg [7:0] singleInstr;
    reg modeSwitch; // Single-Step Mode = 0, Run-Mode = 1
    reg executeBtn;
    
    wire [3:0] led;
    integer count;
    
    initial begin
        clk = 0;
        singleInstr = 8'b0;
        modeSwitch = 1;
        executeBtn = 0;
        count = 0;
    
        forever #10 clk = ~clk;    
    end
    
    ProcessorTop DUT (.clk(clk), .singleInstr(singleInstr), 
                        .modeSwitch(modeSwitch), .executeBtn(executeBtn),
                        .led(led));
    
    always @(posedge clk) begin
        if (count == 5)
            executeBtn = 1;
        if (count == 10)
            executeBtn = 0;
        count = count + 1;
    end

endmodule
