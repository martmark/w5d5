require_relative "00_tree_node.rb"

class KnightPathFinder
    attr_reader :considered_positions, :pos

    def self.valid_moves(pos)
        valids = []
        x, y = pos
      
        valids << [x + 2, y + 1]
        valids << [x + 2, y - 1]
        valids << [x - 2, y + 1]
        valids << [x - 2, y - 1]
        valids << [x + 1, y + 2]
        valids << [x + 1, y - 2]
        valids << [x - 1, y + 2]
        valids << [x - 1, y + 2]

        valids.reject do |pair|
            row = pair[0]
            col = pair[1]
            !(0..8).include?(row) || !(0..8).include?(col)
        end
    end

    def initialize(pos)
        @pos = pos
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]

    end

    def new_move_positions(pos)
        valids = KnightPathFinder.valid_moves(pos)
        unconsidered = valids.reject { |move| self.considered_positions.include?(move) }
        @considered_positions += unconsidered
        unconsidered
    end

    def build_move_tree 
        self.root_node = PolyTreeNode.new(pos)
        nodes = [@root_node]

        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end 
    
  
end