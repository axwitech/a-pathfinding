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
  $start_point = $map[0][0]
  $end_point = $map[4][4]

  $openlist[$start_point] = 0

  while $openlist.length > 0 do
    current = $openlist.key($openlist.values.min)
    if(current == $end_point)
      break;
    end
    $closedlist << current
    $openlist.delete(current)
    for neighbor in current.neighbor
      if($closedlist.include?(neighbor) || neighbor.passable == false)
        puts "neighbor #{neighbor.x} #{neighbor.y} is on closed list or is not walkable"
      else
        if($openlist.include?(neighbor) == false)
          puts "neighbor #{neighbor.x} #{neighbor.y} is not on the open list, adding it!"
          neighbor.parent = current
          neighbor.gscore = neighbor.parent.gscore + 10
          if(neighbor.x != current.x && neighbor.y != current.y)
            neighbor.gscore = neighbor.parent.gscore + 14
          end
         neighbor.hscore = calculate_h_score(neighbor.x,neighbor.y,$end_point.x,$end_point.y)
         neighbor.fscore = neighbor.gscore + neighbor.hscore
         $openlist[neighbor] = neighbor.fscore
         puts "my hscore is #{neighbor.hscore}"
         puts "my gscore is #{neighbor.gscore}"
         puts "my fscore is #{neighbor.fscore}"

        elsif($openlist.include?(neighbor))
          puts "neighbor #{neighbor.x} #{neighbor.y} is on the open list"
          tempG = neighbor.parent.gscore + 10
          if(neighbor.x != current.x && neighbor.y != current.y)
            tempG = neighbor.parent.gscore + 14
          end
          puts "temp #{tempG}"
          puts "neighbor parent g score #{neighbor.parent.gscore}"
          if(tempG < neighbor.gscore)
            neighbor.gscore = tempG
            neighbor.hscore = calculate_h_score(neighbor.x,neighbor.y,$end_point.x,$end_point.y)
            neighbor.fscore = neighbor.gscore + neighbor.hscore
            $openlist[neighbor] = neighbor.fscore
            puts "tempG was #{tempG}"
            puts "my hscore is #{neighbor.hscore}"
            puts "my gscore is #{neighbor.gscore}"
            puts "my fscore is #{neighbor.fscore}"
          end
          end
          end
        end
    end
end

def calculate_h_score(startx,starty,endx,endy)
  return ((startx-endx).abs + (starty-endy).abs)*10
end

def path()
  parent = $map[4][4].parent
  parent2 = parent.parent
  parent3 = parent2.parent
  parent4 = parent3.parent
  parent5 = parent4.parent

  puts "parent #{parent.x} #{parent.y}"
  puts "parent2 #{parent2.x} #{parent2.y}"
  puts "parent3 #{parent3.x} #{parent3.y}"
  puts "parent4 #{parent4.x} #{parent4.y}"

end
create_map()
edit_map()
update_neighbors()

find_path()
print_out_map()
path
