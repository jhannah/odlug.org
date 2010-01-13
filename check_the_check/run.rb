require 'Boards'
require 'Board'

require 'Bishop'
require 'Pawn'

board = Boards.new


# ---------
print "\n\nJay screwing around trying to learn Ruby...\n"
board = Board.new()


pawn = Pawn.new(7,3,"blah")
print "You have a ", pawn.class, " object\n"
print pawn.x, "\n"
pawn.x = 8
print pawn.x, "\n"




