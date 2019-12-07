`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:56:43 10/29/2016 
// Design Name: 
// Module Name:    binbcd 
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
module binbcd(in, out
    );
	 input [13:0] in;//ʮ����9999�Ķ�����Ϊ14λ
	 output reg [16:0] out;//ʮ����9999�Ķ�����BCD��Ϊ16λ��out��λ���������in��λ���ʾ�����ʮ���������趨���λ��
	 
	 /*
	 z��Ϊ�洢BCD��ͽ�����ļĴ���
	 �������Ϊ14λ�� ���Ϊ17λ
	 */
	 reg [30:0] z;
	 
	 always @(*)
	 begin
		z = 30'b0;
		z[13:0] = in;
		repeat(14)//����λ����������λ���ٴ�
		begin
			if(z[17:14] > 4)//��λ����4����3
				z[17:14] = z[17:14] +2'b11;
			if(z[21:18] > 4)//ʮλ����4����3
				z[21:18] = z[21:18] + 2'b11;
			if(z[25:22] > 4)//��λ����4����3
				z[25:22] = z[25:22] + 2'b11;
			if(z[29:26] > 4)//ǧλ����4����3
				z[29:26] = z[29:26] + 2'b11;
			z[30:1] = z[29:0];//ѭ����λ
		end
		out = z[30:14];
	 end
	 
	

endmodule
