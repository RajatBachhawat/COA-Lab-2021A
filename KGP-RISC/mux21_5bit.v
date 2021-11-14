`timescale 1ns / 1ps

module mux21_5bit(
    input [4:0] in0,
    input [4:0] in1,
    input select,
    output reg [4:0] out
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