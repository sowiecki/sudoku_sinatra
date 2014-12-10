class Sudoku
  attr_reader :array
  def initialize(board_string)
    @array = []
    board_string.split("").each do |element|
      if (1..9).include?(element.to_i)
        @array << element.to_i
      else
        @array << 0
      end
    end
  end

  def row(index)
    @array.each_slice(9).to_a[index]
  end

  def column(index)
    column = []
    range = [0, 9, 18, 27, 36, 45, 54, 63, 72].map { |n| n += index }
    @array.each_with_index do |v, i|
      column << v if range.include?(i)
    end
    column
  end

  def square(index)
    square = []
    range = [0, 3, 6, 27, 30, 33, 54, 57, 60]
    range_index = range[index]
    3.times do
      square << @array[range_index]
      square << @array[range_index + 1]
      square << @array[range_index + 2]
      range_index += 9
    end
    square
  end

  def row_check(index, num) # Does n row contain num? where index points to n row
    self.row(index).include?(num) ? true : false
  end

  def column_check(index, num) # Does n column contain num? where index points to n column
    self.column(index).include?(num) ? true : false
  end

  def square_check(index, num) # Does n square contain num? where index points to n square
    test = (0..10).to_a
    if self.square(index).include?(num)
      return true
    else
      return false
    end
  end

  def final_check(index, num)
    voids = 0
    if self.square_check(index, @array[num]) == false
      if self.row_check(index, @array[num]) == false
        if self.column_check(index, @array[num]) == false
          voids += 1
        end
      end
    end
    if voids == 1
      return true
    else
      return false
    end
  end

  def push_num(index_to_check, index_to_push, num_to_check)
    @array = @array.map.with_index do |v, i|
      if i == index_to_push && v == 0 && self.final_check(index_to_check, num_to_check) && self.column_check(index_to_check, num_to_check)
        v = "!!!!!!!!"
      else
        v = v
      end
    end
  end

  def solve
    index_to_check = 3 # Increments up to 9
    index_to_push = 16 # Incremenets up to 80
    num_to_check = 2
    p self.final_check(index_to_check, num_to_check)
    p self.push_num(3, 16, num_to_check)
    @array.each_with_index do |v, i|
      v = self.push_num(index_to_check, i, v) if self.final_check(index_to_check, v)
    end
  end

  def board # Returns string in original pure text form (with dashes)
    string = ""
    @array.each do |element|
      if (1..9).include?(element)
        string << element.to_s
      else
        string << "-"
      end
    end
    string
  end

  def to_s # Returns a (human-readable) string representing the current state of the board
    board_str = ""
    square_index = 0
    new_line_counter = 1
    @array.each_with_index do |v, i|
      board_str << v.to_s #if (0..2).include?(i)
      if new_line_counter % 9 == 0
        board_str << "\n"
      elsif new_line_counter % 3 == 0
        board_str << " "
      else
        board_str << " "
      end
      new_line_counter += 1
    end
    if @array.include?(0) == true
      board_str
    else
      self.fancy_display
    end
  end

  def fancy_display
    print "▲▼▲ SUDOKU ▲▼▲\n"
        board_str = ""
    square_index = 0
    new_line_counter = 1
    @array.each_with_index do |v, i|
      board_str << v.to_s
      if new_line_counter % 9 == 0
        board_str << "\n"
      elsif new_line_counter % 3 == 0
        board_str << " | "
      else
        board_str << "|"
      end
      new_line_counter += 1
    end
    print board_str
    print "▼▲▼ SOLVED! ▼▲▼\n\n"
  end
end
