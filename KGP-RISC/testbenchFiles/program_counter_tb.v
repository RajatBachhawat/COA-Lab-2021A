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
module program_counter_tb;

reg clk;
reg reset;
reg [31:0] PC;
wire [31:0] PCN;

program_counter uut(
    .clk(clk),
    .reset(reset),
    .PC(PC),
    .PCN(PCN)
);
initial begin
    #100
    clk = 1;
    reset  = 1;
    #10 $monitor("clk = %b, reset = %b, PC = %b, PCN = %b",clk,reset,PC,PCN);
    #10 reset = 0;  PC = 5;
    #10 reset = 0;  PC  = 10;
    #10 reset = 1; PC = 6;
    #10
    $finish;
end
always #5 clk = ~clk;
endmodule