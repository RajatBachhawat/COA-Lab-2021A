/*
 * Assignment     : 6
 * Problem No.    : 3
 * Semester       : Autumn 2021 
 * Group          : 46
 * Name1          : Neha Dalmia
 * RollNumber1    : 19CS30055
 * Name2          : Rajat Bachhawat
 * RollNumber2    : 19CS10073
 */

`timescale 1ns / 1ps

module seq_booth_multiplier(
    input [7:0] A, B,       // Input 8-bit Signed Integers
    input CLK, RST, LOAD,   // Control Signals
    output reg [15:0] prod  // Final 16-bit Product Register
    );
    reg [7:0] mCand;        // Multiplicand Register
    reg right_bit;          // the last bit (rightmost) that was spit out while shifting product
    always @(posedge CLK) begin
        if(LOAD) begin                                          // Synchronous Parallel Load
            right_bit = 1'b0;
            mCand = A;
            prod[15:8] = 8'b0;
            prod[7:0] = B;
        end
        else if(RST) begin                                      // Synchronous Reset
            right_bit = 1'b0;
            mCand = 8'b0;
            prod[15:8] = 8'b0;
            prod[7:0] = 8'b0;
        end
        else begin
            case({prod[0], right_bit})
                2'b00: begin
                    right_bit = prod[0];
                    prod = {prod[15],prod[15:1]};               // Arithmetic (sign-preserving) right shift
                end
                2'b01: begin
                    prod[15:8] = prod[15:8] + mCand;            // Add Multiplicand
                    right_bit = prod[0];
                    prod = {prod[15],prod[15:1]};               // Arithmetic (sign-preserving) right shift
                end
                2'b10: begin
                    prod[15:8] = prod[15:8] - mCand;            // Subtract Multiplicand
                    right_bit = prod[0];
                    prod = {prod[15],prod[15:1]};               // Arithmetic (sign-preserving) right shift
                end
                2'b11: begin
                    right_bit = prod[0];
                    prod = {prod[15],prod[15:1]};               // Arithmetic (sign-preserving) right shift
                end
            endcase
        end
    end
endmodule // seq_booth_multiplier