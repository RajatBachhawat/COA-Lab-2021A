/*
 * Assignment     : 6
 * Problem No.    : 1
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module barrelshifter_tb;
    reg [7:0] in;
    reg [2:0] shamt;
    reg dir;
    reg clk;
    wire [7:0] out;
    
    barrelshifter bbs(
        .in(in),
        .shamt(shamt),
        .dir(dir),
        .out(out)
    ); // module instantiation

    initial begin
        $dumpfile("barrelshifter_tb.vcd");
      	$dumpvars(0,barrelshifter_tb);
        clk = 1'b1;
        #2
        $display("First Example (Left Shift):");
        // 1 << 7 (left shift)
        in = 8'b00000001;
        shamt = 7;
        dir = 1'b1;
        #2
        $display("Second Example (Right Shift):");
        // 13 >> 2 (right shift)
        in = 8'b00001101;
        shamt = 2;
        dir = 1'b0;
        $finish; // Stop here ( 2 clock cycles are over )
    end
    always #2 $monitor($time, "ns -> input = %b, shamt = %d, dir = %b, output = %b", in, shamt, dir, out);
    always #1 clk = ~clk;
endmodule