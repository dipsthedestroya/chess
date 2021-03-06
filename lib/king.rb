class King
  attr_accessor :sym, :next_moves, :pos, :moved
	attr_reader :color

  def initialize(color)
		@color = color
		@moved = false
		@next_moves = []
		@pos, @sym = color == 'black' ? [[0, 4], " \u2654 "] : [[7, 4], " \u265A "]
	end


	def all_moves(board)
		moves = []
		increments = [[1,-1], [1, 1], [-1, -1],
								  [1, 0], [-1, 0]].map do |increment_set| 
										increment_set.permutation.to_a
									end.flatten(1).uniq
		increments.each do |increment|
			next_move = [@pos[0] + increment[0], @pos[1] + increment[1]]
			moves.push(next_move) unless board.out_of_bounds?(next_move) || board.color_in_cell?(@color, next_move)
		end
		moves	
	end

	def self.origin(input, destination, pieces)
    king = pieces[:king].select{ |king| king.next_moves.include?(destination) }
		return king[0].pos unless king.empty?
  end
end