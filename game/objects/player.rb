
# プレイヤーを作成

class Player < Character
	attr_accessor :name

	# 初期化する
	def initialize (x, y, size, speed)
		@count = 0
		@server = DRbObject.new_with_uri(URI)
		@id = @server.add_player
		@player = (@id == 0) ? "player1" : "player2"
		suffix = (@id == 0) ? "_r.png" : "_l.png"
		@img = IMG_DIR + @player + suffix
		super(x, y, @img, size, speed)
		@server.set_init(@x, @y, @direction)
	end

	# 移動する
	def move
		super
		chg_direction
		@server.set(@id, @x, @y, @direction)
	end
	
	# 画像を回転させる
	def img_rotate (direct)
		dirname = File.dirname(@img)
		case direct
			when UP
				img = dirname + "/" + @player + "_u"
			when RIGHT
				img = dirname + "/" + @player + "_r"
			when DOWN
				img = dirname + "/" + @player + "_d"
			when LEFT
				img = dirname + "/" + @player + "_l"
		end
		@count += 1
		if @count >= 20
			img += "p"
		end
		if @count > 40
			@count = 0
		end
		return img + ".png"
	end
	
	# キーコードを取得する
	def get_key
		if Input.x == 1
			key = RIGHT
		elsif Input.x == -1
			key = LEFT
		elsif Input.y == 1
			key = DOWN
		elsif Input.y == -1
			key = UP
		else
			key = nil
		end
		return key
	end
	
	# 方向を変更する
	def chg_direction
		direction = get_key
		if direction != nil
			img = img_rotate(direction)
			@image = Image.load(img)
			@direction = direction
		end
	end
end
