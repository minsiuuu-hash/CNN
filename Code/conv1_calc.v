/*------------------------------------------------------------------------
 *
 *  Copyright (c) 2021 by Bo Young Kang, All rights reserved.
 *
 *  File name  : conv1_calc.v
 *  Written by : Kang, Bo Young
 *  Written on : Oct 1, 2021
 *  Version    : 21.2
 *  Design     : 1st Convolution Layer for CNN MNIST dataset
 *               Convolution Sum Calculation
 *
 *------------------------------------------------------------------------*/

/*-------------------------------------------------------------------
 *  Module: conv1_calc
 *------------------------------------------------------------------*/
 
 module conv1_calc #(parameter DATA_BITS = 8)(
    input valid_out_buf,
    input [DATA_BITS - 1:0] data_out_0, data_out_1, data_out_2, data_out_3, data_out_4,
    data_out_5, data_out_6, data_out_7, data_out_8, data_out_9,
    data_out_10, data_out_11, data_out_12, data_out_13, data_out_14,
    data_out_15, data_out_16, data_out_17, data_out_18, data_out_19,
    data_out_20, data_out_21, data_out_22, data_out_23, data_out_24,
    output signed [11:0] conv_out_1, conv_out_2, conv_out_3,
    output reg valid_out_calc
);

    reg signed [3:0] weight_1 [0:24];
    reg signed [3:0] weight_2 [0:24];
    reg signed [3:0] weight_3 [0:24];
    reg signed [7:0] bias [0:2];

    wire signed [19:0] result_1, result_2, result_3;
    wire signed [15:0] exp_data [0:24];
    wire signed [11:0] exp_bias [0:2];

    // Read weight and bias from file
    initial begin
        $readmemb("conv1_w1.txt", weight_1);
        $readmemb("conv1_w2.txt", weight_2);
        $readmemb("conv1_w3.txt", weight_3);
        $readmemh("conv1_bias.txt", bias);
    end

    // unsigned 8bit data -> signed 16bit
    assign exp_data[0] = {8'd0, data_out_0};
 assign exp_data[1] = {8'd0, data_out_1};
 assign exp_data[2] = {8'd0, data_out_2};
 assign exp_data[3] = {8'd0, data_out_3};
 assign exp_data[4] = {8'd0, data_out_4};
 assign exp_data[5] = {8'd0, data_out_5};
 assign exp_data[6] = {8'd0, data_out_6};
 assign exp_data[7] = {8'd0, data_out_7};
 assign exp_data[8] = {8'd0, data_out_8};
 assign exp_data[9] = {8'd0, data_out_9};
 assign exp_data[10] = {8'd0, data_out_10};
 assign exp_data[11] = {8'd0, data_out_11};
 assign exp_data[12] = {8'd0, data_out_12};
 assign exp_data[13] = {8'd0, data_out_13};
 assign exp_data[14] = {8'd0, data_out_14};
 assign exp_data[15] = {8'd0, data_out_15};
 assign exp_data[16] = {8'd0, data_out_16};
 assign exp_data[17] = {8'd0, data_out_17};
 assign exp_data[18] = {8'd0, data_out_18};
 assign exp_data[19] = {8'd0, data_out_19};
 assign exp_data[20] = {8'd0, data_out_20};
 assign exp_data[21] = {8'd0, data_out_21};
 assign exp_data[22] = {8'd0, data_out_22};
 assign exp_data[23] = {8'd0, data_out_23};
 assign exp_data[24] = {8'd0, data_out_24};


    // bias sign
    assign exp_bias[0] = (bias[0][7] == 1) ? {4'b1111, bias[0]} : {4'd0, bias[0]};
    assign exp_bias[1] = (bias[1][7] == 1) ? {4'b1111, bias[1]} : {4'd0, bias[1]};
    assign exp_bias[2] = (bias[2][7] == 1) ? {4'b1111, bias[2]} : {4'd0, bias[2]};

    // LOG shift MAC
    log2_conv_1 mac1 (
    .exp_data_0 (exp_data[0]),  .exp_data_1 (exp_data[1]),  .exp_data_2 (exp_data[2]),
    .exp_data_3 (exp_data[3]),  .exp_data_4 (exp_data[4]),  .exp_data_5 (exp_data[5]),
    .exp_data_6 (exp_data[6]),  .exp_data_7 (exp_data[7]),  .exp_data_8 (exp_data[8]),
    .exp_data_9 (exp_data[9]),  .exp_data_10(exp_data[10]), .exp_data_11(exp_data[11]),
    .exp_data_12(exp_data[12]), .exp_data_13(exp_data[13]), .exp_data_14(exp_data[14]),
    .exp_data_15(exp_data[15]), .exp_data_16(exp_data[16]), .exp_data_17(exp_data[17]),
    .exp_data_18(exp_data[18]), .exp_data_19(exp_data[19]), .exp_data_20(exp_data[20]),
    .exp_data_21(exp_data[21]), .exp_data_22(exp_data[22]), .exp_data_23(exp_data[23]),
    .exp_data_24(exp_data[24]),

    .weight_0 (weight_1[0]),  .weight_1 (weight_1[1]),  .weight_2 (weight_1[2]),
    .weight_3 (weight_1[3]),  .weight_4 (weight_1[4]),  .weight_5 (weight_1[5]),
    .weight_6 (weight_1[6]),  .weight_7 (weight_1[7]),  .weight_8 (weight_1[8]),
    .weight_9 (weight_1[9]),  .weight_10(weight_1[10]), .weight_11(weight_1[11]),
    .weight_12(weight_1[12]), .weight_13(weight_1[13]), .weight_14(weight_1[14]),
    .weight_15(weight_1[15]), .weight_16(weight_1[16]), .weight_17(weight_1[17]),
    .weight_18(weight_1[18]), .weight_19(weight_1[19]), .weight_20(weight_1[20]),
    .weight_21(weight_1[21]), .weight_22(weight_1[22]), .weight_23(weight_1[23]),
    .weight_24(weight_1[24]),

    .result(result_1)
);
log2_conv_1 mac2 (
    .exp_data_0 (exp_data[0]),  .exp_data_1 (exp_data[1]),  .exp_data_2 (exp_data[2]),
    .exp_data_3 (exp_data[3]),  .exp_data_4 (exp_data[4]),  .exp_data_5 (exp_data[5]),
    .exp_data_6 (exp_data[6]),  .exp_data_7 (exp_data[7]),  .exp_data_8 (exp_data[8]),
    .exp_data_9 (exp_data[9]),  .exp_data_10(exp_data[10]), .exp_data_11(exp_data[11]),
    .exp_data_12(exp_data[12]), .exp_data_13(exp_data[13]), .exp_data_14(exp_data[14]),
    .exp_data_15(exp_data[15]), .exp_data_16(exp_data[16]), .exp_data_17(exp_data[17]),
    .exp_data_18(exp_data[18]), .exp_data_19(exp_data[19]), .exp_data_20(exp_data[20]),
    .exp_data_21(exp_data[21]), .exp_data_22(exp_data[22]), .exp_data_23(exp_data[23]),
    .exp_data_24(exp_data[24]),

    .weight_0 (weight_2[0]),  .weight_1 (weight_2[1]),  .weight_2 (weight_2[2]),
    .weight_3 (weight_2[3]),  .weight_4 (weight_2[4]),  .weight_5 (weight_2[5]),
    .weight_6 (weight_2[6]),  .weight_7 (weight_2[7]),  .weight_8 (weight_2[8]),
    .weight_9 (weight_2[9]),  .weight_10(weight_2[10]), .weight_11(weight_2[11]),
    .weight_12(weight_2[12]), .weight_13(weight_2[13]), .weight_14(weight_2[14]),
    .weight_15(weight_2[15]), .weight_16(weight_2[16]), .weight_17(weight_2[17]),
    .weight_18(weight_2[18]), .weight_19(weight_2[19]), .weight_20(weight_2[20]),
    .weight_21(weight_2[21]), .weight_22(weight_2[22]), .weight_23(weight_2[23]),
    .weight_24(weight_2[24]),

    .result(result_2)
);
log2_conv_1 mac3 (
    .exp_data_0 (exp_data[0]),  .exp_data_1 (exp_data[1]),  .exp_data_2 (exp_data[2]),
    .exp_data_3 (exp_data[3]),  .exp_data_4 (exp_data[4]),  .exp_data_5 (exp_data[5]),
    .exp_data_6 (exp_data[6]),  .exp_data_7 (exp_data[7]),  .exp_data_8 (exp_data[8]),
    .exp_data_9 (exp_data[9]),  .exp_data_10(exp_data[10]), .exp_data_11(exp_data[11]),
    .exp_data_12(exp_data[12]), .exp_data_13(exp_data[13]), .exp_data_14(exp_data[14]),
    .exp_data_15(exp_data[15]), .exp_data_16(exp_data[16]), .exp_data_17(exp_data[17]),
    .exp_data_18(exp_data[18]), .exp_data_19(exp_data[19]), .exp_data_20(exp_data[20]),
    .exp_data_21(exp_data[21]), .exp_data_22(exp_data[22]), .exp_data_23(exp_data[23]),
    .exp_data_24(exp_data[24]),

    .weight_0 (weight_3[0]),  .weight_1 (weight_3[1]),  .weight_2 (weight_3[2]),
    .weight_3 (weight_3[3]),  .weight_4 (weight_3[4]),  .weight_5 (weight_3[5]),
    .weight_6 (weight_3[6]),  .weight_7 (weight_3[7]),  .weight_8 (weight_3[8]),
    .weight_9 (weight_3[9]),  .weight_10(weight_3[10]), .weight_11(weight_3[11]),
    .weight_12(weight_3[12]), .weight_13(weight_3[13]), .weight_14(weight_3[14]),
    .weight_15(weight_3[15]), .weight_16(weight_3[16]), .weight_17(weight_3[17]),
    .weight_18(weight_3[18]), .weight_19(weight_3[19]), .weight_20(weight_3[20]),
    .weight_21(weight_3[21]), .weight_22(weight_3[22]), .weight_23(weight_3[23]),
    .weight_24(weight_3[24]),

    .result(result_3)
);


    assign conv_out_1 = result_1[19:8] + exp_bias[0];
    assign conv_out_2 = result_2[19:8] + exp_bias[1];
    assign conv_out_3 = result_3[19:8] + exp_bias[2];

    always @(*) begin
        valid_out_calc = valid_out_buf;
    end

endmodule


