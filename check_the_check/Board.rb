
class Board
   def initialize()
      print "board here\n"
      bishop = Bishop.new(4,2,self)
      bishop.king_search()
   end

   def piece_at(x, y)
      print "maybe there is a piece at ", x, ", ", y, "\n"
   end

end

