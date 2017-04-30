class Node
attr_accessor :passable, :score, :gscore, :kscore, :name, :x, :y, :parent, :neighbor

  def initialize
    @passable = true
    @neighbor = []
  end

end
