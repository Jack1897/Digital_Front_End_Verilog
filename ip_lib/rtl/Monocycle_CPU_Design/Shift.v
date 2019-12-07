`timescale      1ns/1ps
// *********************************************************************************
// Project Name :       
// Author       : NingHeChuan
// Email        : ninghechuan@foxmail.com
// Blogs        : http://www.cnblogs.com/ninghechuan/
// File Name    : .v
// Module Name  :
// Called By    :
// Abstract     :
//
// CopyRight(c) 2018, NingHeChuan Studio.. 
// All Rights Reserved
//
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 2018/4/9    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module shift(
	input 		[4:0]	dina,
	input 		[31:0]	dinb,
	input 				right,
	input 				left,
	output 	reg	[31:0]	doutsh = 0
    );
	
always @(*)begin
	if(left == 1'b1)
		doutsh = dinb << dina;//�߼�����
	else if(right == 1'b1)
		doutsh = dinb >> dina;//�߼�����
	else
		doutsh = $signed(dinb) >>> dina;//���������������������ܱ�ʾ��������
end
	
	
endmodule
