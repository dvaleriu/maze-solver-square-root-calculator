
module maze(
input 		          clk,
input [5:0]  starting_col, starting_row, 	// indicii punctului de start
input  			  maze_in, 			// ofera informatii despre punctul de coordonate [row, col]
output 		reg [5:0] row, col,	 		// selecteaza un rând si o coloana din labirint
output 		reg   maze_oe,			// output enable (activeaza citirea din labirint la rândul si coloana date) - semnal sincron	
output 		reg	  maze_we, 			// write enable (activeaza scrierea în labirint la rândul si coloana date) - semnal sincron
output 		reg	  done);		 	// iesirea din labirint a fost gasita; semnalul ramane activ 


`define dreapta 0
`define sus 1
`define jos 2
`define stanga 3
`define verificare_pentru_dreapta 4 //verific sa vad daca sunt libere casutele din directiile respective
`define verificare_pentru_sus 5
`define verificare_pentru_jos 6
`define verificare_pentru_stanga 7
`define mutare_catre_dreapta 8 // mut catre directia respectiva inainte de verificare
`define mutare_catre_sus 9
`define mutare_catre_jos 10
`define mutare_catre_stanga 11
`define directie 12
`define initial 13



reg [3:0] state=0;
reg [3:0] next_state;





always @(posedge clk) begin
	if(done == 0)
		state <= next_state;
end
reg [2:0] dep; //deplasare

always @(*) begin

maze_we = 0; //schimb in momentul in care gasesc maze_in=0
maze_oe = 1;
done=0;
		 case (state) 
		 
		 
					0 : begin  //initial
						row = starting_row;
						col =  starting_col;
						maze_we =1;
						next_state = `mutare_catre_dreapta; //incerc plecarea spre dreapta
						done=0;
						end 
					
				`mutare_catre_dreapta: begin
						col = col +1;
						next_state = `verificare_pentru_dreapta; //ma mut si apoi verific
						done=0;
						end 
					
					
					
		

				`verificare_pentru_dreapta:	begin
				if(maze_in!=0) begin
								col = col -1; //in cazul in care maze_in este 1, ma intorc de unde am venit
								next_state = `mutare_catre_sus; //daca maze_in=1, ma intorc, incerc in sus
								done=0; //nu este terminat
								end
								else begin
										maze_we = 1; //suprascriu, pun 2 pe unde am trecut
										dep = `dreapta; 
										done=0;
										next_state = `directie; 
				
								end 
								
				
						end 
				
				
		
				`mutare_catre_jos: begin 
									row = row +1;  // ca mai sus
									done=0;
									next_state = `verificare_pentru_jos; 
								end
			
				`verificare_pentru_jos: begin
				
				if(maze_in!=0) begin
									row = row - 1; 
									done=0;
									next_state = `mutare_catre_dreapta;
								end
								else begin
									maze_we = 1;
									dep = `jos;
									done=0;
									next_state = `directie;
								end 
								
								end 
				
		
				`mutare_catre_sus: begin  
					
									row = row - 1;
									done=0;
									next_state = `verificare_pentru_sus;
								end 
								
					
				`verificare_pentru_sus :begin
				
				if(maze_in!=0) begin
										row = row + 1; 
										done=0;
										next_state = `mutare_catre_stanga;
									end
									else begin
										maze_we = 1;
										dep = `sus;
										done=0;
										next_state = `directie;
									end 
									
								end 
				
		
				`mutare_catre_stanga: begin  
					
									col = col - 1;
									done=0;
									next_state = `verificare_pentru_stanga;
								end 
							
				`verificare_pentru_stanga: begin
				
				if(maze_in!=0) begin
										col = col + 1; //ma intorc
										done=0;
										next_state = `mutare_catre_jos;
									end
									else begin
										maze_we = 1;
										done=0;
										dep = `stanga;
										next_state = `directie;
									end 
									
								end 
		  

		
					`directie: begin //verific directiile scrise mai sus sa vad in ce parte ma indrept
								if (dep == `dreapta && dep!=`jos && dep!=`stanga && dep!=`sus ) begin // iau doar un caz adevarat din cele 4
								next_state = `mutare_catre_jos;
								done=0; //nu este terminat pana in momentul in care se aplica ultima conditie
								end
								if (dep != `dreapta && dep==`jos && dep!=`stanga && dep!=`sus ) begin
								next_state = `mutare_catre_stanga;
								done=0;
								end
								if (dep != `dreapta && dep!=`jos && dep==`stanga && dep!=`sus ) begin
								next_state = `mutare_catre_sus;
								done=0;
								end
							        if (dep != `dreapta && dep!=`jos && dep!=`stanga && dep==`sus ) begin
								next_state = `mutare_catre_dreapta;
								done=0;
								end
								if (row == 0 || row == 63 || col == 0 || col == 63) begin //conditia finala, daca se aplica s-a terminat
								done=1; 
								end
								end 

						




			endcase
end





endmodule
