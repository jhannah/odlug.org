class ChessBoard
  # 0 for no check, 1 for white is checked, 2 for black is checked
  attr_accessor :is_there_a_check

  def initialize(board)
    # Saves board and converts to 2D array instance variable @board
    pieces_count = 0
    lines_count = 0
    line_of_pieces = []
    @board = []
    
    
    board.each do |piece|
      if pieces_count % 8 != 0 || pieces_count == 0
        line_of_pieces << piece
        pieces_count += 1
      elsif pieces_count % 8 == 0 && pieces_count > 0
        @board << line_of_pieces
        lines_count += 1
        line_of_pieces = []
        line_of_pieces << piece
        pieces_count += 1
      end  
    end
    # Push the last line
    @board << line_of_pieces
    
    self.check_the_check    
  end
  
  def find_attacks(color)
    # Contains black and white attacks
    @fields_with_attacks = Array.new(8).map!{Array.new(8,0)}
    
    # Column
    x = 0
    # Row
    y = 0 
    
    if(color == "white")
      pieces_regex = /[A-Z]/
      # White pawns move up
      pawn_move = -1
    elsif(color == "black")
      pieces_regex = /[a-z]/
      # Black pawns move down
      pawn_move = 1
    end
        
    @board.each do |line|
      line.each do |field|
        
        unless field == '.'
          if field.match(pieces_regex) != nil
              # If the chess piece is a p = pawn.
              if field.downcase == "p"                
                #Left, top
                if(x - 1 >= 0 && y - 1 >= 0) 
                  @fields_with_attacks[y + pawn_move][x - 1] = 1
                end
                #Right, top
                if(x + 1 < 8 && y - 1 >= 0) 
                  @fields_with_attacks[y + pawn_move][x + 1] = 1
                end
                
              # If the chess piece is a k = king.
              elsif field.downcase == "k"
                if(x - 1 >= 0) 
                  #Left
                  @fields_with_attacks[y][x - 1] = 1
                  if(y - 1 >= 0) 
                    #Top
                    @fields_with_attacks[y - 1][x] = 1
                    #Top left
                    @fields_with_attacks[y - 1][x - 1] = 1  
                  end
                  if(y + 1 < 8)
                    #Bottom
                    @fields_with_attacks[y + 1][x] = 1
                    #Bottom left
                    @fields_with_attacks[y + 1][x - 1] = 1
                  end
                end
                if(x == 0 || x == 7)
                  if(y - 1 >= 0) 
                    #Top
                    @fields_with_attacks[y - 1][x] = 1
                  end
                  if(y + 1 < 8)
                    #Bottom
                    @fields_with_attacks[y + 1][x] = 1
                  end
                end
                
                if(x + 1 < 8)
                   #Right
                   @fields_with_attacks[y][x + 1] = 1
                   if(y - 1 > 0) 
                     #Top right
                     @fields_with_attacks[y - 1][x + 1] = 1  
                   end
                   if(y + 1 < 8)
                     #Bottom left
                     @fields_with_attacks[y + 1][x + 1] = 1
                   end
                end
              # If the piece is a n = knight

              # Attacking fields:
              #[0, 0, 0, 0, 0, 0, 0, 0]
              #[0, 0, 0, 0, 0, 0, 0, 0]
              #[0, 0, 1, 0, 1, 0, 0, 0]
              #[0, 1, 0, 0, 0, 1, 0, 0]
              #[0, 0, 0, N, 0, 0, 0, 0]
              #[0, 1, 0, 0, 0, 1, 0, 0]
              #[0, 0, 1, 0, 1, 0, 0, 0]
              #[0, 0, 0, 0, 0, 0, 0, 0]        
      
              elsif field.downcase == "n"
                # Left jump
                if(x - 2 >= 0)
                  if(y - 1 >= 0)
                     # Left top jump
                     @fields_with_attacks[y - 1][x - 2] = 1
                  end
                  if(y + 1 < 8)
                    # Left bottom jump
                     @fields_with_attacks[y + 1][x - 2] = 1
                   end
                end
                # Right jump
                if(x + 2 < 8)
                  if(y - 1 >= 0)
                    # Right top jump 
                    @fields_with_attacks[y - 1][x + 2] = 1
                  end
                  if(y + 1 < 8)
                    # Right bottom jump
                     @fields_with_attacks[y + 1][x + 2] = 1
                  end
                end
                # Top jump
                if(y - 2 >= 0)
                  if(x - 1 >= 0)
                    # Top left jump
                    @fields_with_attacks[y - 2][x - 1] = 1
                  end
                  if(x + 1 < 8)
                    # Top right jump
                    @fields_with_attacks[y - 2][x + 1] = 1
                  end
                end
                # Bottom jump
                if(y + 2 < 8)
                    if(x - 1 >= 0)
                      # Bottom left jump
                      @fields_with_attacks[y + 2][x - 1] = 1
                    end
                    if(x + 1 < 8)
                      # Bottom right jump
                      @fields_with_attacks[y + 2][x + 1] = 1
                    end
                end
                    
              # If the chess piece is a b = bishop. 
              
              # Attacking fields:
              #[0, 0, 0, 0, 0, 0, 0, 1]
              #[1, 0, 0, 0, 0, 0, 1, 0]
              #[0, 1, 0, 0, 0, 1, 0, 0]
              #[0, 0, 1, 0, 1, 0, 0, 0]
              #[0, 0, 0, B, 0, 0, 0, 0]
              #[0, 0, 1, 0, 1, 0, 0, 0]
              #[0, 1, 0, 0, 0, 1, 0, 0]
              #[1, 0, 0, 0, 0, 0, 1, 0]
              
              elsif field.downcase == "b"
                x_attack = x
                y_attack = y
                blocking_attack = 0

                #Top right branch
                while (x_attack + 1) < 8 && (y_attack - 1) >= 0 do  
                  x_attack += 1
                  y_attack -= 1

                  if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                    if blocking_attack == 0
                      @fields_with_attacks[y_attack][x_attack] = 1
                    end
                    blocking_attack = 1
                  else
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                end
                # -- resetting position --
                x_attack = x
                y_attack = y
                blocking_attack = 0
                # -- --

                #Bottom right branch
                while (x_attack + 1) < 8 && (y_attack + 1) < 8 do
                  x_attack += 1
                  y_attack += 1
                  if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                    if blocking_attack == 0
                      @fields_with_attacks[y_attack][x_attack] = 1
                    end
                    blocking_attack = 1
                  else
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                end

                # -- resetting position --
                x_attack = x
                y_attack = y
                blocking_attack = 0
                # -- --

                #Top left branch
                while (x_attack - 1 >= 0) && (y_attack - 1) >= 0 do
                  x_attack -= 1
                  y_attack -= 1
                  if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                    if blocking_attack == 0
                      @fields_with_attacks[y_attack][x_attack] = 1
                    end
                    blocking_attack = 1
                  else
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                end

                # -- resetting position --
                x_attack = x
                y_attack = y
                blocking_attack = 0
                # -- --

                #Bottom left branch  
                while (x_attack - 1 >= 0) && (y_attack + 1) < 8 do
                  x_attack -= 1
                  y_attack += 1
                  if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                    if blocking_attack == 0
                      @fields_with_attacks[y_attack][x_attack] = 1
                    end
                    blocking_attack = 1
                  else
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                end
                 
            # If the piece is a r = rook
            
            # Attacking fields:
            #[0, 0, 0, 1, 0, 0, 0, 0]
            #[0, 0, 0, 1, 0, 0, 0, 0]
            #[0, 0, 0, 1, 0, 0, 0, 0]
            #[0, 0, 0, 1, 0, 0, 0, 0]
            #[1, 1, 1, 0, 1, 1, 1, 1]
            #[0, 0, 0, 1, 0, 0, 0, 0]
            #[0, 0, 0, 1, 0, 0, 0, 0]
            #[0, 0, 0, 1, 0, 0, 0, 0]
            
            elsif field.downcase == "r"
              x_attack = x
              y_attack = y
              blocking_attack = 0
              
              # Left
              while(x_attack - 1 >= 0) do
                x_attack -= 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Right
              while(x_attack + 1 < 8) do
                x_attack += 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Up
              while(y_attack - 1 >= 0) do
                y_attack -= 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Down
              
              while(y_attack + 1 < 8) do
                y_attack += 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
            # If the piece is a q = queen.
            elsif field.downcase == "q"
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Left
              while(x_attack - 1 >= 0) do
                x_attack -= 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Right
              while(x_attack + 1 < 8) do
                x_attack += 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Up
              while(y_attack - 1 >= 0) do
                y_attack -= 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              # Down
              
              while(y_attack + 1 < 8) do
                y_attack += 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --
              
              #Top right branch
              while (x_attack + 1) < 8 && (y_attack - 1) >= 0 do  
                x_attack += 1
                y_attack -= 1

                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --

              #Bottom right branch
              while (x_attack + 1) < 8 && (y_attack + 1) < 8 do
                x_attack += 1
                y_attack += 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end

              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --

              #Top left branch
              while (x_attack - 1 >= 0) && (y_attack - 1) >= 0 do
                x_attack -= 1
                y_attack -= 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end

              # -- resetting position --
              x_attack = x
              y_attack = y
              blocking_attack = 0
              # -- --

              #Bottom left branch  
              while (x_attack - 1 >= 0) && (y_attack + 1) < 8 do
                x_attack -= 1
                y_attack += 1
                if @board[y_attack][x_attack].match(/\w/) != nil || blocking_attack == 1
                  if blocking_attack == 0
                    @fields_with_attacks[y_attack][x_attack] = 1
                  end
                  blocking_attack = 1
                else
                  @fields_with_attacks[y_attack][x_attack] = 1
                end
              end
              
            end
          end     
        end

        x += 1
      end
      y += 1
      x = 0
    end
    
    # Save fields where either color is attacking to the correct instance variable
    if(color == "white")
      @fields_where_white_attacks = @fields_with_attacks
    elsif(color == "black")
      @fields_where_black_attacks = @fields_with_attacks
    end
    
  end
  
  # Checks if there is a king of the oposite color present on a field with a known attack.  
  def find_king_in_check
    x = 0
    y = 0
    
    @fields_where_white_attacks.each do |line|
      line.each do |field|
        if field == 1 && @board[y][x] == "k"
          @check = "Black king is checked at #{x},#{y}."
        end       
        x += 1
      end
      x = 0
      y += 1
    end
    
    x = 0
    y = 0
    
    @fields_where_black_attacks.each do |line|
      line.each do |field|
        if field == 1 && @board[y][x] == "K"
          @check = "White king is checked at #{x},#{y}."
        end       
        x += 1
      end
      x = 0
      y += 1
    end
    
  end
    
