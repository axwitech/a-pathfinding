require "./node.rb"

$w = 7
$h = 5
$map = Array.new($w){Array.new($h)}
$start_point
$end_point
$openlist = []
$closedlist = []


def create_map
  $w.times do |x|
    $h.times do |y|
      $map[x][y] = Node.new
      $map[x][y].x = x
      $map[x][y].y = y
    end
  end
end
#node.neighbor.push($map[row_index-1][col_index])
def update_neighbors
  $w.times do |x|
    $h.times do |y|
      if x > 0
        $map[x][y].neighbor.push($map[x-1][y])
      end

      if x < $w-1
        $map[x][y].neighbor.push($map[x+1][y])
      end

      if y > 0
        $map[x][y].neighbor.push($map[x][y-1])
      end

      if y < $h-1
        $map[x][y].neighbor.push($map[x][y+1])
      end

      if x > 0 && y > 0
        $map[x][y].neighbor.push($map[x-1][y-1])
      end

      if x > 0 && y < $h-1
        $map[x][y].neighbor.push($map[x-1][y+1])
      end

      if x < $w-1 && y > 0
        $map[x][y].neighbor.push($map[x+1][y-1])
      end

      if x < $w-1 && y < $h-1
        $map[x][y].neighbor.push($map[x+1][y+1])
      end
    end
  end
end


def edit_map
  $map[1][3].passable = false
  $map[2][3].passable = false
  $map[3][3].passable = false
end

def print_out_map
  $map.each do |row|
    row.each do |node|
      print "|#{node.x} #{node.y} "
      if node.passable
        print "."
      else
        print "#"
      end
      #puts node.passable
    end
    puts " "
  end
end

def find_path(star_point,end_point)
    $start_point = map[2][1]
    $end_point = map[2][5]
    $openlist << $start_point
end


create_map()
edit_map()
update_neighbors()
print_out_map
puts $map[1][1].neighbor
