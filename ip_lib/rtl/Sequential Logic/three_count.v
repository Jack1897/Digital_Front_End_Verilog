`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:44:00 10/06/2016 
// Design Name: 
// Module Name:    count 
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
module count(clk, rst, y
    );
	 input clk, rst;
	 output reg [2:0]y = 3'b111;//��λ�����Ƽ�����
	 
	 reg[25:0] cnt;//����һ��26λ�ļ��������ڷ�Ƶ
	 
	 parameter TIME = 26'd50000000;//basys2��ϵͳʱ��Ϊ50MHZ
	 
	 always @(posedge clk or negedge rst)//��Ƶ50MHZ��1HZ
	 begin
		if(!rst)//��λ��0
		cnt <= 1'b0;
		else if(cnt == TIME-1)
		cnt <= 1'b0;
		else 
		cnt <= cnt + 1'b1;
	 end
	 
	 always @(posedge clk or negedge rst)//��ʱ�ӵ�1s�ǿ�ʼ��λ�����Ƽ���������
	 begin
		if(!rst)//��λ�ü�������ʼֵ
		y <= 3'b111;
		else if(cnt == TIME-1)
		y <= y - 3'b001;
		else
		y <= y;	
	 end 
	 
endmodule
