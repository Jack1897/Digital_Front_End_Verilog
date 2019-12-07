`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:09 10/09/2016 
// Design Name: 
// Module Name:    counter 
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
module counter(clk, rst, out
    );
	 input clk, rst;
	 output reg [3:0] out;
	 
	 reg[25:0] cnt;//����һ��26λ�ļ��������ڷ�Ƶ
	 parameter TIME = 26'd2;//basys2��ϵͳʱ��Ϊ50MHZ
	 
	 always @(posedge clk or negedge rst)//��Ƶ50MHZ-1HZ
	 begin
		if(!rst)//��λ��0
			cnt <= 1'b0;
	 	else if(cnt == TIME-1)
	 		cnt <= 1'b0;
	 	else 
	 		cnt <= cnt + 1'b1;
	 
	 end
	 
	 always @(posedge clk or negedge rst)
	 begin
		if(!rst)
			out <= 1'b0;
		else if(cnt == TIME-1)
		begin	
			if(out == 4'b1001)
				out <= 1'b0;
			else 
				out <= out+4'b0001;
		end		
	 end
	 
endmodule
