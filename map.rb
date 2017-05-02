require "./node.rb"

$w = 5
$h = 7
$map = Array.new($w){Array.new($h)}
$start_point
$end_point
$openlist = Hash.new
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
    $start_point.fscore = 0
    $openlist[$start_point] = 0

    loop do
      current = $openlist.key($openlist.values.min)
      $closedlist << current
      $openlist.delete(current)

      for neighbor in current.neighbor
        puts "i am neighbor #{neighbor.x} #{neighbor.y}"
        if(neighbor.passable == false || $closedlist.include?(neighbor))
          puts "neighbor #{neighbor.x} #{neighbor.y} is not passable or is already on the closedlist"

        elsif($openlist.include?(neighbor) == false)
          puts "i am neighbor #{neighbor.x} #{neighbor.y} and i am not on the open list yet "
          if(neighbor.x != current.x && neighbor.y != current.y)
            neighbor.gscore = 14
          end
          neighbor.hscore = calculate_h_score(neighbor.x,neighbor.y,$end_point.x,$end_point.y)
          neighbor.fscore = neighbor.gscore + neighbor.hscore
          $openlist[neighbor] = neighbor.fscore

        elsif($openlist.include?(neighbor))
          puts "i am neighbor #{neighbor.x} #{neighbor.y} and i am  on the open list"
          if(neighbor.gscore < current.gscore)
            if(neighbor.x != current.x && neighbor.y != current.y)
              neighbor.gscore = 14
            end
            neighbor.hscore = calculate_h_score(neighbor.x,neighbor.y,$end_point.x,$end_point.y)
            neighbor.fscore = neighbor.gscore + neighbor.hscore
            $openlist[neighbor] = neighbor.fscore
          end
        end
      end
      break if $closedlist.include?($end_point)
    end
end

def calculate_h_score(startx,starty,endx,endy)
  return ((startx-endx).abs + (starty-endy).abs)*10
end



create_map()
edit_map()
update_neighbors()

find_path()
print_out_map()
