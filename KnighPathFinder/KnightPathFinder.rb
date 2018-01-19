require 'byebug'
class KnightPathFinder
  attr_reader :s_pos 
  attr_accessor :v_pos
  
  def initialize(start_pos)
    @s_pos = start_pos
    @kpf = PolyTreeNode.new(start_pos)
    @v_pos = [start_pos]
  end
  
  def new_moves_pos(c_pos)
    arr = []
    
    arr << [c_pos[0] + 1, c_pos[1] + 2]
    arr << [c_pos[0] - 1, c_pos[1] + 2]
    arr << [c_pos[0] + 1, c_pos[1] - 2]
    arr << [c_pos[0] - 1, c_pos[1] - 2]
    arr << [c_pos[0] + 2, c_pos[1] + 1]
    arr << [c_pos[0] - 2, c_pos[1] + 1]
    arr << [c_pos[0] + 2, c_pos[1] - 1]
    arr << [c_pos[0] - 2, c_pos[1] - 1]
    
    arr.select! {|loc| self.valid_move?(loc)}
    arr.each{|x| v_pos << x}
    return arr
  end
  
  def valid_move?(loc)
    loc.each do |coord|
      return false if coord > 7 || coord < 0
    end 
    return false if @v_pos.include?(loc)
    true 
  end
  
  def build_move_tree(c_pos)
    p_moves = new_moves_pos(c_pos.value)
    return nil if p_moves.nil?
    p_moves.each do |move|
      add_move = PolyTreeNode.new(move)
      add_move.parent = c_pos
      c_pos.add_child(add_move)
    end 
  end 
  
  def find_path(e_pos)
    queue = [@kpf]
    until false
      node = queue.shift

      if node.value == e_pos
        break
      end
      
      build_move_tree(node)
      
      node.children.each do |child|
        queue << child
      end
      
    end
    
    trace_path_back(node)

  end 
  
  def trace_path_back(end_node) 
    path_node = [end_node]
    
    until path_node[0].value == @s_pos
      path_node.unshift(path_node[0].parent)
    end
    path_node.map!(&:value)
    print path_node
  end
end













































































class PolyTreeNode
  attr_accessor :parent, :children, :value
  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  def parent=(dad)
    unless @parent.nil?
      @parent.children.delete(self)
    end
    if dad == nil
      @parent = nil
      return
    end
    unless dad.children.include?(self)
      @parent = dad
      dad.children << self
    end
  end
  
  def add_child(kiddo)
    unless children.include?(kiddo)
      children << kiddo
      kiddo.parent = self
    end 
    
  end
  
  def remove_child(orphan)
    if children.include?(orphan)
      orphan.parent = nil
      children.delete(orphan)
    else
      raise "You don't don't have a child to orphan. maybe in 9 months."
    end 
    
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    #debugger
    @children.each do |child|
      #debugger
      result = child.dfs(target_value)
      if result != nil
        return result
      end
    end 
    nil 
  end
  
  def bfs(target)
    arr = [self]
    
    until arr.empty?
      node = arr.shift
      node.children.each {|k| arr << k}
      return node if node.value == target 
    end
    nil
  end
end

kpf = KnightPathFinder.new([0, 0])
puts kpf.find_path([3, 3])
