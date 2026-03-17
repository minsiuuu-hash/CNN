`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/09 03:39:06
// Design Name: 
// Module Name: log2_conv_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module log2_conv_2(
    input  signed [18:0] exp_data_0,  input signed [18:0] exp_data_1,  input signed [18:0] exp_data_2,
    input  signed [18:0] exp_data_3,  input signed [18:0] exp_data_4,  input signed [18:0] exp_data_5,
    input  signed [18:0] exp_data_6,  input signed [18:0] exp_data_7,  input signed [18:0] exp_data_8,
    input  signed [18:0] exp_data_9,  input signed [18:0] exp_data_10, input signed [18:0] exp_data_11,
    input  signed [18:0] exp_data_12, input signed [18:0] exp_data_13, input signed [18:0] exp_data_14,
    input  signed [18:0] exp_data_15, input signed [18:0] exp_data_16, input signed [18:0] exp_data_17,
    input  signed [18:0] exp_data_18, input signed [18:0] exp_data_19, input signed [18:0] exp_data_20,
    input  signed [18:0] exp_data_21, input signed [18:0] exp_data_22, input signed [18:0] exp_data_23,
    input  signed [18:0] exp_data_24,

    input  [3:0] weight_0,  input [3:0] weight_1,  input [3:0] weight_2,
    input  [3:0] weight_3,  input [3:0] weight_4,  input [3:0] weight_5,
    input  [3:0] weight_6,  input [3:0] weight_7,  input [3:0] weight_8,
    input  [3:0] weight_9,  input [3:0] weight_10, input [3:0] weight_11,
    input  [3:0] weight_12, input [3:0] weight_13, input [3:0] weight_14,
    input  [3:0] weight_15, input [3:0] weight_16, input [3:0] weight_17,
    input  [3:0] weight_18, input [3:0] weight_19, input [3:0] weight_20,
    input  [3:0] weight_21, input [3:0] weight_22, input [3:0] weight_23,
    input  [3:0] weight_24,

    output signed [19:0] result
);

    reg signed [19:0] acc;

    always @(*) begin
        acc = 0;

        acc = acc + ((weight_0 == 4'b1111) ? 0 : (weight_0[3] ? -(exp_data_0 <<< weight_0[2:0]) : (exp_data_0 <<< weight_0[2:0])));
        acc = acc + ((weight_1 == 4'b1111) ? 0 : (weight_1[3] ? -(exp_data_1 <<< weight_1[2:0]) : (exp_data_1 <<< weight_1[2:0])));
        acc = acc + ((weight_2 == 4'b1111) ? 0 : (weight_2[3] ? -(exp_data_2 <<< weight_2[2:0]) : (exp_data_2 <<< weight_2[2:0])));
        acc = acc + ((weight_3 == 4'b1111) ? 0 : (weight_3[3] ? -(exp_data_3 <<< weight_3[2:0]) : (exp_data_3 <<< weight_3[2:0])));
        acc = acc + ((weight_4 == 4'b1111) ? 0 : (weight_4[3] ? -(exp_data_4 <<< weight_4[2:0]) : (exp_data_4 <<< weight_4[2:0])));
        
        acc = acc + ((weight_5 == 4'b1111) ? 0 : (weight_5[3] ? -(exp_data_5 <<< weight_5[2:0]) : (exp_data_5 <<< weight_5[2:0])));
        acc = acc + ((weight_6 == 4'b1111) ? 0 : (weight_6[3] ? -(exp_data_6 <<< weight_6[2:0]) : (exp_data_6 <<< weight_6[2:0])));
        acc = acc + ((weight_7 == 4'b1111) ? 0 : (weight_7[3] ? -(exp_data_7 <<< weight_7[2:0]) : (exp_data_7 <<< weight_7[2:0])));
        acc = acc + ((weight_8 == 4'b1111) ? 0 : (weight_8[3] ? -(exp_data_8 <<< weight_8[2:0]) : (exp_data_8 <<< weight_8[2:0])));
        acc = acc + ((weight_9 == 4'b1111) ? 0 : (weight_9[3] ? -(exp_data_9 <<< weight_9[2:0]) : (exp_data_9 <<< weight_9[2:0])));
        
        acc = acc + ((weight_10 == 4'b1111) ? 0 : (weight_10[3] ? -(exp_data_10 <<< weight_10[2:0]) : (exp_data_10 <<< weight_10[2:0])));
        acc = acc + ((weight_11 == 4'b1111) ? 0 : (weight_11[3] ? -(exp_data_11 <<< weight_11[2:0]) : (exp_data_11 <<< weight_11[2:0])));
        acc = acc + ((weight_12 == 4'b1111) ? 0 : (weight_12[3] ? -(exp_data_12 <<< weight_12[2:0]) : (exp_data_12 <<< weight_12[2:0])));
        acc = acc + ((weight_13 == 4'b1111) ? 0 : (weight_13[3] ? -(exp_data_13 <<< weight_13[2:0]) : (exp_data_13 <<< weight_13[2:0])));
        acc = acc + ((weight_14 == 4'b1111) ? 0 : (weight_14[3] ? -(exp_data_14 <<< weight_14[2:0]) : (exp_data_14 <<< weight_14[2:0])));
        
        acc = acc + ((weight_15 == 4'b1111) ? 0 : (weight_15[3] ? -(exp_data_15 <<< weight_15[2:0]) : (exp_data_15 <<< weight_15[2:0])));
        acc = acc + ((weight_16 == 4'b1111) ? 0 : (weight_16[3] ? -(exp_data_16 <<< weight_16[2:0]) : (exp_data_16 <<< weight_16[2:0])));
        acc = acc + ((weight_17 == 4'b1111) ? 0 : (weight_17[3] ? -(exp_data_17 <<< weight_17[2:0]) : (exp_data_17 <<< weight_17[2:0])));
        acc = acc + ((weight_18 == 4'b1111) ? 0 : (weight_18[3] ? -(exp_data_18 <<< weight_18[2:0]) : (exp_data_18 <<< weight_18[2:0])));
        acc = acc + ((weight_19 == 4'b1111) ? 0 : (weight_19[3] ? -(exp_data_19 <<< weight_19[2:0]) : (exp_data_19 <<< weight_19[2:0])));

        acc = acc + ((weight_20 == 4'b1111) ? 0 : (weight_20[3] ? -(exp_data_20 <<< weight_20[2:0]) : (exp_data_20 <<< weight_20[2:0])));
        acc = acc + ((weight_21 == 4'b1111) ? 0 : (weight_21[3] ? -(exp_data_21 <<< weight_21[2:0]) : (exp_data_21 <<< weight_21[2:0])));
        acc = acc + ((weight_22 == 4'b1111) ? 0 : (weight_22[3] ? -(exp_data_22 <<< weight_22[2:0]) : (exp_data_22 <<< weight_22[2:0])));
        acc = acc + ((weight_23 == 4'b1111) ? 0 : (weight_23[3] ? -(exp_data_23 <<< weight_23[2:0]) : (exp_data_23 <<< weight_23[2:0])));
        acc = acc + ((weight_24 == 4'b1111) ? 0 : (weight_24[3] ? -(exp_data_24 <<< weight_24[2:0]) : (exp_data_24 <<< weight_24[2:0])));
    end

    assign result = acc;

endmodule
