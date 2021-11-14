`timescale 1ns / 1ps

module instruction_fetch(
    input [31:0] PC,
    input clk,
	 input reset,
    output [31:0] instruction
    );

	wire [9:0] rom_address;
	assign rom_address = PC[9:0];
	instruction_memory IM (.clka(clk), .rsta(reset), .addra(rom_address), .douta(instruction));

endmodule