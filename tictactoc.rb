class Board
  attr_reader :positions

  def initialize
    @positions = Array.new(9, " ")
  end

  def print_board
    puts " #{@positions[0]} | #{@positions[1]} | #{@positions[2]} "
    puts "---+---+---"
    puts " #{@positions[3]} | #{@positions[4]} | #{@positions[5]} "
    puts "---+---+---"
    puts " #{@positions[6]} | #{@positions[7]} | #{@positions[8]} "
    puts
  end

  def print_board_positions
    puts "Board"
    puts " 1 | 2 | 3 "
    puts "---+---+---"
    puts " 4 | 5 | 6 "
    puts "---+---+---"
    puts " 7 | 8 | 9 "
    puts
  end

  def empty_slots?
    !@positions.include?(" ")
  end

  WINNING_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # Columns
    [0, 4, 8], [2, 4, 6]             # Diagonals
  ].freeze

  def winner?
    WINNING_COMBINATIONS.each do |combination|
      positions = [@positions[combination[0]], @positions[combination[1]], @positions[combination[2]]]
      return positions[0] if positions.uniq.size == 1 && positions[0] != " "
    end

    nil
  end

  def place_marker(pos, marker)
    @positions[pos - 1] = marker
  end
end

class Game
  def initialize
    puts "Let's play Tic Tac Toe!\n"
    @board = Board.new
    @board.print_board_positions
    puts "\nSTART"
  end

  def run
    moves = 0
    until end?
      @board.print_board

      position = get_position
      marker = moves.even? ? :X : :O
      puts "\nPLAYER #{marker} MADE A MOVE IN POSITION #{position}"
      @board.place_marker(position, marker)
      moves += 1
    end
    @board.print_board
    puts @board.winner? ? "The winner is Player with \"#{@board.winner?}\"" : "Tie"
  end

  def end?
    @board.winner? || @board.empty_slots?
  end

  def get_position
    position = nil
    until acceptable_position?(position)
      puts "Enter position (1-9): "
      position = gets.chomp.to_i
    end
    position
  end

  def acceptable_position?(position)
    (1..9).include?(position) && @board.positions[position - 1] == " "
  end
end

g = Game.new
g.run
