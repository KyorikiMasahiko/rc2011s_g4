# サーバー側のスクリプト

require 'drb/drb'

class GameServer
	
	# プレイヤーの初期化
	def initialize
		@players = []
		@player_num = 0
		@start_flg = 0
	end
	
	# プレイヤーの追加
	def add_player
		return false if @player_num >= 2
		@player_num += 1
		return @player_num - 1
	end

	def current_player
		return @player_num
	end
	
	# 情報を取得する
	def get (id)
		return @players[id]
	end
	

	def is_sync
		if @start_flg <= 1
			return false
		elsif @start_flg == 2
			return true
		end
	end
	
	# 情報を保存する
	def set (id, x, y, direction)
		@players[id] = {"x" => x, "y" => y, "direction" => direction}
	end

	def set_init (x, y, direction)
		@players << {"x" => x, "y" => y, "direction" => 0}
	end
	
	# プレイヤーを削除, メンバ変数を初期化
	def clear
		@players.clear
		@player_num = 0
		@start_flg = 0
	end
	
	def msg_start
		@start_flg += 1
	end
	
	# デバック用の変数を用意
	def dump
		p @players, @player_num
	end
end

# ネットワークアドレス

URI = 'druby://127.0.0.1:3000'

DRb.start_service URI, GameServer.new

DRb.thread.join
