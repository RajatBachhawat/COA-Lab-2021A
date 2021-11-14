`timescale 1ns / 1ps

module data_memory_module(
	input clk,
	input reset,
	input mem_write,
	input mem_read,
	input [9:0] address,
	input [31:0] input_data,
	output [31:0] output_data
	);

	wire ram_Control;
	
	assign ram_Control = (mem_write & (~mem_read));
	data_memory DM (.clka(~clk), .rsta(reset), .wea(ram_Control), .addra(address), .dina(input_data), .douta(output_data));
endmodule