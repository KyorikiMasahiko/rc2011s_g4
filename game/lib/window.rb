
# window描画を担当するクラス

class Windows

	def initialize
		# window 描画の設定
		@font = Font.new(FONT_SIZE1, FONT_TYPE1)
		@font2 = Font.new(FONT_SIZE2, FONT_TYPE2)
		@img_shijimi = Image.load(IMG_SHIJIMI)
		@img_pop = Image.load(IMG_POP)
		
		
		# しじみ情報関連
		t = Time.now
		srand(t.to_i)
		
		10.times do
			r1 = rand(10)
			r2 = rand(10)
			temp = $info[r1]
			$info[r1] = $info[r2]
			$info[r2] = temp
		end
	end

	# (x1, y1) から (x2, y2) まで線を引く
	def draw_line (x1, y1, x2, y2, c, z = 0)
		pixel = Image.new(1, 1, c)
		sx = Math.sqrt(((x1 - x2)**2) + ((y1 - y2)**2))
		angle = Math.atan2(y2 - y1, x2 - x1) / Math::PI * 180
		Window.drawEx((x2 + x1) / 2, (y2 + y1) / 2, pixel,
			:scalex=>sx, :scaley=>1,
			:centerx=>0.5, :centery=>0.5,
			:angle=>angle, :z=>z)
	end
	
	# バックグランドのボックスを作る
	def show_bg
		draw_line(20, 20, 20, 540, [255,255,255])
		draw_line(20, 540,700, 540, [255,255,255])
		draw_line(700, 540, 700, 20, [255,255,255])
		draw_line(700, 20, 20, 20, [255,255,255])
	end
	
	# しじみに関する情報を表示する。
	def show_shijimi(num)
		Window.draw(SHIJIMI_X,SHIJIMI_Y,@img_shijimi)
		Window.draw(POP_x,POP_y,@img_pop)
		# @img_pop.drawFont(INFO_x,INFO_y,$info[num],@font2,[0,0,0])
		Window.drawFont(INFO_x,INFO_y,$info[num],@font2, :color => [0,0,0])
	end
	
	def show_start
		Window.draw(0, 0, Image.load(IMG_START))
	end
	
	def show_draw
		Window.draw(0, 0, Image.load(IMG_DRAW))
	end
	
	def show_win
		Window.draw(0, 0, Image.load(IMG_WIN))
	end
	
	def show_lose
		Window.draw(0, 0, Image.load(IMG_LOSE))
	end
	
	# status を表示する
	def show_status(p1_sc,p2_sc)
		Window.drawFont(POINT1_x,POINT1_y,"You  #{p1_sc}",@font)
		Window.drawFont(POINT2_x,POINT2_y,"Enemy  #{p2_sc}",@font)
		# #{}に変数名を入れると表示できるっぽい（未確認）
	end
end
