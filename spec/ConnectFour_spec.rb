require 'spec_helper'

describe Cell do
	before do
		@test_cell = Cell.new ""
	end

	it "creates empty cell" do
		expect(@test_cell.value).to eql("")
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
		expect(@test_board.grid[6][5].value).to eql("")
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
			@test_game.board.grid[2][0..5] = Cell.new("X")
		end
		it "return false if cul in full" do
			expect(@test_game.cul_full?(2)).to eql(false)
		end
	end

	describe "@win?" do
		before do
			@test_game.board.grid[0..2][3] = Cell.new("X")
		end
		it "return true when 4 connects horizontally" do
			
			expect(@test_game.win?(@test_game.player1)).to eql(true)
			
		end
=begin
		it "return true when 4 connects vertically" do
			before do
				@test_game.board.grid[1..4][3] = Cell.new("X")
			end
			expect(@test_game.win?).to eql(true)
		end

		it "return true when 4 connects diagonally" do
			before do
				@test_game.board.grid[0][0] = Cell.new("X")
				@test_game.board.grid[1][1] = Cell.new("X")
				@test_game.board.grid[2][2] = Cell.new("X")
				@test_game.board.grid[3][3] = Cell.new("X")
			end
			expect(@test_game.win?).to eql(true)
		end
=end
	end

end