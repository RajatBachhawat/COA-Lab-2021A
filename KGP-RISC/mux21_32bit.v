`timescale 1ns / 1ps

module mux21_32bit(
    input [31:0] in0,
    input [31:0] in1,
    input select,
    output reg [31:0] out
);

always @(*) begin
    if(select)
    begin
        out = in1;
    end 
    else 
    begin
        out = in0;
    end

end
endmodule