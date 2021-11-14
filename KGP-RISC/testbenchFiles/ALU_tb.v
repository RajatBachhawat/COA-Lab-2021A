`timescale 1ns / 1ps

// ALU testbench


module ALU_tb;

	// Inputs
	reg [31:0] inp1;
	reg [31:0] inp2;
	reg [3:0] operation;
	reg clk, reset;

	// Outputs
	wire [31:0] out;
	wire carryFlag;
	wire zeroFlag;
	wire signFlag;
	wire c32;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.inp1(inp1), 
		.inp2(inp2), 
		.operation(operation), 
		.clk(clk),
		.reset(reset),
		.out(out), 
		.carryFlag(carryFlag), 
		.zeroFlag(zeroFlag), 
		.signFlag(signFlag),
		.c32(c32)
	);

	initial begin
		// Initialize Inputs
		inp1 = 0;
		inp2 = 0;
		clk = 1;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;

		reset = 0;

		// Add stimulus here
		inp1=-1;
		inp2=1;
		operation=4'b0000;  //add with carry
		
		#10
		inp1=32'd105;
		inp2=32'd110;
		operation=4'b0001;  //and
		
		#10
		inp1=32'd105;
		inp2=32'd110;
		operation=4'b0010;  // xor
		
		#10
		inp1=32'd105;
		operation=4'b0011;  // 2s complement
		
		#10
		inp1=32'd105;
		inp2=32'd1;
		operation=4'b0100;  // srll
		
		#10
		inp1=32'd105;
		inp2=32'd1;
		operation=4'b0101;  // right shift
		
		#10
		inp1=32'd105;
		inp2=32'd2;
		operation=4'b0110; // shra

        #10
		inp1=32'd42;
		inp2=32'd437;    // add
		operation=4'b0000;
		
		#10
		inp1=-105;
		operation=4'b0111;  // less than 0
		
		#10
		inp1=32'd105;
		operation=4'b1000;  // equal to 0

        #10
		inp1=32'd0;
		operation=4'b1000;  // equal to 0

		$finish;
	end
	always #5 clk = ~clk;
	always #10 $monitor($time,"ns -> clk = %b, inp1=%d inp2=%d, out=%d, carry=%d, c32=%d, zero=%d,sign=%d",clk,inp1,inp2,out,carryFlag,c32,zeroFlag,signFlag);
      
endmodule