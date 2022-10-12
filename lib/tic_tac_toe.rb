require 'pry'

class TicTacToe
    def initialize(board = [" "," "," "," "," "," "," "," "," "], x_arr = [], o_arr = [])
        @board = board
        @x_arr = x_arr
        @o_arr = o_arr
    end

    attr_accessor :board
    attr_accessor :input
    attr_accessor :index
    attr_accessor :player
    attr_accessor :who_won
    attr_accessor :x_arr
    attr_accessor :o_arr
    
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{@board[0..2].join(' | ')} ", "-----------", " #{@board[3..5].join(' | ')} ", "-----------", " #{@board[6..8].join(' | ')} "
    end

    def input_to_index(user_input)
        user_input.to_i-1
    end

    def move(index, player)
        @board[index] = player
    end

    def position_taken?(index)
        if @board[index] == " "
            false
        else
            true
        end
    end

    def valid_move?(index)
        if (index.between?(0,9)) && (self.board[index] == " ") 
            true
        else
            false
        end
    end

    def turn_count
        @board.select {|item| item != " "}.length
        
    end

    def current_player
        if (@board.select {|item| item != " "}.length+1).even?
            return "O"
        else
            return "X"
        end
    end

    def turn
        @input = gets
        self.index = self.input_to_index(self.input)
        self.player = self.current_player
        

        if valid_move?(self.index)
            self.board[self.index] = self.player
        else
            self.turn
        end

        display_board
    end

    def won?

        self.board.map.with_index do |item, index|
            if item == "X"
                self.x_arr << index
            elsif item == "O"
                self.o_arr << index
            end
        end
        
        WIN_COMBINATIONS.map.with_index do |combo, index|
            if (combo-x_arr) == []
                self.who_won = "X"
                return combo
            elsif (combo-o_arr) == []
                self.who_won = "O"
                return combo
            end
        end

        false
    end

    def full?
        state = true
        board.map do |item|
            if item==" "
                state = false
            end
        end
        if state==true
            return state
        end
    end

    def draw?
        if (self.full? == true) && (self.won? == false)
            return true
        else
            return false
        end
    end

    def over?
        if (self.won? == true) || (self.full? == true)
            return true
        end
    end

    def winner
        if self.won? != false
            return self.who_won
        end
    end
end

game = TicTacToe.new

# binding.pry