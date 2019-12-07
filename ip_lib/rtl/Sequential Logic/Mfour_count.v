`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:08 10/15/2016 
// Design Name: 
// Module Name:    Mfour_count 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Mfour_count(clk_50M, rst_n, Q, clk_1
    );
	 input clk_50M, rst_n;//clk_50M����Ϊ50Mhz��ʱ���ź�
	 output reg clk_1 = 0;//��Ƶ��1hz��ʱ���ź�
	 output reg [1:0] Q;
	 
	 reg [25:0] cnt;
	 
	 parameter TIME = 26'd2;
	 
	 always @(posedge clk_50M or negedge rst_n)//��50Mhz��Ƶ��1hz
	 begin
		if(!rst_n)
		begin
			cnt <= 1'b0;
			clk_1 <= 1'b0;
		end
		else if(cnt == TIME - 1'b1)
		begin
			cnt <= 1'b0;
			clk_1 <= ~clk_1;
		end
		else
			cnt <= cnt + 1'b1;
	 end
		
	 wire [1:0] D;//����D������
	 assign D[1] = ~Q[1];
	 assign D[0] = Q[1]&~Q[0] | ~Q[1]&Q[0];
	 
	 always @(posedge clk_1 or negedge rst_n)
	 begin
		if(!rst_n)
			Q <= 0;
		else
			Q <= D;
	 end

endmodule
