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
// 2018/4/13    NingHeChuan       1.0                     Original
//  
// *********************************************************************************

module Inst_Mem(
    input           [31:0] pc_addr,
    output      reg [31:0] inst_data
);


//inst_mem
always @(*)begin
	case(pc_addr)
	//R型指令
	'd0: 	inst_data = 32'b000000_00001_00010_00011_00000_100000;//add
	'd1: 	inst_data = 32'b000000_00001_00010_00011_00000_100010;//sub
	'd2: 	inst_data = 32'b000000_00001_00010_00011_00000_100100;//and
	'd3: 	inst_data = 32'b000000_00001_00010_00011_00000_100101;//or
	'd4: 	inst_data = 32'b000000_00001_00010_00011_00000_100110;//xor
	'd5:	inst_data = 32'b000000_00001_00010_00011_00100_000000;//sll
	'd6:	inst_data = 32'b000000_00001_00010_00011_00100_000010;//srl
	'd7:	inst_data = 32'b000000_00001_00010_00011_00100_000011;//sra
	//I型指令
	'd8:	inst_data = 32'b001000_00001_00010_00000_00000_111111;//addi
	'd9:	inst_data = 32'b001100_00001_00010_00000_00000_111111;//andi
	'd10:	inst_data = 32'b001101_00001_00010_00000_00000_111111;//ori
	'd11:	inst_data = 32'b001110_00001_00010_00000_00000_111111;//xori
	'd12:	inst_data = 32'b001111_00001_00010_00000_00000_111111;//lui
 	'd13:	inst_data = 32'b000100_00001_00010_00000_00000_111111;//beq 相等转移
	//'d14:	inst_data = 32'b000101_00001_00010_00000_00000_111111;//bne 不等转移
	//'d15:	inst_data = 32'b100011_00001_00010_00000_00000_111111;//lw 取整数数据字
	//'d16:	inst_data = 32'b101011_00001_00010_00000_00000_111111;//sw 存整数数据字 */
	//J型指令
	//'d17:	inst_data = 32'b000010_00001_00010_00000_00000_111111;//j 跳转
	//'d18:	inst_data = 32'b000011_00001_00010_00000_00000_111111;//jal 调用
	//R型指令
	'd19:	inst_data = 32'b000000_00001_00000_00000_00000_001000;//jr 寄存器跳转
	//异常或中断处理
	//'d14: 	inst_data = 32'b010000_00000_00010_00011_00000_000000;//mfc0 rt, rd
	//'d15: 	inst_data = 32'b010000_00100_00010_00011_00000_000000;//mtc0 rt, rd
	//'d16: 	inst_data = 32'b000000_00000_00000_00000_00000_001100;//syscall
	//'d17: 	inst_data = 32'b010000_00000_00000_00000_00000_011000;//eret
	default:inst_data = 32'b000000_00001_00010_00011_00000_100000;//add
	endcase
	
end

endmodule
