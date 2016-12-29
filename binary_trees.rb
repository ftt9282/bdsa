class BinaryTree
  def initialize
    @root = Node.new
  end

  def binary_tree(array)
    @root.value = array.shift
    current_node = @root
    array.each do |i|
      puts "Starting back at #{current_node.value}"
      next_node = Node.new(i)
      while !next_node.parent
      	puts "The current node is now #{current_node.value}"
        if i >= current_node.value
          if current_node.right_child
          	puts "#{i} is bigger than #{current_node.value}"
          	current_node = current_node.right_child
          else
          	current_node.right_child = next_node
          	puts "Tree leaf set to #{next_node.value}"
          	next_node.parent = current_node
          end
        else
          if current_node.left_child
          	puts "#{i} is less than #{current_node.value}"
          	current_node = current_node.left_child
          else
          	current_node.left_child = next_node
          	puts "Tree leaf set to #{next_node.value}"
          	next_node.parent = current_node
          end
        end
      end
      current_node = @root   		
    end
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