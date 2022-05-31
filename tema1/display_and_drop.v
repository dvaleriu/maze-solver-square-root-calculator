`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:27:11 11/08/2021 
// Design Name: 
// Module Name:    display_and_drop 
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
module display_and_drop (
    output reg   [6 : 0]   seven_seg1, 
    output  reg [6 : 0]   seven_seg2,
    output  reg [6 : 0]   seven_seg3,
    output  reg [6 : 0]   seven_seg4,
    output reg [0 : 0]   drop_activated,
    input    [15: 0]   t_act,
    input    [15: 0]   t_lim,
    input              drop_en);
	 
	
	 always @(*) begin
			if(t_lim<t_act && drop_en==1) begin
				drop_activated=0;
				seven_seg1=7'b000_0000;
				seven_seg2=7'b111_0110;
				seven_seg3=7'b101_1100;
				seven_seg4=7'b111_1000;
		
			end
			if(t_lim>t_act && drop_en==1) begin
				drop_activated=1;
				seven_seg1=7'b101_1110;
				seven_seg2=7'b101_0000;
				seven_seg3=7'b101_1100;
				seven_seg4=7'b111_0011;
			end
		
			if(t_act<t_lim && drop_en==0) begin
				drop_activated=0;
				seven_seg1=7'b011_1001;
				seven_seg2=7'b101_1100;
				seven_seg3=7'b011_1000;
				seven_seg4=7'b101_1110;
			end
		end
	endmodule
