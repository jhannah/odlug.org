class Piece
   attr_accessor :x, :y, :board, :color
   def initialize(x, y, board, color) 
      @x, @y, @board, @color = x, y, board, color
   end
end

