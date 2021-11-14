`timescale 1ns / 1ps



module registerfile_tb;

	// Inputs
	reg reset;
	reg clk;
	reg reg_write;
	reg [4:0] wrAddr;
	reg [31:0] wrData;
	reg [4:0] rdAddrA;
	reg [4:0] rdAddrB;

	// Outputs
	wire [31:0] rdDataA;
	wire [31:0] rdDataB;

	// Instantiate the Unit Under Test (UUT)
	registerfile uut (
		.reset(reset),
		.clk(clk), 
		.reg_write(reg_write), 
		.wrAddr(wrAddr), 
		.wrData(wrData), 
		.rdAddrA(rdAddrA), 
		.rdDataA(rdDataA), 
		.rdAddrB(rdAddrB), 
		.rdDataB(rdDataB)
	);

	initial begin
	
		reset=1;
		clk = 1;
		reg_write = 0;
		wrAddr = 0;
		wrData = 0;
		rdAddrA = 0;
		rdAddrB = 0;
        
		#20
		reset=0;
		reg_write=1;
		wrAddr=5'd10;
		wrData=32'b10111;
		
		#20
		reg_write=1;
		wrAddr=5'd15;
		wrData=32'b00111;
		
		#20
		reg_write=0;
		rdAddrA=5'd15;
		rdAddrB=5'd10;
		$finish;

	end
    always #10 clk=!clk;	 
	always #20 $monitor($time,"ns -> reg_write=%d read Address A=%d, read Address B=%d, read Data A=%d,read Data B=%d, write Data = %d, write Address = %d",reg_write,rdAddrA,rdAddrB,rdDataA,rdDataB,wrData, wrAddr);
endmodule