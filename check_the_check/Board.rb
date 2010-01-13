
class Board
   def initialize()
      print "board here\n"
      bishop = Bishop.new(4,4,self)
      bishop.king_search()
   end

   def piece_at(x, y)
      print "how the hell would I know what's at ", x, ", ", y, "?\n"
   end

end

