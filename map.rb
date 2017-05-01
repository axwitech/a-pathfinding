require "./node.rb"

$w = 5
$h = 7
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
    end
    puts " "
  end
end

def find_path()
    $start_point = $map[2][1]
    $end_point = $map[2][5]
    $openlist << $start_point
      for node in $openlist
        puts "i am node #{node.x} #{node.y}"
        for neighbor in node.neighbor
          neighbor.hscore = calculate_h_score(neighbor.x,neighbor.y,$end_point.x,$end_point.y)
          if(node.x != neighbor.x && node.y != neighbor.y)
            neighbor.gscore = 14
          end
          neighbor.fscore = neighbor.gscore + neighbor.hscore
          neighbor.parent = node
          puts "i am neighbor #{neighbor.x} #{neighbor.y}"
          puts "my gscore is #{neighbor.gscore}"
          puts "my hscore is #{neighbor.hscore}"
          puts "my fscore is #{neighbor.fscore}"
          puts "my parent is #{neighbor.parent.x} #{neighbor.parent.y}"
          if neighbor.passable
            $closedlist << node
          end
        end
      end
end

def calculate_h_score(startx,starty,endx,endy)
  return ((startx-endx).abs + (starty-endy).abs)*10
end



create_map()
edit_map()
update_neighbors()
print_out_map()
find_path()
puts calculate_h_score(2,2,2,4)
