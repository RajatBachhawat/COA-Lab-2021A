/*
 * Assignment     : 6
 * Problem No.    : 2cd  
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module bit_serial_adder_tb;
    reg [7:0] A, B;
    reg CLK, RST, select;
    wire [7:0] S;
    wire LSB_A, LSB_B;

    bit_serial_adder bsa(
        .A(A),
        .B(B),
        .CLK(CLK),
        .RST(RST),
        .select(select),
        .S(S),
        .LSB_A(LSB_A),
        .LSB_B(LSB_B)
    ); // module instantiation

    initial begin
        $dumpfile("bit_serial_adder_tb.vcd");
      	$dumpvars(0,bit_serial_adder_tb);
        CLK = 1'b1; // Start clock

        #2
        RST = 1'b1;
        select = 0; // Load the inputs A and B
        A = 8'b00100101; B = 8'b00100110;
        #2
        RST = 1'b0;
        select = 1; // Start addition

        #16 $finish; // Stop after 8 clock cycles more
    end

    always #1 CLK = ~CLK;
    always #2 $monitor($time, "ns -> A = %b (%d), B = %b (%d), LSB_A_next = %b, LSB_B_next = %b, S (Sum) = %b (%d)", A, A, B, B, LSB_A, LSB_B, S, S); 
endmodule