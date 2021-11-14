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

module branch_logic(
    input is_branch,
    input carryFlag,
    input zeroFlag,
    input signFlag,
    input [31:0] address,
    input [31:0] label,
    input [31:0] PC,
    input [2:0] opcode,
    input [3:0] func_code,
    output reg [31:0] PCN
);

always @(*) begin
    if(is_branch) begin
        if(opcode == 3'b011 && func_code == 4'b0000) begin          // b L
            PCN = label;
        end
        else if(opcode==3'b011 && func_code == 4'b0001) begin       // bl L
            PCN = label;
        end

        else if(opcode==3'b011 && func_code == 4'b0010) begin       // bcy L
            if(carryFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end

        else if(opcode==3'b011 && func_code == 4'b0011) begin       // bncy L
            if(!carryFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end

        else if(opcode==3'b100 && func_code == 4'b0000) begin       // br rs
            PCN = address;
        end

        else if(opcode==3'b101 && func_code == 4'b0000) begin       // bltz rs, L
            if(signFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end
        
        else if(opcode==3'b101 && func_code == 4'b0001) begin       // bz rs, L
            if(zeroFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end

        else if(opcode==3'b101 && func_code == 4'b0010) begin       // bnz rs, L
            if(!zeroFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end
        
        else begin                                                  // Normal Flow
            PCN = PC+1;
        end  
    end
    else begin
        PCN = PC+1;
    end
end
endmodule 


