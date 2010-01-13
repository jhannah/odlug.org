
class Piece
   attr_reader :x, :y, :board
   def initialize(x, y, board) 
      @x, @y, @board = x, y, board
      print "piece here\n"
   end
end

class Bishop < Piece
end
class Pawn < Piece
end


