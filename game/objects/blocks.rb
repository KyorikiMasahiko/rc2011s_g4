
# ブロックを作成
class Block < Character
	
end

# ブロックのバックグランドを作成
class Blocks
	attr_accessor :collisions

	# 初期化
	def initialize
		@collisions = []
		@blocks = []
		
		max = BLOCK_W * BLOCK_H
		index = 0
		for index in 0..(max - 1)
			objs_set(index)
		end
	end
	
	# index → x, y に変換
	def index_to_pos (index)
		pos = {}
		pos['x'] = (index % BLOCK_W + 1) * BLOCK_SIZE
		pos['y'] = (index / BLOCK_W + 1) * BLOCK_SIZE
		return pos
	end
	
	# objs 配列に各ブロック要素を入れる
	def objs_set (index)
		pos = index_to_pos(index)
		if $map[index] == WALL
			block = Block.new(pos['x'], pos['y'], IMG_WALL, BLOCK_SIZE)
			@collisions << block.collision
			@blocks << block
		end
	end
	
	# 各ブロック要素を表示する
	def show
		@blocks.each do |block|
			block.show
		end
	end
end
