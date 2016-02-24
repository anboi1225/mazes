#require "colorize"
#coding: UTF-8
class Maze
  attr_accessor :n, :m, :maze
  def initialize(n, m)
    @n = n
    @m = m
    @maze = []
  end

  def load(maze)
    if maze.length != @m * @n
      puts "Please input a valid length string."
      return false
    end

    maze.each_char do |i|
      if i != "0" && i != "1"
        puts "Please input a string consists of only '0' and '1'."
        return false
      end
    end

    @maze_string = maze

    (0..@m - 1).each do |i|
      @maze[i] = maze[i * @m..(i + 1) * @m - 1]
    end
  end

# "■" for "wall", "O" for "space"
  def display()
    @maze.each do |i|
      i.each_char do |j|
        if j == "1"
          print "■"
        else
          print "O"
        end
      end
      print "\n"
    end
  end

# "S" for "Start Position", "E" for "End Position",
# "↑ → ↓ ←" for path, "X" for the path have tried but don't connect with end position
  def solve(begX, begY, endX, endY)
    if(!(begX.is_a? Integer) || !(begY.is_a? Integer) || !(endX.is_a? Integer) || !(endY.is_a? Integer))
      puts "Please input an integer as the coordinates."
      return false
    end
    if(begX < 0 || begX >= @n || begY < 0 || begY >= @m || endX < 0 || endX >= @n || endY < 0 || endY >= @m)
      puts "Error: beg/end coordinate out of the maze range."
      return false
    end
    if(@maze[begY][begX] == "1" || @maze[endY][endX] == "1")
      puts "Please input a valid beg/end coordinate."
      return false
    end

    maze_temp = []
    (0..@m - 1).each do |i|
      maze_temp[i] = @maze_string[i * @m..(i + 1) * @m - 1]
    end
    maze_temp[begY][begX] = "S"
    #maze_temp[endY][endX] = "E"
    #maze_temp = @maze

    find = false
    while(!find)
      #maze_temp[begY][begX] = "2"
      if(begX == endX && begY == endY)
        puts "Find a valid path!"
        maze_temp[begY][begX] = "E"
        return maze_temp
      end

      if(maze_temp[begY - 1][begX] == "0")
        begY -= 1
        maze_temp[begY][begX] = "U"
      elsif(maze_temp[begY][begX + 1] == "0")
        begX += 1
        maze_temp[begY][begX] = "R"
      elsif(maze_temp[begY + 1][begX] == "0")
        begY += 1
        maze_temp[begY][begX] = "D"
      elsif(maze_temp[begY][begX - 1] == "0")
        begX -= 1
        maze_temp[begY][begX] = "L"
      elsif(maze_temp[begY][begX] == "U")
        maze_temp[begY][begX] = "3"
        begY += 1
      elsif(maze_temp[begY][begX] == "R")
        maze_temp[begY][begX] = "3"
        begX -= 1
      elsif(maze_temp[begY][begX] == "D")
        maze_temp[begY][begX] = "3"
        begY -= 1
      elsif(maze_temp[begY][begX] == "L")
        maze_temp[begY][begX] = "3"
        begX += 1
      else
        puts "Can not find a path."
        return false
      end
    end
  end

def trace(begX, begY, endX, endY)
  maze_temp = solve(begX, begY, endX, endY)
  maze_temp.each do |i|
    i.each_char do |j|
      if(j == "1")
        print "■"

      elsif(j == "3")
        print "X"
#=begin
      elsif(j == "U")
        print "↑"
      elsif(j == "R")
        print "→"
      elsif(j == "D")
        print "↓"
      elsif(j == "L")
        print "←"
#=end
      else
        print j
      end
    end
    print "\n"
  end
end

end

t = Maze.new(9, 9)
t.load("111111111100010001111010101100010101101110101100000101111011101100000101111111111")
t.display
t.solve(1, 1, 7, 7)
t.trace(1, 1, 7, 7)
t.trace(1, 1, 1, 7)
