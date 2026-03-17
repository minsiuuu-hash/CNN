/*------------------------------------------------------------------------
 *
 *  Copyright (c) 2021 by Bo Young Kang, All rights reserved.
 *
 *  File name  : conv2_calc_1.v
 *  Written by : Kang, Bo Young
 *  Written on : Oct 14, 2021
 *  Version    : 21.2
 *  Design     : 2nd Convolution Layer for CNN MNIST dataset
 *               Convolution Sum Calculation - 1st Channel
 *
 *------------------------------------------------------------------------*/

/*-------------------------------------------------------------------
 *  Module: conv2_calc_1
 *------------------------------------------------------------------*/

 module conv2_calc_3(
	input clk,
  input rst_n,
  input valid_out_buf,
	input signed [11:0] data_out1_0, data_out1_1, data_out1_2, data_out1_3, data_out1_4,
	  data_out1_5, data_out1_6, data_out1_7, data_out1_8, data_out1_9,
	  data_out1_10, data_out1_11, data_out1_12, data_out1_13, data_out1_14,
	  data_out1_15, data_out1_16, data_out1_17, data_out1_18, data_out1_19,
	  data_out1_20, data_out1_21, data_out1_22, data_out1_23, data_out1_24,
	
	  data_out2_0, data_out2_1, data_out2_2, data_out2_3, data_out2_4,
	  data_out2_5, data_out2_6, data_out2_7, data_out2_8, data_out2_9,
	  data_out2_10, data_out2_11, data_out2_12, data_out2_13, data_out2_14,
	  data_out2_15, data_out2_16, data_out2_17, data_out2_18, data_out2_19,
	  data_out2_20, data_out2_21, data_out2_22, data_out2_23, data_out2_24,
	
	  data_out3_0, data_out3_1, data_out3_2, data_out3_3, data_out3_4,
	  data_out3_5, data_out3_6, data_out3_7, data_out3_8, data_out3_9,
	  data_out3_10, data_out3_11, data_out3_12, data_out3_13, data_out3_14,
	  data_out3_15, data_out3_16, data_out3_17, data_out3_18, data_out3_19,
	  data_out3_20, data_out3_21, data_out3_22, data_out3_23, data_out3_24,

	  output reg [13:0] conv_out_calc,
  	output reg valid_out_calc
);

wire signed [19:0] calc_out, result_1, result_2, result_3;

reg signed [3:0] weight_1 [0:24];
reg signed [3:0] weight_2 [0:24];
reg signed [3:0] weight_3 [0:24];

initial begin
	$readmemb("conv2_w31.txt", weight_1);
	$readmemb("conv2_w32.txt", weight_2);
	$readmemb("conv2_w33.txt", weight_3);

end

