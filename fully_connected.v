/*------------------------------------------------------------------------
 *
 *  Copyright (c) 2021 by Bo Young Kang, All rights reserved.
 *
 *  File name  : fully_connected.v
 *  Written by : Kang, Bo Young
 *  Written on : Oct 13, 2021
 *  Version    : 21.2
 *  Design     : Fully Connected Layer for CNN
 *
 *------------------------------------------------------------------------*/

/*-------------------------------------------------------------------
 *  Module: fully_connected
 *------------------------------------------------------------------*/

 module fully_connected #(parameter INPUT_NUM = 48, OUTPUT_NUM = 10, DATA_BITS = 8) (
   input clk,
   input rst_n,
   input valid_in,
   input signed [11:0] data_in_1, data_in_2, data_in_3,
   output reg [11:0] data_out,
   output reg valid_out_fc
 );

 localparam INPUT_WIDTH = 16;
 localparam INPUT_NUM_DATA_BITS = 5;

 reg state;
 reg [INPUT_WIDTH - 1:0] buf_idx;
 reg [3:0] out_idx;
 reg signed [13:0] buffer [0:INPUT_NUM - 1];
 reg signed [3:0] weight [0:INPUT_NUM * OUTPUT_NUM - 1];
 reg signed [7:0] bias [0:OUTPUT_NUM - 1];
   
 reg signed [19:0] calc_out;
 wire signed [13:0] data1, data2, data3;
 wire signed [19:0] result;

wire signed [11:0] exp_bias;
assign exp_bias = (bias[out_idx][7] == 1) ? {4'b1111, bias[out_idx]} : {4'd0, bias[out_idx]};


 initial begin
   $readmemb("fc_weight_log2.txt", weight);
   $readmemh("fc_bias.txt", bias);
 end

 assign data1 = (data_in_1[11] == 1) ? {2'b11, data_in_1} : {2'b00, data_in_1};
 assign data2 = (data_in_2[11] == 1) ? {2'b11, data_in_2} : {2'b00, data_in_2};
 assign data3 = (data_in_3[11] == 1) ? {2'b11, data_in_3} : {2'b00, data_in_3};
 
 always @(posedge clk) begin
   if(~rst_n) begin
     valid_out_fc <= 0;
     buf_idx <= 0;
     out_idx <= 0;
     state <= 0;
   end

   if(valid_out_fc == 1) begin
     valid_out_fc <= 0;
   end

   if(valid_in == 1) begin
     // Wait until 48 input data filled in buffer
     if(!state) begin
       buffer[buf_idx] <= data1;
       buffer[INPUT_WIDTH + buf_idx] <= data2;
       buffer[INPUT_WIDTH * 2 + buf_idx] <= data3;
       buf_idx <= buf_idx + 1'b1;
       if(buf_idx == INPUT_WIDTH - 1) begin
         buf_idx <= 0;
         state <= 1;
         valid_out_fc <= 1;
       end
     end else begin // valid state
       out_idx <= out_idx + 1'b1;
       if(out_idx == OUTPUT_NUM - 1) begin
         out_idx <= 0;
       end
       valid_out_fc <= 1;
     end
   end
 end

