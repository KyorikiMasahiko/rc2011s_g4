
# ゲームの進行管理クラス

class Game
	
	@@score = {:p1 => 0,:p2 => 0}
	
	# 初期化
	def initialize
		@blocks = Blocks.new
		@shijimis = Shijimis.new
		@points = Points.new
		@window = Windows.new
		@@number = -1
		@start_flg = false
		@start_counter = 50
		init_chars
	end
	
	def bgm
		@bgm = Sound.new("music/bgm2.wav")  # sound.wav読み込み
		@bgm.loopCount = -1 #繰り返し
		@bgm.play #再生
	end
	
	# エラー処理
	def err_quit (message)
		puts message
		exit
	end
	
	# キャラクターの初期化
	def init_chars
		player = {}
		enemy = {}
		@server = DRbObject.new_with_uri(URI)
		result = @server.current_player
		err_quit(ERROR_MAX) if result >= 2
		case result
			# Player1
			when 0
				player = $PLY1
				enemy = $PLY2
				enemy_id = 1
			# Player2
			when 1
				player = $PLY2
				enemy = $PLY1
				enemy_id = 0
			else
				puts __FILE__ + ":" , __LINE__
		end
		@player = Player.new(player['x'], player['y'], player['size'], player['speed'])
		@enemy = Enemy.new(enemy_id, enemy['x'], enemy['y'], enemy['size'], enemy['speed'])
		@player.name = :p1
		@enemy.name = :p2
	end

	# スコアの加算
	def self.increment_score(player,sc)
		@@score[player] += sc
	end
	
	# ブロックとの衝突判定
	def check_blocks
		check = Collision.check(@player.collision, @blocks.collisions)
	end

	# プレイヤーとしじみの接触判定
	def check_shijimis_player
		Collision.check(@player.collision, @shijimis.collisions)
	end
	
	# 敵としじみの接触判定
	def check_shijimis_enemy
		Collision.check(@enemy.collision, @shijimis.collisions)
	end

	# プレイヤーとポイントとの接触判定
	def check_points_player
		Collision.check(@player.collision, @points.collisions)
	end
	
	# 敵とポイントとの接触判定
	def check_points_enemy
		Collision.check(@enemy.collision, @points.collisions)
	end

	# スコアの加算
	def self.incr9ement_score(player,sc)
		@@score[player] += sc
	end

	# しじみ情報の変更
	def self.info_change
		@@number += 1
	end
	
	# ゲームの終了を判断する
	def end_check
		if @@score[:p1] + @@score[:p2] == 140
			return true
		else
			return false
		end
	end
	
	# 終了処理
	def game_end?
		if end_check
			if @@score[:p1] > @@score[:p2]
				@window.show_win
			elsif @@score[:p1] < @@score[:p2]
				@window.show_lose
			else
				@window.show_draw
			end
		end
	end

	# メインロジック
	def play
		if @server.is_sync
			@enemy.move
			@player.move
			@start_flg = true
		end
		if check_blocks
			@player.back
		end
		@player.show
		@enemy.show
		@blocks.show
		@window.show_bg
		@window.show_status(@@score[:p1],@@score[:p2])
		@window.show_shijimi(@@number)
		@shijimis.show
		@points.show
		
		if @start_flg
			@start_counter += 1
			@window.show_start if @start_counter <= 80
		end
		
		# 接触判定
		check_shijimis_player
		check_shijimis_enemy
		check_points_player
		check_points_enemy
		
		#ゲーム終了判定
		game_end?
	end
end


