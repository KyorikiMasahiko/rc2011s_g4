
# 設定ファイルの読み込み
BASE_DIR = Dir.pwd
require BASE_DIR + "/lib/config.rb"

# ベースとなるゲーム管理クラス, タイトルクラスを生成
game = Game.new
title = Title.new

# オープニング
Scene.add_scene(title, :title)

# ゲーム開始
Scene.add_scene(game, :game)

Scene.set_current_scene(:title)

Window.loop do
	break if Input.keyPush?(K_ESCAPE)
	
	# ユーザーの入力待ち
	Scene.play_scene
end

server = DRbObject.new_with_uri(URI)
server.clear
