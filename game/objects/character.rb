
class Character
	attr_accessor :x, :y
	attr_accessor :collision
	
	# 初期化
	def initialize (x, y, img, size, speed = 0)
		@x, @y = x, y
		@image = Image.load(img)
		@collision = CollisionBox.new(self, 0, 0, size, size)
		@collision.set(@x, @y)
		@speed = speed
	end
	
	def move
		# 当たり判定
		check_border
		@x += Input.x * @speed
		@y += Input.y * @speed
		@collision.set(@x, @y)
	end
	
	def back
		@x -= Input.x * @speed
		@y -= Input.y * @speed
		@collision.set(@x, @y)
	end
	
	# 表示する
	def show
		Window.draw(@x, @y, @image)
	end
	
	# ボーダーの衝突判定を行う
	def check_border
		if @x <= BLOCK_SIZE
			@x = BLOCK_SIZE
		end
		if @x >= INWIN_WIDTH
			@x = INWIN_WIDTH
		end
		if @y <= BLOCK_SIZE
			@y = BLOCK_SIZE
		end
		if @y >= INWIN_HEIGHT
			@y = INWIN_HEIGHT
		end
	end
	
end
