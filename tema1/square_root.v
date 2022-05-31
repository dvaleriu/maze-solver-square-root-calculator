module square_root (
    output reg [15:0] out,
    input [7:0] in );

	reg [15:0] ress;
	reg[15:0] copie;
	reg[7:0] in1;
	reg[10:0] intreg;
	reg[15:0] out1;
	reg contor;
	
	always @(in) begin
	in1 = in;
	out = 0;
	copie = 0;
	contor=0;
		for(intreg = 0; intreg < 12; intreg = intreg + 1) begin
		      out1=0;
				copie[contor] = in1[contor+6];
				copie[contor+1]= in1[contor+7];        	
				out1=out;
				ress = copie - {out1, 2'b01};
				out = out << 1;
					if((ress  & 16'h8000)>> 15 == 1'b0) begin
						copie =ress ; 
						out[0] = 1 ; 
					end
				in1 = {in1,2'b00};
				copie ={copie,2'b00};
 
		end
	end
endmodule