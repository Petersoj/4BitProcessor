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
    output reg done = 1, // Processor is initially done
    output reg [3:0] outputReg = 0
    );
    
    reg [3:0] R [3:0] = {0,0,0,0}; // 4 4-Bit registers
    
    reg [2:0] state = 3'b0; // # of states = log2(# of Instructions + 1 (for wait))
    parameter WAIT  = 3'd0,
              LOAD  = 3'b1,
              STORE = 3'd2,
              MOVE  = 3'd3,
              ADD   = 3'd4,
              SUB   = 3'd5,
              AND   = 3'd6,
              NOT   = 3'd7;
    
    always @(posedge clk) begin
        case (state)
            WAIT: begin
                if (execute) begin
                    case (instr[7:6]) // Encoded General Instruction bits 
                        2'b00: begin
                            state <= LOAD;
                        end
                        2'b01: begin
                            state <= STORE;
                        end
                        2'b10: begin
                            state <= MOVE;
                        end
                        2'b11: begin
                            case (instr[1:0]) // Encoded ALU operation bits 
                                2'b00: begin
                                    state <= ADD;
                                end
                                2'b01: begin
                                    state <= SUB;
                                end
                                2'b10: begin
                                    state <= AND;
                                end
                                2'b11: begin
                                    state <= NOT;
                                end
                            endcase
                        end
                    endcase
                end
            end
            LOAD: begin
                R[instr[5:4]] <= instr[3:0];
                state <= WAIT;
            end
            STORE: begin
                outputReg <= R[instr[5:4]];
                state <= WAIT;
            end
            MOVE: begin
                R[instr[5:4]] = R[instr[3:2]];
                state <= WAIT;
            end
            ADD: begin
                R[instr[5:4]] = R[instr[5:4]] + R[instr[3:2]];
                state <= WAIT;
            end
            SUB: begin
                R[instr[5:4]] = R[instr[5:4]] - R[instr[3:2]];
                state <= WAIT;
            end
            AND: begin
                R[instr[5:4]] = R[instr[5:4]] & R[instr[3:2]];
                state <= WAIT;
            end
            NOT: begin
                R[instr[5:4]] = ~R[instr[5:4]];
                state <= WAIT;
            end
        endcase
    end
    
//    always @(posedge clk) begin
//        case (state)
//            LOAD: begin
//                R[instr[5:4]] <= instr[3:0];
//                state <= WAIT;
//            end
//            STORE: begin
//                outputReg <= R[instr[5:4]];
//                state <= WAIT;
//            end
//            MOVE: begin
//                R[instr[5:4]] = R[instr[3:2]];
//                state <= WAIT;
//            end
//            ADD: begin
//                R[instr[5:4]] = R[instr[5:4]] + R[instr[3:2]];
//                state <= WAIT;
//            end
//            SUB: begin
//                R[instr[5:4]] = R[instr[5:4]] - R[instr[3:2]];
//                state <= WAIT;
//            end
//            AND: begin
//                R[instr[5:4]] = R[instr[5:4]] & R[instr[3:2]];
//                state <= WAIT;
//            end
//            NOT: begin
//                R[instr[5:4]] = ~R[instr[5:4]];
//                state <= WAIT;
//            end
//        endcase
//    end
endmodule
