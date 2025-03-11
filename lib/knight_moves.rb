require 'set'

SIZE = [8, 8]

class Position
  attr_reader :coord, :parent

  def initialize(coord, parent)
    @coord = coord
    @parent = parent
  end

  def x
    @coord[0]
  end

  def y
    @coord[1]
  end
end

def knight_moves(start, stop)
  goal = nil
  visited = Set.new
  q = [Position.new(start, nil)]

  until q.empty?
    curr = q.shift
    visited << curr.coord

    if curr.coord == stop
      goal = curr
      break
    end

    for x in [-2, -1, 1, 2]
      y_abs = 3 - x.abs

      for y in [-y_abs, y_abs]
        coord = [curr.x + x, curr.y + y]
        q.push Position.new(coord, curr) if visit?(coord, visited)
      end
    end
  end

  unless goal.nil?
    path = []
    until goal.nil?
      path.unshift goal.coord
      goal = goal.parent
    end

    puts "Your knight made it in #{path.length - 1} moves! Here's your path:"
    path.each { |x, y| puts "[#{x}, #{y}]" }

    return path
  end
  nil
end

def visit?(coord, visited)
  x, y = coord
  not visited.include?(coord) and (x >= 0 and x < SIZE[0]) and (y >= 0 and y < SIZE[1])
end
