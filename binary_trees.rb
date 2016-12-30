class BinaryTree
  def initialize
    @root = Node.new
  end

  def binary_tree(array)
    @root.value = array.shift
    current_node = @root
    array.each do |i|
      next_node = Node.new(i)
      while !next_node.parent
        if i >= current_node.value
          if current_node.right_child
          	current_node = current_node.right_child
          else
          	current_node.right_child = next_node
          	next_node.parent = current_node
          end
        else
          if current_node.left_child
          	current_node = current_node.left_child
          else
          	current_node.left_child = next_node
          	next_node.parent = current_node
          end
        end
      end
      current_node = @root   		
    end
  end

  def breadth_first_search(data)
  	next_level = []
    current_level = []
    current_level << @root
    while current_level.size != 0
      next_level = []
      current_level.each do |node|
        return "#{data} has been found in Node: #{node}. Value is #{node.value}" if node.value == data
        next_level << node.left_child if node.left_child
        next_level << node.right_child if node.right_child
      end
      current_level = next_level
    end
    return "Did not find #{data} in the tree"
  end

  def depth_first_search(data)
    node_stack = [@root]
    until node_stack.empty?
      current_node = node_stack.pop
      return "#{data} has been found in Node: #{current_node}. Value is #{current_node.value}" if current_node.value == data
      left = current_node.left_child
      right = current_node.right_child
      node_stack << right unless right.nil?
      node_stack << left unless left.nil?
      puts current_node.value
    end
    return "Did not find #{data} in the tree"
  end

  def dfs_rec(data, current_node=@root)
  	puts current_node.value
    return "#{data} has been found in Node: #{current_node}. Value is #{current_node.value}" if current_node.value == data
    dfs_rec(data, current_node.left_child) unless current_node.left_child.nil?
    dfs_rec(data, current_node.right_child) unless current_node.right_child.nil?
  end
end

class Node
  attr_accessor :value, :parent, :left_child, :right_child
  def initialize(value = nil)
  	@value = value
  	@parent = nil
  	@left_child = nil
  	@right_child = nil
  end
end

b = BinaryTree.new
array = [7, 1, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
b.binary_tree(array)
puts b.dfs_rec(67)