`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:53 11/07/2021 
// Design Name: 
// Module Name:    sensors_input 
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
module sensors_input (
   output reg   [7 : 0]   height,
   input    [7 : 0]   sensor1,
   input  [7 : 0]   sensor2,
   input   [7 : 0]   sensor3,
   input   [7 : 0]   sensor4);
	
	reg[11:0] sum;
	reg[11:0] sum1;
	reg[11:0]sum2;
	reg[1:0] aux;
	reg[1:0] aux2;
	always @(*) begin
		height = 0;
		aux = 0;
		if(sensor1==0 || sensor3==0) begin
			sum=sensor2+sensor4;
				if(sum[0]==1) begin
					sum=sum+1'b1;
				end
			height=sum/2;
		end
		
		 if(sensor2==0 || sensor4==0) begin 
			sum=sensor1+sensor3;
				if(sum[0]==1) begin
					sum=sum+1'b1;
				end
			height=sum/2;
		end
		
		if(sensor1!=0 && sensor2!=0 && sensor3!=0 && sensor4!=0 ) begin
			sum=sensor1+sensor2+sensor3+sensor4;
			sum1=sensor1+sensor3;
			sum2=sensor2+sensor4;
			height=sum+(sum&2)>>2;
			
//			height=sum/4;
		end
//		
//				if(sum[0]==4 || sum[0]==3 || sum[0]==2 ) begin
//			height=sum/4+1'b1;
//		end
		end
endmodule
		
		
//			//sum1=sensor1+sensor3;
//			//sum2=sensor2+sensor4;
//			//sum=sum1+sum2;
//			//if(sum1[0]==1) begin
//			//sum1=sum1+1'b1;
//			//end
//			//if(sum2[0]==1) begin
//			//sum2=sum2+1'b1;
//			end
//			if(sum1[0]+sum2[0]%2==0 && sum1[0]+sum2[0]%4==0) begin
//				sum2=sum2+1'b1;
//				end
//			if(sum[1]==1) begin
//				sum=sum+2'b1;
//				end
//			
//			height=(sum1+sum2)/4;		
//				end		
//			end


			//if((sensor1[0]==1 && sensor2[0]==1 && sensor3[0]==1  && sensor4[0]==0)) begin
				//height=height+1;
			//end
	
			//if(sensor1[0]==0 && sensor2[0]==1 && sensor3[0]==1  && sensor4[0]==1) begin
				//height=height+1;
			//end
			//if(sensor1[0]==1 && sensor2[0]==1 && sensor3[0]==0 && sensor4[0]==0) begin
					//height=height+1;
			//end
			
			//if(sensor1[0]==1 && sensor2[0]==0&& sensor3[0]==0  && sensor4[0]==1) begin
					//hight=height+1;
			//end
		//	if(sensor1[0]==0 && sensor2[0]==1 && sensor3[0]==1 && sensor4[0]==0) begin
					//height=height+1;
//end
			//if(sensor1[0]==1 && sensor2[0]==0 && sensor3[0]==0  && sensor4[0]==0) begin
					//height=height+1;
			//end
			//if(sensor1[0]==0 && sensor2[0]==0 && sensor3[0]==0  && sensor4[0]==0) begin
					//height=height+1;
			//end
			//if(sensor1[0]==1 && sensor2[0]==0 && sensor3[0]==1  && sensor4[0]==0) begin
					//height=height+1;
			//end
			//if(sensor1[0]==1 && sensor2[0]==1 && sensor3[0]==1  && sensor4[0]==1) begin
					//height=height+2;
			//end
			
		//end
	

