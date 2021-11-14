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
        if(opcode == 3'b011 && func_code == 4'b0000) begin
            PCN = label;
        end
        else if(opcode==3'b011 && func_code == 4'b0001) begin
            PCN = label;
        end

        else if(opcode==3'b011 && func_code == 4'b0010) begin
            if(carryFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end

        else if(opcode==3'b011 && func_code == 4'b0011) begin
            if(!carryFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end

        else if(opcode==3'b100 && func_code == 4'b0000) begin
            PCN = address;
        end

        else if(opcode==3'b101 && func_code == 4'b0000) begin
            if(signFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end
        
        else if(opcode==3'b101 && func_code == 4'b0001) begin
            if(zeroFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end

        else if(opcode==3'b101 && func_code == 4'b0010) begin
            if(!zeroFlag) begin
                PCN = label;
            end
            else begin 
                PCN = PC+1;
            end
        end
        
        else begin 
            PCN = PC+1;
        end  
    end
    else begin
        PCN = PC+1;
    end
end
endmodule 


