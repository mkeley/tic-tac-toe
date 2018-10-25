class TicTacToe
    # initialize
    def initialize
        # set up the board
        @board = Board.new

        # set up the players
        @player_x = Player.new("Missy E", :x, @board)
        @player_y = Player.new("Master P", :y, @board)

        # assign the starting player
        @current_player = @player_x
    end
  # play
    def play

        # loop infinitely
        loop do
            # call the board rendering method
            @board.display_board

            # ask for choice from the current player
            @current_player.get_choice

            # check if game is over
            break if check_game_over

            # switch players
            switch_players
        end
    end
    
    
    # check_game_over?
    def check_game_over
        # check for victory
        # check for draw
        check_victory || check_draw
    end
    
    # check_victory?
    def check_victory
        # IF Board says current player's piece has
        # a winning_combination?
        if @board.winning_combination?(@current_player.piece)
            # then output a victory message
            puts "Congratulations #{@current_player.name}, you win!"
            true
        else
            false
        end
    end

    # check_draw?
    def check_draw
        # If Board says we've filled up 
        if @board.full?
            # display draw message
            puts "Bummer, you've drawn..."
            true
        else
            false
        end
    end

    # switch_players
    def switch_players
        if @current_player == @player_x
            @current_player = @player_y
        else
            @current_player = @player_x
        end
    end

end


# Manages all player-related functionality
class Player
    attr_accessor :name, :piece

    # initialize
    def initialize(name = "Mystery_Player", piece, board)
        # Set marker type (e.g. X or O)
        raise "Piece must be a Symbol!" unless piece.is_a?(Symbol)
        @name = name
        @piece = piece
        @board = board
    end

    # get_choice
    def get_choice
        # loop infinitely
        loop do
            # ask_for_choice
            choice = ask_for_choice

            # IF validate_choice_format is true
            if validate_choice_format(choice)
                # IF piece can be placed on Board
                if @board.add_piece(choice, @piece)
                    # break the loop
                    break
                end
            end
        end
    end



    # ask_for_choice
    def ask_for_choice
        # Display message asking for choice
        puts "#{@name}(#{@piece}), enter your choice in the range of 0 to 8"
        # pull choice from command line
        gets.strip.split('').map(&:to_i)
    end

    # validate_choice_format
    def validate_choice_format(choice)
        # UNLESS choice are in the proper format
        if choice.is_a?(Array) && choice.size == 1
            true
        else
           # display error message
            # Note that returning `nil` acts falsy!
            puts "Your choice are in the improper format!"
        end
    end

end


# Maintains game board state
class Board
    # initialize board
    def initialize
        # set up blank data structure
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
   # render
    def display_board


        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      

            

    end

    # add_piece
    #def add_piece(choice, piece)
        # IF piece_location_valid?
        #if location(choice) = ['']
            # place piece
           ## @board[choice[0]]= piece
            #true
        #else
            #false
        #end
    #end

    # piece_location_valid?
    #def piece_location_valid?(choice)
        # Is the placement within_valid_choice?
        #if within_valid_choice?(choice)
            # Are the piece choice_available?
            #choice_available?(choice)
        #end
    #end

    # within_valid_choice?
    def within_valid_choice?(choice)
        # UNLESS piece choice are in the acceptible range
        if (0..8).include?(choice[0])
            true
        else
            # display an error message
            puts "Piece choice are out of bounds"
        end
    end

    # choice_available?
    #def choice_available?(choice, piece)
        # UNLESS piece choice are not occupied
        #if board == ['', '', '', '', '', '', '', '']
            #true
        #else
            # display error message
            #puts "There is already a piece there!"
        #end
    

    # winning_combination?
    def winning_combination?(piece)
        # is there a winning_diagonal?
        # or winning_vertical? 
        # or winning_horizontal? for that piece?
        winning_diagonal?(piece)   || 
        winning_horizontal?(piece) || 
        winning_vertical?(piece)
    end

    # winning_diagonal?
    def winning_diagonal?(piece)
        # check if specified piece has a triplet across diagonals
        diagonals.any? do |diag|
            diag.all?{|cell| cell == piece }
        end
    end

    # winning_vertical?
    def winning_vertical?(piece)
        # check if specified piece has a triplet across verticals
        verticals.any? do |vert|
            vert.all?{|cell| cell == piece }
        end
    end

    # winning_horizontal?
    def winning_horizontal?(piece)
        # check if specified piece has a triplet across horizontals
        horizontals.any? do |horz|
            horz.all?{|cell| cell == piece }
        end
    end

    # diagonals
    def diagonals
        # return the diagonal pieces
        [[ @board[0][0],@board[1][1],@board[2][2] ],[ @board[2][0],@board[1][1],@board[0][2] ]]
    end

    # verticals
    def verticals
        # return the vertical pieces
        @board
    end
   # horizontals
    def horizontals
        # return the horizontal pieces
        horizontals = []
        3.times do |i|
            horizontals << [@board[0][i],@board[1][i],@board[2][i]]
        end
        horizontals
    end

    # full?
    def full?
        # does every square contain a piece?
        @board.all? do |row|
            row.none?(&:nil?)
        end
    end

end

t = TicTacToe.new
t.play    
    
    
            
    
            