wire signed [18:0] exp_data1 [0:24];
wire signed [18:0] exp_data2 [0:24];
wire signed [18:0] exp_data3 [0:24];

 assign exp_data1[0] = {7'd0, data_out1_0};
 assign exp_data1[1] = {7'd0, data_out1_1};
 assign exp_data1[2] = {7'd0, data_out1_2};
 assign exp_data1[3] = {7'd0, data_out1_3};
 assign exp_data1[4] = {7'd0, data_out1_4};
 assign exp_data1[5] = {7'd0, data_out1_5};
 assign exp_data1[6] = {7'd0, data_out1_6};
 assign exp_data1[7] = {7'd0, data_out1_7};
 assign exp_data1[8] = {7'd0, data_out1_8};
 assign exp_data1[9] = {7'd0, data_out1_9};
 assign exp_data1[10] = {7'd0, data_out1_10};
 assign exp_data1[11] = {7'd0, data_out1_11};
 assign exp_data1[12] = {7'd0, data_out1_12};
 assign exp_data1[13] = {7'd0, data_out1_13};
 assign exp_data1[14] = {7'd0, data_out1_14};
 assign exp_data1[15] = {7'd0, data_out1_15};
 assign exp_data1[16] = {7'd0, data_out1_16};
 assign exp_data1[17] = {7'd0, data_out1_17};
 assign exp_data1[18] = {7'd0, data_out1_18};
 assign exp_data1[19] = {7'd0, data_out1_19};
 assign exp_data1[20] = {7'd0, data_out1_20};
 assign exp_data1[21] = {7'd0, data_out1_21};
 assign exp_data1[22] = {7'd0, data_out1_22};
 assign exp_data1[23] = {7'd0, data_out1_23};
 assign exp_data1[24] = {7'd0, data_out1_24};
 
 assign exp_data2[0] = {7'd0, data_out2_0};
 assign exp_data2[1] = {7'd0, data_out2_1};
 assign exp_data2[2] = {7'd0, data_out2_2};
 assign exp_data2[3] = {7'd0, data_out2_3};
 assign exp_data2[4] = {7'd0, data_out2_4};
 assign exp_data2[5] = {7'd0, data_out2_5};
 assign exp_data2[6] = {7'd0, data_out2_6};
 assign exp_data2[7] = {7'd0, data_out2_7};
 assign exp_data2[8] = {7'd0, data_out2_8};
 assign exp_data2[9] = {7'd0, data_out2_9};
 assign exp_data2[10] = {7'd0, data_out2_10};
 assign exp_data2[11] = {7'd0, data_out2_11};
 assign exp_data2[12] = {7'd0, data_out2_12};
 assign exp_data2[13] = {7'd0, data_out2_13};
 assign exp_data2[14] = {7'd0, data_out2_14};
 assign exp_data2[15] = {7'd0, data_out2_15};
 assign exp_data2[16] = {7'd0, data_out2_16};
 assign exp_data2[17] = {7'd0, data_out2_17};
 assign exp_data2[18] = {7'd0, data_out2_18};
 assign exp_data2[19] = {7'd0, data_out2_19};
 assign exp_data2[20] = {7'd0, data_out2_20};
 assign exp_data2[21] = {7'd0, data_out2_21};
 assign exp_data2[22] = {7'd0, data_out2_22};
 assign exp_data2[23] = {7'd0, data_out2_23};
 assign exp_data2[24] = {7'd0, data_out2_24};
 
 assign exp_data3[0] = {7'd0, data_out3_0};
assign exp_data3[1] = {7'd0, data_out3_1};
assign exp_data3[2] = {7'd0, data_out3_2};
assign exp_data3[3] = {7'd0, data_out3_3};
assign exp_data3[4] = {7'd0, data_out3_4};
assign exp_data3[5] = {7'd0, data_out3_5};
assign exp_data3[6] = {7'd0, data_out3_6};
assign exp_data3[7] = {7'd0, data_out3_7};
assign exp_data3[8] = {7'd0, data_out3_8};
assign exp_data3[9] = {7'd0, data_out3_9};
assign exp_data3[10] = {7'd0, data_out3_10};
assign exp_data3[11] = {7'd0, data_out3_11};
assign exp_data3[12] = {7'd0, data_out3_12};
assign exp_data3[13] = {7'd0, data_out3_13};
assign exp_data3[14] = {7'd0, data_out3_14};
assign exp_data3[15] = {7'd0, data_out3_15};
assign exp_data3[16] = {7'd0, data_out3_16};
assign exp_data3[17] = {7'd0, data_out3_17};
assign exp_data3[18] = {7'd0, data_out3_18};
assign exp_data3[19] = {7'd0, data_out3_19};
assign exp_data3[20] = {7'd0, data_out3_20};
assign exp_data3[21] = {7'd0, data_out3_21};
assign exp_data3[22] = {7'd0, data_out3_22};
assign exp_data3[23] = {7'd0, data_out3_23};
assign exp_data3[24] = {7'd0, data_out3_24};

 
log2_conv_2 mac31 (
    .exp_data_0 (exp_data1[0]),  .exp_data_1 (exp_data1[1]),  .exp_data_2 (exp_data1[2]),
    .exp_data_3 (exp_data1[3]),  .exp_data_4 (exp_data1[4]),  .exp_data_5 (exp_data1[5]),
    .exp_data_6 (exp_data1[6]),  .exp_data_7 (exp_data1[7]),  .exp_data_8 (exp_data1[8]),
    .exp_data_9 (exp_data1[9]),  .exp_data_10(exp_data1[10]), .exp_data_11(exp_data1[11]),
    .exp_data_12(exp_data1[12]), .exp_data_13(exp_data1[13]), .exp_data_14(exp_data1[14]),
    .exp_data_15(exp_data1[15]), .exp_data_16(exp_data1[16]), .exp_data_17(exp_data1[17]),
    .exp_data_18(exp_data1[18]), .exp_data_19(exp_data1[19]), .exp_data_20(exp_data1[20]),
    .exp_data_21(exp_data1[21]), .exp_data_22(exp_data1[22]), .exp_data_23(exp_data1[23]),
    .exp_data_24(exp_data1[24]),

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

log2_conv_2 mac32 (
    .exp_data_0 (exp_data2[0]),  .exp_data_1 (exp_data2[1]),  .exp_data_2 (exp_data2[2]),
    .exp_data_3 (exp_data2[3]),  .exp_data_4 (exp_data2[4]),  .exp_data_5 (exp_data2[5]),
    .exp_data_6 (exp_data2[6]),  .exp_data_7 (exp_data2[7]),  .exp_data_8 (exp_data2[8]),
    .exp_data_9 (exp_data2[9]),  .exp_data_10(exp_data2[10]), .exp_data_11(exp_data2[11]),
    .exp_data_12(exp_data2[12]), .exp_data_13(exp_data2[13]), .exp_data_14(exp_data2[14]),
    .exp_data_15(exp_data2[15]), .exp_data_16(exp_data2[16]), .exp_data_17(exp_data2[17]),
    .exp_data_18(exp_data2[18]), .exp_data_19(exp_data2[19]), .exp_data_20(exp_data2[20]),
    .exp_data_21(exp_data2[21]), .exp_data_22(exp_data2[22]), .exp_data_23(exp_data2[23]),
    .exp_data_24(exp_data2[24]),

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

log2_conv_2 mac33 (
    .exp_data_0 (exp_data3[0]),  .exp_data_1 (exp_data3[1]),  .exp_data_2 (exp_data3[2]),
    .exp_data_3 (exp_data3[3]),  .exp_data_4 (exp_data3[4]),  .exp_data_5 (exp_data3[5]),
    .exp_data_6 (exp_data3[6]),  .exp_data_7 (exp_data3[7]),  .exp_data_8 (exp_data3[8]),
    .exp_data_9 (exp_data3[9]),  .exp_data_10(exp_data3[10]), .exp_data_11(exp_data3[11]),
    .exp_data_12(exp_data3[12]), .exp_data_13(exp_data3[13]), .exp_data_14(exp_data3[14]),
    .exp_data_15(exp_data3[15]), .exp_data_16(exp_data3[16]), .exp_data_17(exp_data3[17]),
    .exp_data_18(exp_data3[18]), .exp_data_19(exp_data3[19]), .exp_data_20(exp_data3[20]),
    .exp_data_21(exp_data3[21]), .exp_data_22(exp_data3[22]), .exp_data_23(exp_data3[23]),
    .exp_data_24(exp_data3[24]),

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

assign calc_out = result_1 + result_2 + result_3;

always @(posedge clk) begin
    if (~rst_n) begin
        valid_out_calc <= 0;
        conv_out_calc <= 0;
    end else begin
        if (valid_out_buf) begin
            conv_out_calc <= calc_out[19:6];
            valid_out_calc <= ~valid_out_calc;
        end
    end
end


endmodule