# The magic, checking if white or black player is checked.  
  def check_the_check
    self.find_attacks("white")
    self.find_attacks("black")
    self.find_king_in_check
  end
  
  # Debug printing
  def print_board(board)
    board_display = ""
    board.each do |element|
       board_display << element.to_s
       board_display << "\n"   
    end
    return board_display
  end
  
# Status of check on the board. Prints out boards and attacked fields. Also returns check the check results.
def status
  if @check != nil
    check_status = %q{There is a check on the board:
} + @check
    else
      check_status = "There is no check on the board."
    end
    

    status = %q{The chess board and pieces:
} + print_board(@board) + %q{ 
Fields where white is attacking:
} + print_board(@fields_where_white_attacks) + %q{ 
Fields where black is attacking: 
} + print_board(@fields_where_black_attacks) + %q{
} + check_status + %q{

-- Next board --

}
  end
end

class ChessBoardParser
  attr_accessor :boards
  
  def initialize(lines_of_text)
    # The array that holds the board before a ChessBoard object
    board_array = []
    # The ChessBoard objects array
    @boards = []
    
    lines_of_text.each do |line| 
    # If the line is not empty, split it to single characters and add it to board array
      unless line.empty?
           
        line.chomp.split(//).each do |piece|
          board_array << piece
        end

        # Check if all lines are 8 characters long 
        unless board_array.length % 8 == 0 
          raise ArgumentError, "Some input lines are not of correct length."
        end            
        
        
        # Check for correct chess piece notation and number
        line.chomp.split(//).each do |piece|  
          unless piece.downcase == 'k' || piece.downcase == 'q' || piece.downcase == 'n' || piece.downcase == 'b' || piece.downcase == 'r' || piece.downcase != 'p'  || piece.downcase != '.'
            raise ArgumentError, "Pieces are not marked correctly (they have to be in algebraic notation). What is \"#{piece}\"?"
          end
        end

        # Every 64th character means a new chess board.
        if board_array.length == 64
          @boards << ChessBoard.new(board_array)
          board_array = []
        end
      end
    end
  end
end


# Load the sample input. Lines 8 characters long, terminated with \n. 8 lines in a row
# and a single \n indicates new board.

lines_of_text = File.readlines("sample_input.txt")
parser = ChessBoardParser.new(lines_of_text)

#Status report for all inputed boards
parser.boards.each do |chess_board|
 puts chess_board.status
end
    