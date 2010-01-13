require 'Piece'

class Bishop < Piece
   def king_search()

      # up, left
      tmp_x = @x - 1
      tmp_y = @y - 1
      while tmp_x > 0 and tmp_y > 0 do
         @board.piece_at(tmp_x, tmp_y)
         tmp_x -= 1
         tmp_y -= 1
      end

      # up, right
      tmp_x = @x + 1
      tmp_y = @y - 1
      while tmp_x < 9 and tmp_y > 0 do
         @board.piece_at(tmp_x, tmp_y)
         tmp_x += 1
         tmp_y -= 1
      end

      # down, right
      tmp_x = @x + 1
      tmp_y = @y + 1
      while tmp_x < 9 and tmp_y < 9 do
         @board.piece_at(tmp_x, tmp_y)
         tmp_x += 1
         tmp_y += 1
      end

      # down, left
      tmp_x = @x - 1
      tmp_y = @y + 1
      while tmp_x > 0 and tmp_y < 9 do
         @board.piece_at(tmp_x, tmp_y)
         tmp_x -= 1
         tmp_y += 1
      end

   end
end



