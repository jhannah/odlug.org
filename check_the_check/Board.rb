require 'Rook'
require 'Knight'
require 'Bishop'
require 'Queen'
require 'King'
require 'Pawn'

class Board
   def initialize()
      print "board here\n"
      bishop = Bishop.new(4,2,self,"white")
      bishop.king_search()
   end

   def piece_at(x, y)
      print "maybe there is a piece at ", x, ", ", y, "\n"
   end

end

