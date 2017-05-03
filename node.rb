class Node
attr_accessor :passable, :fscore, :gscore, :hscore, :name, :x, :y, :parent, :neighbor

  def initialize
    @passable = true
    @neighbor = []
    @gscore = 0
  end

end
