
   
`timescale 1ns / 1ps


module maze(
	input 		clk,
	input[5:0] 	starting_col, starting_row, 		// indicii punctului de start
	input 		maze_in, 							// ofera informa?ii despre punctul de coordonate [row, col]
	output   reg[5:0] row, col, 							// selecteaza un rând si o coloana din labirint
	output 	reg	maze_oe,							// output enable (activeaza citirea din labirint la rândul ?i coloana date) - semnal sincron
	output 	reg	maze_we, 							// write enable (activeaza scrierea în labirint la rândul ?i coloana  date) - semnal sincron
	output 	reg	done);      // ie?irea din labirint a fost gasita; semnalul ramane activ

//starile principale ale automatului
`define startinit       0
`define start           1
`define verstart        2
`define verdep          3
`define dep             4
`define verpos          8
`define stop            9



reg [5:0] rowc, colc;  //copiile coordonatelor, folosite pentru a retine starea anterioara
reg [1:0] dep; //Eu am ales directiile ca si cand as privi matricea pe foaie.
		//directie deplasare:
			//  0->dreapta
			//  1->stanga
			//  2->jos
			//  3->sus


reg [4:0] state, next_state ; 	//starile automatului

always @(posedge clk) begin
	if(done == 0)
		state <= next_state;
end

always @(*) begin
    next_state = `startinit;
	 maze_we = 0;
	 maze_oe = 0;
	 done = 0;
	 case(state)
			`startinit: begin

				dep = 0;//initil plec spre dreapta
				maze_we = 1;
				row = starting_row;
				col = starting_col;
				rowc = starting_row;
				colc = starting_col;

				next_state = `start;
			end


			`start : begin
				//aflam directia initiala de plecare
				case(dep)
					0: col = col + 1; //drepta
					1: col = col - 1; //stanga
					2: row = row + 1; //jos
					3: row = row - 1; //sus
				endcase
				maze_oe = 1;
				next_state =  `verstart;

				end


			`verstart: begin
				if(maze_in == 0) begin //am iesit din start si salvez noua pozitie si in copi
					colc = col;
					rowc = row;
					maze_we = 1;

					next_state = `verdep;
				end

				if(maze_in == 1) begin //ma reintorc in start;
					dep = dep + 1; //incerc o alta directie
					col = colc;
					row = rowc;

					next_state = `start;

				end

			end


			`verdep: begin //verificarea pentru deplasarea viitoare
				//verific mereu ce am in dreapta(luata in functie de deplasare)
				case(dep)
					0: begin //dreapta
						rowc = row; //salvez poz
						row = row + 1; //verific jos


					end

					1: begin //stanga
						rowc = row; //savez poz
						row = row - 1; //verific sus


					end

					2: begin //jos
						colc = col; //salvez poz
						col = col - 1; //verific stanga


					end

					3: begin //sus
						colc = col; //salvez poz
						col = col + 1; // verific dreapta

					end

				endcase
				maze_oe = 1;
				next_state = `dep;

			end

			`verpos: begin //verific daca am 0 sau 1 in pozitia in care ma aflu

				if(maze_in == 0)  begin

					if(col == 0 || col == 63 || row == 0 || row == 63) begin

						maze_we = 1;
						next_state = `stop;

					end

					else begin //daca am 0 dar nu sunt pe margine
						colc = col; //salvez poz in copi
						rowc = row;
						maze_we = 1;
						next_state = `verdep;
					end
				end

				if(maze_in == 1) begin //ma reintorc de unde am venit si schimb cazul de deplasare
					row = rowc;
					col = colc;
					//conditie de deplasare noua
					case(dep) //rotire de 180
						0: dep = 1;
						1: dep = 0;
						2: dep = 3;
						3: dep = 2;
					endcase


					next_state = `verdep;
				end

			end

			`dep: begin
				case(dep)
					0: begin //deplasare dreapta
						//verific ce am jos
						if(maze_in == 1) begin
							row = rowc; //ma reintorc
							colc = col; //salvez pozitia
							col = col + 1; //ma deplasez dreapta

						end

						if(maze_in == 0)  begin //raman si salvez coordonatele in copi
							rowc = row;
							colc = col;
							dep = 2; //schimb cu dep jos

						end

					end

					1: begin //deplasarea stanga

						if(maze_in == 1) begin
							row = rowc; //ma reintorc
							colc = col; //salvez pozitia
							col = col - 1; //ma deplasez stanga

						end

						if(maze_in == 0) begin //raman si salvez coordoatele in copi
							rowc = row;
							colc = col;
							dep = 3; //schimb cu deplasare sus

						end

					end

					2: begin //deplasare jos
						if(maze_in == 1) begin
							col = colc; // ma reintorc
							rowc = row; //salvez pozitia
							row = row + 1; //ma deplasez jos

						end

						if(maze_in == 0) begin //raman si salvez coordonatele in copi
							colc = col;
							rowc = row;
							dep = 1; //schimb cu deplasare stanga

						end

					end

					3: begin //deplasare sus
						if(maze_in == 1) begin
							col = colc; //ma reintorc
							rowc = row; //salvez pozitia
							row = row - 1;//ma deplasez in sus

						end


						if(maze_in == 0) begin //raman si salvez noile coordonate in copi
							colc = col;
							rowc = row;
							dep = 0; // schimb cu deplasare dreapta

						end

					end
				endcase
				maze_oe = 1;
				next_state = `verpos
			end

			`stop: done = 1; //Am iesit!

			default: ;

	endcase

end

endmodule
