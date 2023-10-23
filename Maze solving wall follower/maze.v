`timescale 1ns / 1ps

module maze(
	input 		clk,
	input[5:0] 	starting_col, starting_row,
	input 		maze_in,
	output   reg[5:0] row, col,
	output 	reg	maze_oe,
	output 	reg	maze_we,
	output 	reg	done);

`define deplasare_dreapta  0
`define deplasare_sus      1
`define deplasare_stanga   2
`define deplasare_jos      3

`define citire_dreapta 0
`define citire_fata    1
`define citire_stanga  2
`define citire_spate   3

`define citire     0
`define verificare 1

reg[1:0] directie_deplasare;
reg[1:0] loc_apropiere;
reg      initializat;
reg		 citire_sau_verificare;
reg	     continua;

reg[5:0] row_ajutator, col_ajutator;

initial begin
	initializat = 0;
	done = 0;
	continua = 1;
end

always @(posedge clk) begin
	initializat <= 1;
	continua <= continua + 1;
end

always @(*) begin
	if(done == 0) begin
	if(continua) begin
	end
	if(initializat == 0) begin
		maze_we = 0;
		maze_oe = 1;
		directie_deplasare = `deplasare_jos;
		row = starting_row;
		col = starting_col;
		row_ajutator = row;
		col_ajutator = col;
		loc_apropiere = `citire_dreapta;
		citire_sau_verificare = `verificare;
	end
	else begin
		case(citire_sau_verificare)
			`citire: begin
				if(maze_in == 0)
					if((col == 0 || row == 0 || col == 63 || row == 63))
						done = 1;
				maze_oe = 1;
				maze_we = 0;
				citire_sau_verificare = `verificare;
				
				// Dreapta
				if(directie_deplasare == `deplasare_dreapta) begin
					case(loc_apropiere)
						`citire_dreapta: begin
							row = row_ajutator + 1;
							col = col_ajutator;
						end
						`citire_fata: begin
							col = col_ajutator + 1;
							row = row_ajutator;
						end
						`citire_stanga: begin
							row = row_ajutator - 1;
							col = col_ajutator;
						end
						`citire_spate: begin
							col = col_ajutator - 1;
							row = row_ajutator;
						end
					endcase
				end
				
				// Sus
				else if(directie_deplasare == `deplasare_sus) begin
					case(loc_apropiere)
						`citire_dreapta: begin
							col = col_ajutator + 1;
							row = row_ajutator;
						end
						`citire_fata: begin
							row = row_ajutator - 1;
							col = col_ajutator;
						end
						`citire_stanga: begin
							col = col_ajutator - 1;
							row = row_ajutator;
						end
						`citire_spate: begin
							row = row_ajutator + 1;
							col = col_ajutator;
						end
					endcase
				end
				
				// Stanga
				else if(directie_deplasare == `deplasare_stanga) begin
					case(loc_apropiere)
						`citire_dreapta: begin
							row = row_ajutator - 1;
							col = col_ajutator;
						end
						`citire_fata: begin
							col = col_ajutator - 1;
							row = row_ajutator;
						end
						`citire_stanga: begin
							row = row_ajutator + 1;
							col = col_ajutator;
						end
						`citire_spate: begin
							col = col_ajutator + 1;
							row = row_ajutator;
						end
					endcase
				end
				
				// Jos
				else if(directie_deplasare == `deplasare_jos) begin
					case(loc_apropiere)
						`citire_dreapta: begin
							col = col_ajutator - 1;
							row = row_ajutator;
						end
						`citire_fata: begin
							row = row_ajutator + 1;
							col = col_ajutator;
						end
						`citire_stanga: begin
							col = col_ajutator + 1;
							row = row_ajutator;
						end
						`citire_spate: begin
							row = row_ajutator - 1;
							col = col_ajutator;
						end
					endcase
				end
				
			end
		
			`verificare: begin
				citire_sau_verificare = `citire;
				if(maze_in == 0) begin
					maze_we = 1;
					maze_oe = 0;
					row_ajutator = row;
					col_ajutator = col;	
					
					case(loc_apropiere)
						`citire_dreapta: begin
							if(directie_deplasare == `deplasare_dreapta) begin
								directie_deplasare = `deplasare_jos;
							end
							else if(directie_deplasare == `deplasare_sus) begin
								directie_deplasare = `deplasare_dreapta;
							end
							else if(directie_deplasare == `deplasare_stanga) begin
								directie_deplasare = `deplasare_sus;
							end
							else if(directie_deplasare == `deplasare_jos) begin
								directie_deplasare = `deplasare_stanga;
							end
						end
						`citire_fata: begin
							if(directie_deplasare == `deplasare_dreapta) begin
								directie_deplasare = `deplasare_dreapta;
							end
							else if(directie_deplasare == `deplasare_sus) begin
								directie_deplasare = `deplasare_sus;
							end
							else if(directie_deplasare == `deplasare_stanga) begin
								directie_deplasare = `deplasare_stanga;
							end
							else if(directie_deplasare == `deplasare_jos) begin
								directie_deplasare = `deplasare_jos;
							end
						end
						`citire_stanga: begin
							if(directie_deplasare == `deplasare_dreapta) begin
								directie_deplasare = `deplasare_sus;
							end
							else if(directie_deplasare == `deplasare_sus) begin
								directie_deplasare = `deplasare_stanga;
							end
							else if(directie_deplasare == `deplasare_stanga) begin
								directie_deplasare = `deplasare_jos;
							end
							else if(directie_deplasare == `deplasare_jos) begin
								directie_deplasare = `deplasare_dreapta;
							end
						end
						`citire_spate: begin
							if(directie_deplasare == `deplasare_dreapta) begin
								directie_deplasare = `deplasare_stanga;
							end
							else if(directie_deplasare == `deplasare_sus) begin
								directie_deplasare = `deplasare_jos;
							end
							else if(directie_deplasare == `deplasare_stanga) begin
								directie_deplasare = `deplasare_dreapta;
							end
							else if(directie_deplasare == `deplasare_jos) begin
								directie_deplasare = `deplasare_sus;
							end
						end
					endcase
					loc_apropiere = `citire_dreapta;
				end
				else if(maze_in == 1) begin
					loc_apropiere = loc_apropiere + 1;
				end
			end
		endcase
	end
	end
end

endmodule