always @(*) begin                                                                                                                                                                            
	calc_out = 0;                                                                                                                                                                                                                                                                                                                                                                      
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM][3]) ? -(buffer[0] <<< weight[out_idx * INPUT_NUM][2:0]) : (buffer[0]<<<weight[out_idx * INPUT_NUM][2:0]));            
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+1] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+1][3]) ? -(buffer[1] <<< weight[out_idx * INPUT_NUM+1][2:0]) : (buffer[1]<<<weight[out_idx * INPUT_NUM+1][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+2] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+2][3]) ? -(buffer[2] <<< weight[out_idx * INPUT_NUM+2][2:0]) : (buffer[2]<<<weight[out_idx * INPUT_NUM+2][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+3] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+3][3]) ? -(buffer[3] <<< weight[out_idx * INPUT_NUM+3][2:0]) : (buffer[3]<<<weight[out_idx * INPUT_NUM+3][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+4] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+4][3]) ? -(buffer[4] <<< weight[out_idx * INPUT_NUM+4][2:0]) : (buffer[4]<<<weight[out_idx * INPUT_NUM+4][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+5] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+5][3]) ? -(buffer[5] <<< weight[out_idx * INPUT_NUM+5][2:0]) : (buffer[5]<<<weight[out_idx * INPUT_NUM+5][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+6] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+6][3]) ? -(buffer[6] <<< weight[out_idx * INPUT_NUM+6][2:0]) : (buffer[6]<<<weight[out_idx * INPUT_NUM+6][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+7] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+7][3]) ? -(buffer[7] <<< weight[out_idx * INPUT_NUM+7][2:0]) : (buffer[7]<<<weight[out_idx * INPUT_NUM+7][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+8] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+8][3]) ? -(buffer[8] <<< weight[out_idx * INPUT_NUM+8][2:0]) : (buffer[8]<<<weight[out_idx * INPUT_NUM+8][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+9] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+9][3]) ? -(buffer[9] <<< weight[out_idx * INPUT_NUM+9][2:0]) : (buffer[9]<<<weight[out_idx * INPUT_NUM+9][2:0]));          
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+10] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+10][3]) ? -(buffer[10] <<< weight[out_idx * INPUT_NUM+10][2:0]) : (buffer[10]<<<weight[out_idx * INPUT_NUM+10][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+11] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+11][3]) ? -(buffer[11] <<< weight[out_idx * INPUT_NUM+11][2:0]) : (buffer[11]<<<weight[out_idx * INPUT_NUM+11][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+12] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+12][3]) ? -(buffer[12] <<< weight[out_idx * INPUT_NUM+12][2:0]) : (buffer[12]<<<weight[out_idx * INPUT_NUM+12][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+13] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+13][3]) ? -(buffer[13] <<< weight[out_idx * INPUT_NUM+13][2:0]) : (buffer[13]<<<weight[out_idx * INPUT_NUM+13][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+14] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+14][3]) ? -(buffer[14] <<< weight[out_idx * INPUT_NUM+14][2:0]) : (buffer[14]<<<weight[out_idx * INPUT_NUM+14][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+15] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+15][3]) ? -(buffer[15] <<< weight[out_idx * INPUT_NUM+15][2:0]) : (buffer[15]<<<weight[out_idx * INPUT_NUM+15][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+16] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+16][3]) ? -(buffer[16] <<< weight[out_idx * INPUT_NUM+16][2:0]) : (buffer[16]<<<weight[out_idx * INPUT_NUM+16][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+17] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+17][3]) ? -(buffer[17] <<< weight[out_idx * INPUT_NUM+17][2:0]) : (buffer[17]<<<weight[out_idx * INPUT_NUM+17][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+18] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+18][3]) ? -(buffer[18] <<< weight[out_idx * INPUT_NUM+18][2:0]) : (buffer[18]<<<weight[out_idx * INPUT_NUM+18][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+19] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+19][3]) ? -(buffer[19] <<< weight[out_idx * INPUT_NUM+19][2:0]) : (buffer[19]<<<weight[out_idx * INPUT_NUM+19][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+20] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+20][3]) ? -(buffer[20] <<< weight[out_idx * INPUT_NUM+20][2:0]) : (buffer[20]<<<weight[out_idx * INPUT_NUM+20][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+21] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+21][3]) ? -(buffer[21] <<< weight[out_idx * INPUT_NUM+21][2:0]) : (buffer[21]<<<weight[out_idx * INPUT_NUM+21][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+22] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+22][3]) ? -(buffer[22] <<< weight[out_idx * INPUT_NUM+22][2:0]) : (buffer[22]<<<weight[out_idx * INPUT_NUM+22][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+23] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+23][3]) ? -(buffer[23] <<< weight[out_idx * INPUT_NUM+23][2:0]) : (buffer[23]<<<weight[out_idx * INPUT_NUM+23][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+24] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+24][3]) ? -(buffer[24] <<< weight[out_idx * INPUT_NUM+24][2:0]) : (buffer[24]<<<weight[out_idx * INPUT_NUM+24][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+25] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+25][3]) ? -(buffer[25] <<< weight[out_idx * INPUT_NUM+25][2:0]) : (buffer[25]<<<weight[out_idx * INPUT_NUM+25][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+26] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+26][3]) ? -(buffer[26] <<< weight[out_idx * INPUT_NUM+26][2:0]) : (buffer[26]<<<weight[out_idx * INPUT_NUM+26][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+27] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+27][3]) ? -(buffer[27] <<< weight[out_idx * INPUT_NUM+27][2:0]) : (buffer[27]<<<weight[out_idx * INPUT_NUM+27][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+28] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+28][3]) ? -(buffer[28] <<< weight[out_idx * INPUT_NUM+28][2:0]) : (buffer[28]<<<weight[out_idx * INPUT_NUM+28][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+29] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+29][3]) ? -(buffer[29] <<< weight[out_idx * INPUT_NUM+29][2:0]) : (buffer[29]<<<weight[out_idx * INPUT_NUM+29][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+30] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+30][3]) ? -(buffer[30] <<< weight[out_idx * INPUT_NUM+30][2:0]) : (buffer[30]<<<weight[out_idx * INPUT_NUM+30][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+31] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+31][3]) ? -(buffer[31] <<< weight[out_idx * INPUT_NUM+31][2:0]) : (buffer[31]<<<weight[out_idx * INPUT_NUM+31][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+32] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+32][3]) ? -(buffer[32] <<< weight[out_idx * INPUT_NUM+32][2:0]) : (buffer[32]<<<weight[out_idx * INPUT_NUM+32][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+33] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+33][3]) ? -(buffer[33] <<< weight[out_idx * INPUT_NUM+33][2:0]) : (buffer[33]<<<weight[out_idx * INPUT_NUM+33][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+34] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+34][3]) ? -(buffer[34] <<< weight[out_idx * INPUT_NUM+34][2:0]) : (buffer[34]<<<weight[out_idx * INPUT_NUM+34][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+35] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+35][3]) ? -(buffer[35] <<< weight[out_idx * INPUT_NUM+35][2:0]) : (buffer[35]<<<weight[out_idx * INPUT_NUM+35][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+36] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+36][3]) ? -(buffer[36] <<< weight[out_idx * INPUT_NUM+36][2:0]) : (buffer[36]<<<weight[out_idx * INPUT_NUM+36][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+37] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+37][3]) ? -(buffer[37] <<< weight[out_idx * INPUT_NUM+37][2:0]) : (buffer[37]<<<weight[out_idx * INPUT_NUM+37][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+38] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+38][3]) ? -(buffer[38] <<< weight[out_idx * INPUT_NUM+38][2:0]) : (buffer[38]<<<weight[out_idx * INPUT_NUM+38][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+39] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+39][3]) ? -(buffer[39] <<< weight[out_idx * INPUT_NUM+39][2:0]) : (buffer[39]<<<weight[out_idx * INPUT_NUM+39][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+40] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+40][3]) ? -(buffer[40] <<< weight[out_idx * INPUT_NUM+40][2:0]) : (buffer[40]<<<weight[out_idx * INPUT_NUM+40][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+41] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+41][3]) ? -(buffer[41] <<< weight[out_idx * INPUT_NUM+41][2:0]) : (buffer[41]<<<weight[out_idx * INPUT_NUM+41][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+42] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+42][3]) ? -(buffer[42] <<< weight[out_idx * INPUT_NUM+42][2:0]) : (buffer[42]<<<weight[out_idx * INPUT_NUM+42][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+43] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+43][3]) ? -(buffer[43] <<< weight[out_idx * INPUT_NUM+43][2:0]) : (buffer[43]<<<weight[out_idx * INPUT_NUM+43][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+44] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+44][3]) ? -(buffer[44] <<< weight[out_idx * INPUT_NUM+44][2:0]) : (buffer[44]<<<weight[out_idx * INPUT_NUM+44][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+45] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+45][3]) ? -(buffer[45] <<< weight[out_idx * INPUT_NUM+45][2:0]) : (buffer[45]<<<weight[out_idx * INPUT_NUM+45][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+46] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+46][3]) ? -(buffer[46] <<< weight[out_idx * INPUT_NUM+46][2:0]) : (buffer[46]<<<weight[out_idx * INPUT_NUM+46][2:0]));     
    calc_out = calc_out + ((weight[out_idx * INPUT_NUM+47] == 4'b1111) ? 0 : (weight[out_idx * INPUT_NUM+47][3]) ? -(buffer[47] <<< weight[out_idx * INPUT_NUM+47][2:0]) : (buffer[47]<<<weight[out_idx * INPUT_NUM+47][2:0]));     
end
	assign result= calc_out;	
		
 always @(*)
     data_out <= result[18:7]+ exp_bias ;   
	 
	 
	  endmodule
	  
	  
   
 