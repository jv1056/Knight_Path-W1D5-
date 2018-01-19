require 'byebug'

class PolyTreeNode
  attr_reader :parent, :children, :value
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
    debugger if dad.nil?
    unless dad.children.include?(self)
      @parent = dad
      dad.children << self
    end
  end
  
end