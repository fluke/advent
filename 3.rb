input = 277678

# square_no = 0
# size = 1

# while input > size do
#   square_no += 1
#   size = (2 * square_no + 1) ** 2
# end

# edge = (2 * square_no + 1)

# next_corner = edge ** 2
# previous_corner = (edge - 2) ** 2

# distance_from_previous_corner = input - previous_corner

# distance_from_any_corner = (distance_from_previous_corner % (edge - 1)) + 1

# distance_from_center_of_any_edge = (distance_from_any_corner - ((edge + 1) / 2)).abs

# puts distance_from_center_of_any_edge + square_no

def neighbours(x,y)
  [[x-1, y-1], [x, y-1], [x+1, y-1], [x-1, y], [x+1, y], [x-1, y+1], [x, y+1], [x+1, y+1]]
end

def path(x, y, direction, distance)
  make_path = ->(xs, ys) { [*xs].product([*ys]) }

  directions = [
    ->() { make_path[x.upto(x+distance), y] },   # 0 = right
    ->() { make_path[x, y.upto(y+distance)] }, # 1 = up
    ->() { make_path[x.downto(x-distance), y] },  # 2 = left
    ->() { make_path[x, y.downto(y-distance)] }   # 3 = down
  ]

  puts directions[direction%4]

  directions[direction%4].call
end

def spiral
  dir = 0
  x,y = 0,0

  each_twice do |n|
    path = path(x,y, dir, n)

    puts path.to_s
      
    path.drop(1).each do |pos|
      yield pos
    end

    x,y = path.last
    dir+=1
  end
end

def each_twice
  1.step {|i| yield i; yield i;}
end

grid = Hash.new { 0 }
grid[ [0,0] ] = 1

spiral do |pos|
  sum = grid[pos] = grid.values_at(*neighbours(*pos)).reduce(&:+)

  if sum > input
    puts sum
    break
  end
end

