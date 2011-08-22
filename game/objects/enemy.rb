

class Enemy < Character
	attr_accessor :name

	# 初期化する
	def initialize (id, x, y, size, speed)
		@server = DRbObject.new_with_uri(URI)
		@player = (id == 0) ? "player1" : "player2"
		suffix = (id == 0) ? "_r.png" : "_l.png"
		@img = IMG_DIR + @player + suffix
		super(x, y, @img, size, speed)
		@count = 0
		@id = id
		@direction = RIGHT
	end

	# 移動する
	def move
		check_border
		pos = @server.get(@id)
		@x = pos["x"]
		@y = pos["y"]
		@direction = pos["direction"]
		chg_direction
		@collision.set(@x, @y)
	end

	def back
		post = @server.get(@id)
		@x = post["x"]
		@y = post["y"]
		@direction = pos["direction"]
		@collision.set(@x, @y)
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
	
	# 方向を変更する
	def chg_direction
		if @direction != nil
			img = img_rotate(@direction)
			@image = Image.load(img)
		end
	end
end
