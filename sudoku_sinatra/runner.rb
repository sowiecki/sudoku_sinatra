require_relative 'sudoku'

# The sudoku puzzles that your program will solve can be found
# in the sudoku_puzzles.txt file.
#
# Currently, Line 16 defines the variable board_string to equal
# the first puzzle (i.e., the first line in the .txt file).
# After your program can solve this first puzzle, edit
# the code below, so that the program tries to solve
# all of the puzzles.
#
# Remember, the file has newline characters at the end of each line,
# so we call String#chomp to remove them.


board_string = File.readlines('puzzles.txt').first.chomp

game = Sudoku.new(board_string)
#p game.board
game.solve
#game.push_num(3, 16, 2)
puts game
# p "Row model works: #{[6, 0, 0, 3, 0, 8, 9, 0, 0] == game.row(8)}"
# p "Column model works: #{[0, 5, 9, 6, 0, 0, 0, 1, 0] == game.column(8)}"
# p "Square model works: #{[0, 3, 0, 5, 0, 1, 9, 0, 0] == game.square(8)}"
# p "#{game.square(8)} should be #{[0, 3, 0, 5, 0, 1, 9, 0, 0]}"
# p "-----"counter += 1
# p game.square_check(8, 1)
#p game.final_che#ck(16, 2)
