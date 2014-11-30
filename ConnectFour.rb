class Cell
	attr_accessor :value
	def initialize (value)
		@value = value
	end
end

class Board
	attr_reader :grid
    def initialize
		@grid = default_grid
    end
 
    private
 
    def default_grid
      Array.new(7) { Array.new(6) { Cell.new("")} }
    end


end


class Player
	attr_accessor :color, :name
	def initialize(color, name)
		@color = color
		@name = name
	end

end



class Game
	attr_accessor :player1, :player2, :board, :hor_arr, :ver_arr, :dig_arr
	def initialize(player1, player2)
		@player1 = Player.new("X", player1)
		@player2 = Player.new("O", player2)
		@board = Board.new
		@hor_arr = 0
		@ver_arr = 0
		@dig_arr = 0
	end

	def move(player, place)
		@board.grid[place][first_empty(place)].value = player.color
	end

	def first_empty(place)
		first = @board.grid[place].index{|x| x.value!=""}
		if first == nil
			first = 5
		else
			first -= 1
		end
		return first
	end

	def cul_full?(place)
		if first_empty(place) == (-1)
			return false
		end
	end

	def win?(player)

		@board.grid.each_index do |x|
			@board.grid[x].each_index do |y|
				if hor(x,y,player.color)
					return true
				elsif ver(x,y,player.color)
					return true
				elsif dig(x,y,player.color)
					return true
				end
			end
		end
		return false
	end

	def hor(x,y,color)
		if check(x-3,y,color) ||check(x-2,y,color)||check(x-1,y,color)||check(x,y,color)
			return true
		else
			return false
		end
	end

	def ver(x,y,color)
	end

	def dig(x,y,color)
	end

	def check(x,y,color)
		if x+3 > 6 || y+3 > 5 || x < 0 || y < 0
			return false
		else
			arr = @board.grid[x..x+3][y].select do |x|
				x.value == color
			end
			if arr.length == 4
				return true
			end
		end
		return true
	end

end


