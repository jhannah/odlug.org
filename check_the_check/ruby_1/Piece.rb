class Piece
   attr_accessor :x, :y, :board, :color
   def initialize(x, y, board, color) 
      @x, @y, @board, @color = x, y, board, color
   end
   def report() 
      rval = "Hello, I am ", color, " ", self, " at ", x, ",", y
      return rval
   end
end

