require 'byebug'

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