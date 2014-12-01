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
      Array.new(7) { Array.new(6) { Cell.new("-")} }
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
	attr_accessor :player1, :player2, :board, :hor_arr, :ver_arr, :dig_arr, :arr
	def initialize(player1, player2)
		@player1 = Player.new("X", player1)
		@player2 = Player.new("O", player2)
		@board = Board.new
		@hor_arr = 0
		@ver_arr = 0
		@dig_arr = 0
	end

	def play
		current_player = @player2
		until win?(current_player)
			if current_player == @player1
				current_player = @player2
			else
				current_player = @player1
			end
			display
			print "enter your move #{current_player.name}: "
			player_move = gets.chomp.to_i
			move(current_player,player_move-1)
		end
		display
		print "#{current_player.name} won!!!"
	end

	def move(player, place)
		@board.grid[place][first_empty(place)].value = player.color
	end

	def first_empty(place)
		first = @board.grid[place].index{|x| x.value!="-"}
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
				elsif dig_l_r(x,y,player.color)
					return true
				elsif dig_r_l(x,y,player.color)
					return true
				end
			end
		end
		return false
	end

	def hor(x,y,color)
		if (x+3) > 6
			return false
		else
			@arr = 0
			@board.grid[x..x+3].each_index do |n|				
				@arr =  @board.grid[x+n][y].value == color ? @arr+1 : @arr
			end
			if @arr >= 4
				return true
			end
		end
		return false
	end

	def ver(x,y,color)
		if (y+3) > 5
			return false
		else
			@arr = 0
			@board.grid[x][y..y+3].each_index do |n|				
				@arr =  @board.grid[x][y+n].value == color ? @arr+1 : @arr
			end
			if @arr >= 4
				return true
			end
		end
		return false
	end

	def dig_l_r(x,y,color)
		if (x+3 )> 6 || (y+3) >5
			return false
		end
		i = 0
		counter = 0
		4.times do 
			if @board.grid[x+i][y+i].value == color
				counter += 1
			end
			i += 1
		end
		return counter==4? true : false
	end

	def dig_r_l(x,y,color)
		if (x-3)<0 || (y+3) > 5
			return false
		end
		i = 0
		counter = 0
		4.times do 
			if @board.grid[x-i][y+i].value == color
				counter += 1
			end
			i += 1
		end
		return counter==4? true : false
	end

	def display
		puts "1 2 3 4 5 6 7"
		@board.grid[0].each_index do |m|
			@board.grid.each_index do |n|
				print @board.grid[n][m].value + " "
			end
			puts ""
		end
	end

end


puts "enter player1 name: "
player1 = gets.chomp
puts "enter player2 name: "
player2 = gets.chomp
new_game = Game.new(player1,player2)
new_game.play

