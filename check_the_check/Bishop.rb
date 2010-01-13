require 'Piece'

class Bishop < Piece
   def king_search()

      @board.piece_at(@x - 1, @y - 1)
     
   end
end



