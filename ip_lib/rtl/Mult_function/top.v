`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:18:12 01/29/2017 
// Design Name: 
// Module Name:    top 
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
module top(
			input mclk,
			input rst_n,
			input [3:0] key,
			input clock,//����
			input sel,//����л�
			input stop,//�����ͣ
			input clr,//�������
			input ring,//������Ӧ
			output [3:0] an,
			output [7:0] out,
			output beep
    );
     
     wire [3:0] key_en;
     //������
     wire [2:0] a1;
     wire [3:0] a2;
     wire [2:0] a3;
     wire [3:0] a4;
     //����
     wire [2:0] b1;
     wire [3:0] b2;
     wire [2:0] b3;
     wire [3:0] b4;
     //���
     wire [2:0] c1;
     wire [3:0] c2;
     wire [2:0] c3;
     wire [3:0] c4;
     //���
     wire [2:0] d1;
     wire [3:0] d2;
     wire [2:0] d3;
     wire [3:0] d4;

    // ������ģ��
		cnt_clk U1_cnt_clk(
		    .mclk(mclk), 
		    .rst_n(rst_n),
		    .clock(clock), 
		    .key_en(key_en), 
		    .hour_ten(a1), 
		    .hour_one(a2), 
		    .minute_ten(a3), 
		    .minute_one(a4)
		    );
		    
		// Instantiate the module
		clock_set U2_clock_set(
				.mclk(mclk), 
		    .rst_n(rst_n),
		    .clock(clock),
		    .key_en(key_en), 
		    .hour_ten(b1), 
		    .hour_one(b2), 
		    .minute_ten(b3), 
		    .minute_one(b4)
		    );
		
		// Instantiate the module
		cnt_second U3_cnt_second (
		    .mclk(mclk), 
		    .rst_n(rst_n), 
		    .stop(stop), 
		    .clr(clr), 
		    .minute_ten(c1), 
		    .minute_one(c2),
		    .second_ten(c3), 
		    .second_one(c4)
		    );
		
		// Instantiate the module
		key_scan U4_key_scan (
		    .mclk(mclk), 
		    .rst_n(rst_n), 
		    .key(key), 
		    .key_en(key_en)
		    );
		    
		// Instantiate the module
		seven_seg_display U5_seven_seg_display (
		    .mclk           (mclk), 
		    .rst_n          (rst_n), 
		    .hour_ten           (d1), 
		    .hour_one           (d2), 
		    .minute_ten         (d3), 
		    .minute_one         (d4), 
		    .out            (out), 
		    .an             (an)
		    );
		    
		// �źŴ�������
	 	cpu U6_cpu(
	 	    .mclk(mclk), 
	 	    .rst_n(rst_n), 
	 	    .clock(clock), 
	 	    .sel(sel), 
	 	    .a1(a1), 
	 	    .a2(a2), 
	 	    .a3(a3), 
	 	    .a4(a4), 
	 	    .b1(b1), 
	 	    .b2(b2), 
	 	    .b3(b3), 
	 	    .b4(b4), 
	 	    .c1(c1), 
	 	    .c2(c2), 
	 	    .c3(c3), 
	 	    .c4(c4), 
	 	    .d1(d1), 
	 	    .d2(d2), 
	 	    .d3(d3), 
	 	    .d4(d4)
	 	    );

		// ������Ӧ
		beep U7_beep(
		    .mclk(mclk), 
		    .rst_n(rst_n), 
		    .ring(ring),
		    .a1(a1), 
		    .a2(a2), 
		    .a3(a3), 
		    .a4(a4), 
		    .b1(b1), 
		    .b2(b2), 
		    .b3(b3), 
		    .b4(b4), 
		    .beep(beep)
		    );

endmodule
