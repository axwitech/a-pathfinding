require "./node.rb"

$w = 7
$h = 5
$map = Array.new($w){Array.new($h)}
$start_point
$end_point
$openlist = []
$closedlist = []


def create_map
  $w.times do |i|
    $h.times do |j|
      $map[i][j] = Node.new
      $map[i][j].x = i
      $map[i][j].y = j
      $map[i][j].passable = true
    end
  end
end

def edit_map
  $map[1][3].passable = false
  $map[2][3].passable = false
  $map[3][3].passable = false
end

def print_out_map
  $map.each do |node|
    node.each do |realnode|
      puts realnode.x
      puts realnode.y
      puts realnode.passable
    end
  end
end

def find_path
  
end


create_map()
edit_map()
print_out_map
