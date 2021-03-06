require 'spec_helper'

describe Cell do
	before do
		@test_cell = Cell.new "-"
	end

	it "creates empty cell" do
		expect(@test_cell.value).to eql("-")
	end

	it "update cell value" do
		@test_cell.value = "O"
		expect(@test_cell.value).to eql("O")
	end
end


describe Board do
	before do
		@test_board = Board.new
	end

	it "initialize board" do
		expect(@test_board.grid[6][5].value).to eql("-")
	end

end

describe Player do
	before do
		@test_player = Player.new "X","Peter"
	end

	it "return player name" do
		expect(@test_player.name).to eql("Peter")
	end

end


describe Game do
	before do
		@test_game = Game.new "Peter", "Jojo"
	end

	it "initialize game" do
		expect(@test_game.player1.name).to eql("Peter")
	end

	describe "#move" do
		before do 
			@test_game.board.grid[2][5].value = "b"
			@test_game.move(@test_game.player1, 2)
		end
		it "player1 make a move at colum 2" do
			expect(@test_game.board.grid[2][5].value).to eql("b")
			expect(@test_game.board.grid[2][4].value).to eql(@test_game.player1.color)
		end

	end
	describe "#first_empty" do
		it "first avalibe spot" do 
			expect(@test_game.first_empty(2)).to eql(5)
		end
	end

	describe "#cul_full?" do
		before do
			@test_game.board.grid[2][0..4] = Cell.new("X")
		end
		it "return false if cul in full" do
			expect(@test_game.cul_full?(2)).to eql(false)
		end
	end

	describe "@win?" do
		describe "horizontally win" do
			before do
				@test_game.board.grid[0..3].each_index do|n|
					@test_game.board.grid[n][3] = Cell.new("X")	
				end
			end
			
			it "return true when 4 connects horizontally" do
				expect(@test_game.win?(@test_game.player1)).to eql(true)
				
			end
		end

		describe "vertically win" do
			before do
				@test_game.board.grid[3][1..4].each_index do|n| 
					@test_game.board.grid[3][n]= Cell.new("X")
				end
			end

			it "return true when 4 connects vertically" do			
				expect(@test_game.win?(@test_game.player1)).to eql(true)
			end
		end

		describe "diagonally l to r win" do
			before do
				i = 0
				4.times do 
					@test_game.board.grid[2+i][2+i] = Cell.new("X")	
					i += 1
				end
			end

			it "return true when 4 connects diagonally" do
				expect(@test_game.win?(@test_game.player1)).to eql(true)
			end

		end

		describe "diagonally r to l win" do
			before do
				i = 0
				4.times do 
					@test_game.board.grid[6-i][5-i] = Cell.new("X")	
					i += 1
				end
			end

			it "return true when 4 connects diagonally" do
				expect(@test_game.win?(@test_game.player1)).to eql(true)
			end
		end
	end

	describe "#hor" do
		before do
			@test_game.board.grid[0..3].each_index do|n|
				@test_game.board.grid[n][3] = Cell.new("X")		
			end	
		end
		it "return ture" do			
			expect(@test_game.hor(0,3,"X")).to eql(true)
		end
		it "return false since out of bound" do
			expect(@test_game.hor(9,3,"X")).to eql(false)
		end

	end

end