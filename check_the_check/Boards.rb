
class Boards
   def initialize()
      print "board here\n"
      fh='sample_input.txt'
      File.open(fh).each do |line| 
         row = Array.new(line.split(''))
         row.each { |piece| print piece + "\n" }
      end
   end
end

