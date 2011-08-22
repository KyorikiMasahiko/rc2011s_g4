
class Point < Character
	def initialize (x, y, img, size, speed = 0)
		super
		@collision = CollisionCircle.new(self, 19, 19, 3)
		@collision.set(@x,@y)
	end

	def set_collection(col)
		@collection = col
	end

	# 接触時に呼び出される
	def hit(obj)
		Game.increment_score(obj.name,POINT)
		@collection.delete(self)
	end


end

class Points
	attr_accessor :collisions

	# ポイントをマップに配置する
	def initialize (number = 10)
		@Points = []
		@collisions = []

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

	def objs_set (index)
		pos = index_to_pos(index)
		if $map[index] == EMP
			point = Point.new(pos['x'], pos['y'], IMG_ITEM2, BLOCK_SIZE)
			point.set_collection(self)
			@collisions << point.collision
			@Points << point
		end
	end
	
	# ポイントを表示する
	def show
		@Points.each do |point|
			point.show
		end
	end

	# ポイントを消去する
	def delete(s)
		@Points.delete_if{|item| item === s}
		@collisions.delete_if{|item| item === s.collision}
	end

end
