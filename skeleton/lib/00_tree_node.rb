require 'byebug'

class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(new_parent)
    return if @parent == new_parent
    parent_storage = @parent
    @parent = new_parent
    @parent.children << self unless @parent.nil?
    parent_storage.children.delete(self) unless parent_storage.nil?
  end

  def add_child(child)
    child.parent = self
    @children << child unless @children.include?(child)
  end

  def remove_child(child)
    raise "error" unless @children.include?(child)
    child.parent = nil
    @children.delete(child)
  end

  def dfs(target = nil)
    return self if target == self.value

    @children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target = nil)
    queue = [self]
    
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      current_node.children.each do |child|
        queue << child
      end
    end

    nil
  end

end
