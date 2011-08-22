
class Shijimi < Character
	def initialize (x, y, img, size, speed = 0)
		super
		@collision = CollisionTriangle.new(self, 8, 15, 32, 15, 19, 30)
		@collision.set(@x,@y)
	end

	def set_collection(col)
		@collection = col
	end
	
	def bgm_get
		@bgm = Sound.new("music/shizimiget2.wav")
		@bgm.loopCount = 20
		@bgm.play
	end

	# 接触時に呼び出される
	def hit(obj)
		bgm_get
		Game.increment_score(obj.name,SHIJIMI_POINT)
		Game.info_change
		@collection.delete(self)
	end

end

class Shijimis
	attr_accessor :collisions

	# しじみをマップに配置する
	def initialize (number = 10)
		@Shijimis = []
		@collisions = []
		@empty_locate = []
		# 壁のない場所の位置を記憶する配列
		srand()

		# 壁のない位置を抽出
		$map.size.times do |i|
			if $map[i] == EMP
				@empty_locate << i
			end
		end
		
		# ランダム配置
        @empty_locate = @empty_locate.sort_by{|i| rand}
		number.times do |i|
			$map[@empty_locate[i]] = "SHIJIMI"
		end

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
		if $map[index] == "SHIJIMI"
			shijimi = Shijimi.new(pos['x'], pos['y'], IMG_ITEM1, BLOCK_SIZE)
			shijimi.set_collection(self)
			@collisions << shijimi.collision
			@Shijimis << shijimi
		end
	end
	
	# しじみを表示する
	def show
		@Shijimis.each do |shijimi|
			shijimi.show
		end
	end

	# しじみを消去する
	def delete(s)
		@Shijimis.delete_if{|item| item === s}
		@collisions.delete_if{|item| item === s.collision}
	end

end
