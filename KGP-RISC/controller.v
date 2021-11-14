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

module controller(
    input [2:0] opcode,
    input [3:0] func_code,
    input reset,
    output reg reg_dst,
    output reg mem_read,
    output reg mem_to_reg,
    output reg mem_write,
    output reg is_branch,
    output reg [3:0] operation,
    output reg ALU_src,
    output reg reg_write
    );

    always@(*) begin
		if(reset) begin // reset all flags to zero
            reg_dst = 0;
            mem_read = 0;
            mem_to_reg = 0;
            mem_write = 0;
            is_branch = 0;
            operation = 4'b0;
            ALU_src = 0;
            reg_write = 0;
		end
		else begin
            case({opcode,func_code})
                7'b0000000: begin // R-Format - add
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0000; // addition operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0000001: begin // R-Format - comp
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0011; // complement operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0000010: begin // R-Format - and
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0001; // bitwise and operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0000011: begin // R-Format - xor
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0010; // bitwise xor operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0000100: begin // R-Format - shll
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0100; // left shift operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0000101: begin // R-Format - shrl
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0101; // right shift operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0000110: begin // R-Format - shllv
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0100; // left shift operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0000111: begin // R-Format - shrlv
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0101; // right shift operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0001000: begin // R-Format - shra
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0110; // right shift operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0001001: begin // R-Format - shrav
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0110; // arithmetic right shift operation
                    ALU_src = 0;
                    reg_write = 1;
                end

                7'b0010000: begin // I-Format - addi
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0000; // add operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0010001: begin // I-Format - compi
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0011; // comp operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0100000: begin // Load/Store Format - load
                    reg_dst = 0;
                    mem_read = 1;
                    mem_to_reg = 1;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0000; // add operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0100001: begin // Load/Store Format - store
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 1;
                    is_branch = 0;
                    operation = 4'b0000; // add operation
                    ALU_src = 1;
                    reg_write = 0;
                end

                7'b0110000: begin // B1 Format - b
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'bx;
                    ALU_src = 1'bx;
                    reg_write = 1'b0;
                end

                7'b0110001: begin // B1 Format - bl
                    reg_dst = 1'b0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b0000; // arithmetic right shift operation
                    ALU_src = 1;
                    reg_write = 1;
                end

                7'b0110010: begin // B1 Format - bcy
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'bx;
                    ALU_src = 1'bx;
                    reg_write = 1'b0;
                end

                7'b0110011: begin // B1 Format - bncy
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'bx;
                    ALU_src = 1'bx;
                    reg_write = 1'b0;

                end

                7'b1000000: begin // B2 Format - br
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'bx;
                    ALU_src = 1'bx;
                    reg_write = 1'b0;
                end

                7'b1010000: begin // B3 Format - bltz
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b0111; // check if less than zero
                    ALU_src = 0;
                    reg_write = 0;
                end

                7'b1010001: begin // B3 Format - bz
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b1000; // check if zero
                    ALU_src = 0;
                    reg_write = 0;
                end

                7'b1010010: begin // B3 Format - bnz
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b1000; // check if zero
                    ALU_src = 0;
                    reg_write = 0;
                end
					 default: begin
						  reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 0;
                    ALU_src = 0;
                    reg_write = 0;
					 end
            endcase
        end
    end

endmodule