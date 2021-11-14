/*
 * Assignment     : KGPRISC
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module instruction_decoder(
    input [31:0] instruction,
    input [31:0] PC,
    output reg [2:0] opcode,
    output reg [3:0] func_code,
    output reg [4:0] rs, rt,
    output reg [31:0] imm,
    output reg [31:0] label
    );
    always @(*) begin
        label <= 32'b0;
        imm <= 32'b0;
        case(instruction[31:29])
            3'b000: begin                           // R-Format
                opcode <= instruction[31:29];
                rs <= instruction[28:24];
                rt <= instruction[23:19];
                imm[31:5] <= 25'b0;
                imm[4:0] <= instruction[18:14];
                func_code <= instruction[13:10];
            end
            3'b001: begin                           // I-Format
                opcode <= instruction[31:29];
                rs <= instruction[28:24];
                rt <= 5'bx;
                imm[31:20] <= {12{instruction[23]}};
                imm[19:0] <= instruction[23:4];
                func_code <= instruction[3:0];
            end
            3'b010:                                 // Load/Store
            begin
                opcode <= instruction[31:29];
                rs <= instruction[28:24];
                rt <= instruction[23:19];
                imm[31:18] <= {14{instruction[18]}};
                imm[17:0] <= instruction[18:1];
                func_code <= instruction[0:0];
            end
            3'b011:                                 // B1-Format
            begin
                if(func_code == 4'b0001) begin      // bl (Branch and Link Instruction)
                    opcode <= instruction[31:29];
                    rs <= 5'b00000;
                    rt <= 5'b11111;
                    imm <= PC + 1;
                    label[31:25] <= 7'b0;
                    label[24:0] <= instruction[28:4];
                    func_code <= instruction[3:0];
                end
                else begin
                    opcode <= instruction[31:29];
                    rs <= 5'bx;
                    rt <= 5'bx;
                    label[31:25] <= 7'b0;
                    label[24:0] <= instruction[28:4];
                    func_code <= instruction[3:0];
                end
            end
            3'b100:                                 // B2-Format
            begin
                opcode <= instruction[31:29];
                rs <= instruction[28:24];
                rt <= 5'bx;
                func_code <= instruction[23:20];
            end
            3'b101:                                 // B3-Format
            begin
                opcode <= instruction[31:29];
                rs <= instruction[28:24];
                rt <= 5'bx;
                label[31:20] <= 12'b0;
                label[19:0] <= instruction[23:4];
                func_code <= instruction[3:0];
            end
            default:
            begin
                opcode <= 3'bx;
                rs <= 5'bx;
                rt <= 5'bx;
                func_code <= 4'bx;
            end
        endcase
    end
endmodule