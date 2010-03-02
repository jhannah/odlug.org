require 'Rook'
require 'Knight'
require 'Bishop'
require 'Queen'
require 'King'
require 'Pawn'

class Board
   attr_accessor :xy
   def initialize(xy)
      puts "board here"
      x_pos = 1
      y_pos = 1
      @xy = xy
      xy.each do |x|
         x.each do |y| 
            # print " jay1 x ", x, " y ", y, "\n"
            if y == "." then
               # empty square
            elsif y == "K" then
               piece = King.new(  x_pos,y_pos,self,"white")
            elsif y == "k" then
               piece = King.new(  x_pos,y_pos,self,"black")
            elsif y == "P" then
               piece = Pawn.new(  x_pos,y_pos,self,"white")
            elsif y == "p" then
               piece = Pawn.new(  x_pos,y_pos,self,"black")
            elsif y == "R" then
               piece = Rook.new(  x_pos,y_pos,self,"white")
            elsif y == "B" then
               piece = Bishop.new(x_pos,y_pos,self,"white")
            else
               print "Ack! what is '", y, "'???\n"
            end
            x_pos = x_pos + 1
            if piece then
               print piece.report(), "\n"
               y = piece
               piece = ""
            end
         end
         y_pos = y_pos + 1
         x_pos = 1
      end
   end

   def king_search()
      @xy.each do |x|
         x.each do |y| 
            print "looking at ", x, ",", y, "\n"
            if y.respond_to?("king_search") then
               y.king_search()
            end
         end
      end
   end

   def piece_at(x, y)
      print "maybe there is a piece at ", x, ", ", y, "\n"
   end

end

