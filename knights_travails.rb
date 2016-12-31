class Knight
  attr_accessor :start, :finish
  def initialize
    @board = Board.new
    @start = nil
    @finish = nil
  end
  
  def enter_move
    until @start
      print "Where would you like to start?: "
      @start = gets.chomp.split.map(&:to_i)
      print "Where would you like to finish?: "
      @finish = gets.chomp.split.map(&:to_i)
      invalid_move if @board.valid_move?(@start) == false  || @board.valid_move?(@finish) == false  
    end
    make_move
  end

  def make_move
    queue = [Node.new(@start)]
    loop do 
      node = queue.shift
      create_node_path(node) if @finish == node.data
      valid_moves = @board.possible_moves(node.data)
      valid_moves.each do |i|
        move = Node.new(i, node)
        node.children << move
        queue << move
      end
    end	
  end

  def create_node_path(node)
  	move_path = []
    until node.parent.nil?
      move_path.unshift(node.data)
      node = node.parent
    end
    puts "You make get there in #{move_path.size} moves!"
    print "#{move_path.to_s}\n"
    exit
  end

  def invalid_move
    puts "That move was invalid :("
    @start = nil
    @finish = nil
  end
end

class Board
  def possible_moves(position)
  	x, y = position
    moves = [[x-2, y+1], [x+2, y+1], [x-2, y-1], [x+2, y-1],
    		 [x-1, y+2], [x+1, y+2], [x-1, y-2], [x+1, y-2]]
    moves.select { |i| valid_move?(i) }
  end
  
  def valid_move?(position)
  	x, y = position
    if x.to_i.between?(0, 7) && y.to_i.between?(0, 7)
      true
    else
      false
    end
  end
end

class Node
  attr_accessor :data, :parent, :children
  def initialize(data=nil, parent=nil)
    @data = data
    @parent = parent
    @children = []
  end
end

game = Knight.new
game.enter_move