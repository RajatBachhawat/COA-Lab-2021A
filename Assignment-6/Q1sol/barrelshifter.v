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

/*2-1 MUX*/
module mux21(
    input D0, D1, S,                    // inputs
    output reg Y                        // output
    );

    always @(*) begin
        if(S) begin
            Y <= D1;
        end
        else begin
            Y <= D0;
        end
    end

endmodule // mux21

/*8-bit Bi-directional Barrel Shifter*/
module barrelshifter (
    input [7:0] in,                     // 8-bit input
    input [2:0] shamt,                  // shift amount (3-bit unsigned integer)
    input dir,                          // dir = 1 for left shift, dir = 0 for right shift
    output [7:0] out                    // 8-bit output after shifting
    );

    wire mux_out[1:0][7:0];             // matrix of 2-1 MUX output wires
    wire _in[7:0], _out[7:0];           // input after passing through reversing MUXes
                                        // output after passing through reversing MUXes

    // One level of 2-1 MUXes to reverse the bits of the input if dir = 1
    mux21 m_flip_in_7(.D0(in[7]), .D1(in[0]), .S(dir), .Y(_in[7]));
    mux21 m_flip_in_6(.D0(in[6]), .D1(in[1]), .S(dir), .Y(_in[6]));
    mux21 m_flip_in_5(.D0(in[5]), .D1(in[2]), .S(dir), .Y(_in[5]));
    mux21 m_flip_in_4(.D0(in[4]), .D1(in[3]), .S(dir), .Y(_in[4]));
    mux21 m_flip_in_3(.D0(in[3]), .D1(in[4]), .S(dir), .Y(_in[3]));
    mux21 m_flip_in_2(.D0(in[2]), .D1(in[5]), .S(dir), .Y(_in[2]));
    mux21 m_flip_in_1(.D0(in[1]), .D1(in[6]), .S(dir), .Y(_in[1]));
    mux21 m_flip_in_0(.D0(in[0]), .D1(in[7]), .S(dir), .Y(_in[0]));

    // Level of MUXes controlled by shamt[2]
    // if shamt[2] = 0, output = input
    // else, output = input >> 4
    mux21 m_27(.D0(_in[7]), .D1(1'b0), .S(shamt[2]), .Y(mux_out[1][7]));
    mux21 m_26(.D0(_in[6]), .D1(1'b0), .S(shamt[2]), .Y(mux_out[1][6]));
    mux21 m_25(.D0(_in[5]), .D1(1'b0), .S(shamt[2]), .Y(mux_out[1][5]));
    mux21 m_24(.D0(_in[4]), .D1(1'b0), .S(shamt[2]), .Y(mux_out[1][4]));
    mux21 m_23(.D0(_in[3]), .D1(_in[7]), .S(shamt[2]), .Y(mux_out[1][3]));
    mux21 m_22(.D0(_in[2]), .D1(_in[6]), .S(shamt[2]), .Y(mux_out[1][2]));
    mux21 m_21(.D0(_in[1]), .D1(_in[5]), .S(shamt[2]), .Y(mux_out[1][1]));
    mux21 m_20(.D0(_in[0]), .D1(_in[4]), .S(shamt[2]), .Y(mux_out[1][0]));

    // Level of MUXes controlled by shamt[1]
    // if shamt[1] = 0, output = input
    // else, output = input >> 2
    mux21 m_17(.D0(mux_out[1][7]), .D1(1'b0), .S(shamt[1]), .Y(mux_out[0][7]));
    mux21 m_16(.D0(mux_out[1][6]), .D1(1'b0), .S(shamt[1]), .Y(mux_out[0][6]));
    mux21 m_15(.D0(mux_out[1][5]), .D1(mux_out[1][7]), .S(shamt[1]), .Y(mux_out[0][5]));
    mux21 m_14(.D0(mux_out[1][4]), .D1(mux_out[1][6]), .S(shamt[1]), .Y(mux_out[0][4]));
    mux21 m_13(.D0(mux_out[1][3]), .D1(mux_out[1][5]), .S(shamt[1]), .Y(mux_out[0][3]));
    mux21 m_12(.D0(mux_out[1][2]), .D1(mux_out[1][4]), .S(shamt[1]), .Y(mux_out[0][2]));
    mux21 m_11(.D0(mux_out[1][1]), .D1(mux_out[1][3]), .S(shamt[1]), .Y(mux_out[0][1]));
    mux21 m_10(.D0(mux_out[1][0]), .D1(mux_out[1][2]), .S(shamt[1]), .Y(mux_out[0][0]));

    // Level of MUXes controlled by shamt[0]
    // if shamt[0] = 0, output = input
    // else, output = input >> 1
    mux21 m_07(.D0(mux_out[0][7]), .D1(1'b0), .S(shamt[0]), .Y(_out[7]));
    mux21 m_06(.D0(mux_out[0][6]), .D1(mux_out[0][7]), .S(shamt[0]), .Y(_out[6]));
    mux21 m_05(.D0(mux_out[0][5]), .D1(mux_out[0][6]), .S(shamt[0]), .Y(_out[5]));
    mux21 m_04(.D0(mux_out[0][4]), .D1(mux_out[0][5]), .S(shamt[0]), .Y(_out[4]));
    mux21 m_03(.D0(mux_out[0][3]), .D1(mux_out[0][4]), .S(shamt[0]), .Y(_out[3]));
    mux21 m_02(.D0(mux_out[0][2]), .D1(mux_out[0][3]), .S(shamt[0]), .Y(_out[2]));
    mux21 m_01(.D0(mux_out[0][1]), .D1(mux_out[0][2]), .S(shamt[0]), .Y(_out[1]));
    mux21 m_00(.D0(mux_out[0][0]), .D1(mux_out[0][1]), .S(shamt[0]), .Y(_out[0]));

    // One level of 2-1 MUXes to reverse the bits of the output if dir = 1
    mux21 m_flip_out_7(.D0(_out[7]), .D1(_out[0]), .S(dir), .Y(out[7]));
    mux21 m_flip_out_6(.D0(_out[6]), .D1(_out[1]), .S(dir), .Y(out[6]));
    mux21 m_flip_out_5(.D0(_out[5]), .D1(_out[2]), .S(dir), .Y(out[5]));
    mux21 m_flip_out_4(.D0(_out[4]), .D1(_out[3]), .S(dir), .Y(out[4]));
    mux21 m_flip_out_3(.D0(_out[3]), .D1(_out[4]), .S(dir), .Y(out[3]));
    mux21 m_flip_out_2(.D0(_out[2]), .D1(_out[5]), .S(dir), .Y(out[2]));
    mux21 m_flip_out_1(.D0(_out[1]), .D1(_out[6]), .S(dir), .Y(out[1]));
    mux21 m_flip_out_0(.D0(_out[0]), .D1(_out[7]), .S(dir), .Y(out[0]));
endmodule // barrelshifter