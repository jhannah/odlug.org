require 'Board'

class Boards
   def initialize()

      demo_xy = [ 
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil],
         [nil,nil,nil,nil,nil,nil,nil,nil]
      ]

      xy = Array.new

      puts "boards here"
      fh='sample_input.txt'
      File.open(fh).each do |line| 
         row = Array.new(line.chomp.split(''))

         #row.each { |piece| print piece + " " }
         #print "\n"
         #puts row.count
 
         # TODO: instantiate a Rook object (etc.) for each xy coordinate that
         # has a piece on it.

         if row.count == 0 then
            board = Board.new(xy)
         else 
            xy.push(row)
         end 
      end
      if xy.count then
         board = Board.new(xy)
      end
   end
end

