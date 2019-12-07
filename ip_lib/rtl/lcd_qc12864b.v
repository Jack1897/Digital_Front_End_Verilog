`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:05:44 01/17/2017 
// Design Name: 
// Module Name:    lcd_qc12864b 
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
module lcd_qc12864b(
			input mclk,
			input rst_n,
			output reg lcd_rs,/*���ڷ�ʽ��rs=1ʱ����mpu���ж�ģ�������ָ���ַ�Ĵ���
																						��mpu����дģ�������ָ��ָ��Ĵ���
																		rs=0ʱ�����۽��ж�/д��������ָ�����ݼĴ���
													���ڷ�ʽ��cs������Ƭѡ�źţ��ߵ�ƽ��Ч*/
			output lcd_rw, //�ߵ�ƽ���������͵�ƽд����
			output lcd_e,//ʹ���źŸߵ�ƽ��Ч
			output reg [7:0]lcd_data//��λ��������  
//    output PSB//�������ƶ˿�,HΪ���У�LΪ����,ֱ�ӽ�5v  
//    output LCD_Rst,//Һ���ĸ�λ�˿ڣ��͵�ƽ��Ч
    );
    	
    reg lcd_clk;//��Ҫ500khzƵ�ʵ�ʱ��
    reg [7:0] state;//״̬���Ĵ���
    reg [23:0] cnt;//��Ƶ����12864������
    reg flag = 1'b1;//��ʾ��ɱ�־ 
    reg [5:0] char_cnt;// 
    reg [7:0] data_disp = 8'd32;//һ���ֽ��ǰ�λ,һ��Ӣ���ַ���һ���ֽڣ������������ֽ�
    
    parameter T500KHZ=24'd49999;  
//  parameter T500KHZ=24'd24_999_999;//���Ե�Ƶ����  
  	 //parameter T500KHZ=24'd24_499;//����ר��
		
		//��Ƶ500khzʱ��
		always @(posedge mclk or negedge rst_n)
		begin
			if(!rst_n)begin
				lcd_clk <= 1'b0;
				cnt <= 24'd0;
			end
			else if(cnt == T500KHZ)begin
				cnt <= 24'd0;
				lcd_clk <= ~lcd_clk;
			end
			else
				cnt <= cnt + 1'd1;
		end		
		
		//״̬��8��״̬����
    //state machine description,8��״̬ ֻҪ�ð�λ�����ƾͿ���ȫ����ʾ  
    parameter IDLE=8'b00_000_000,//��ʼ״̬  
    					SETFUNCTION=8'b00_000_001,//�������ã�8-bit+����ָ�0x30    
  						SWITCHMODE=8'b00_000_100,//������ʾ���͹����˸�ر�  
  						CLEAR=8'b00_001_000,//��������  
  						SETMODE=8'b00_010_000,//������  
  						SETDDRAM=8'b00_100_000,//��ʼ������  
  						WRITERAM=8'b01_000_000,//д����//д��Ĵ���  
  						STOP=8'b10_000_000;//LCD����ֹͣ���ͷ������
	  
	  //����ʽ��д״̬��
	  //״̬��ʼֵ
	  always @(posedge lcd_clk or negedge rst_n)
	  begin
	  	if(!rst_n)
	  		lcd_rs <= 1'b0;
	  	else begin
	  		if(state == WRITERAM)
	  			lcd_rs <= 1'b1;
	  		else
	  			lcd_rs <= 1'b0;
	  	end
	  end
	  
	  //���������LCD_Rst�����˿ڵĻ���������������  
    //assign LCD_Rst=1'b1;  
    //assign PSB=1'b1;  
    assign lcd_rw = 1'b0;//ֻ��д����������Ҫ������  
    assign lcd_e = (flag==1)?lcd_clk:1'b0;//ʹ���ź���Һ��ʱ��ͬ��
	  
	  always @(posedge lcd_clk or negedge rst_n)
	  begin
	  	if(!rst_n)begin
	  		state <= IDLE; 	
	  		lcd_data <= 8'bzz_zzz_zzz;
	  		char_cnt <= 6'd0;
	  	end
	  	else begin
	  		case(state)
	  			IDLE:begin
	  				state <=  SETFUNCTION;//�������ã�8-bit+����ָ�0x30
	  				lcd_data <= 8'h30;
	  			end
	  			
	  			SETFUNCTION:begin
	  				state <= SWITCHMODE;//������ʾ���͹����˸�ر�
	  				lcd_data <= 8'h30;
	  			end	  			
        
	  			SWITCHMODE:begin
	  				state <= CLEAR;//��������
	  				lcd_data <= 8'h0c;//��ʾ���ã�ȫ��ʾ����������˸��
	  			end	  			
	  			CLEAR:begin
	  				state <= SETMODE;//������  
            lcd_data <= 8'h01;//����
          end          
          SETMODE:begin
          	state <= SETDDRAM;//��ʼ������
          	lcd_data <= 8'h06;//������,������ƣ���ַ��һ,���岻��
          end         
          SETDDRAM:begin
          	state <= WRITERAM;//д����
				    if(char_cnt==6'd0)  
				        lcd_data<=8'h80;//line1  
				    else if(char_cnt == 6'd12)
				        lcd_data<=8'h90;//line2
				    else if(char_cnt == 6'd25)
				    	lcd_data <= 8'h88;
				  end				  
					WRITERAM:begin  
				    if(char_cnt < 6'd12)  
				    begin  
				    	char_cnt <= char_cnt + 1'b1;  
				    	lcd_data <= data_disp;  
				    	if(char_cnt == 6'd11)  
				    	    state <= SETDDRAM;//��һ��д�����·������õ�ַ  
				    	else
				    	    state <= WRITERAM;//�������д������ 
				    end  
				    else if(char_cnt > 6'd11 && char_cnt < 6'd25)  
				    begin  
				    	char_cnt <= char_cnt + 1'b1;  
				    	lcd_data <= data_disp; 
				    	if(char_cnt == 6'd24)  
				    		state <= SETDDRAM;//�ڶ���д�����·������õ�ַ 
				    	else
				    		state <= WRITERAM;//�������д������          
				    end
				    else if(char_cnt > 6'd24 && char_cnt < 6'd41)begin
				    	if(char_cnt == 6'd40)begin
				    		state <= STOP;
				    		char_cnt <= 6'd0;
				    		flag <= 1'b0; 
				    	end
				    	else begin
				    		lcd_data <= data_disp;//���ܵ�û����25����Ҫ����д��  
				    		state <= WRITERAM;  
				    		char_cnt <= char_cnt + 1'b1;  
				    	end
				    end
 					end				
          STOP: state <= STOP;//LCD����ֹͣ���ͷ������
          default: state <= IDLE;//�ص���ʼ״̬
        endcase  
      end           
 		end  
 		
		always@(char_cnt)  
		begin 
			case(char_cnt) 
				//��ʾ��һ�� 
			    6'd0:data_disp=8'h20;  
			    6'd1:data_disp=8'h20;  
			    6'd2:data_disp=8'h20;  
			    6'd3:data_disp=8'h20;  
			    6'd4:data_disp=8'hce;  
			    6'd5:data_disp=8'hd2;  
			    6'd6:data_disp=8'hcf;  
			    6'd7:data_disp=8'heb;  
			    6'd8:data_disp=8'hc4;  
			    6'd9:data_disp=8'he3;  
			    6'd10:data_disp=8'h20;  
			    6'd11:data_disp=8'h20;  
			  //�ڶ���  
			    6'd12:data_disp=8'h20;  
			    6'd13:data_disp=8'h20;  
			    6'd14:data_disp=8'hd0;  
			    6'd15:data_disp=8'ha1;  
			    6'd16:data_disp=8'hc5;  
			    6'd17:data_disp=8'hdd;  
			    6'd18:data_disp=8'hc5;  
			    6'd19:data_disp=8'hdd;  
			    6'd20:data_disp=8'hb6;  
			    6'd21:data_disp=8'hf9;  
			    6'd22:data_disp="!";  
			    6'd23:data_disp="!";  
			    6'd24:data_disp="!";  
			  //������
			  	6'd25:data_disp=8'h20;  
			    6'd26:data_disp=8'h20;  
			    6'd27:data_disp=8'hce;  
			    6'd28:data_disp=8'hd2;  
			    6'd29:data_disp=8'hb0;  
			    6'd30:data_disp=8'hae;  
			    6'd31:data_disp=8'hc4;  
			    6'd32:data_disp=8'he3;  
			    6'd33:data_disp=",";  
			    6'd34:data_disp=8'h20;  
			    6'd35:data_disp=8'hc4;  
			    6'd36:data_disp=8'hbe;  
			    6'd37:data_disp=8'hc2;
			    6'd38:data_disp=8'hed;
			    6'd39:data_disp="!";
			    //default:data_disp=8'h32;  
			endcase  
		          
		end  

endmodule
