# タイトル画面を表示・管理するクラスの定義
class Title
  # コンストラクタにて表示すべき画像を読み込む。
  def initialize
    @title_image = Image.load("images/title.png")
    @bgm = Sound.new("music/bgm1.wav")  # sound.mid読み込み
    @bgm.loopCount = -1 #繰り返し
    @bgm.setVolume(255)
    @bgm.play #再生
  end

  # 背景画像を表示するメソッドを定義
  def draw
    Window.draw(0, 0, @title_image)
  end

  # Sceneクラスが要求する「play」メソッドを定義
  def play
    # タイトルの画像を描画する。
    draw
    # スペースキーが押されたら
    if Input.keyPush?(K_SPACE)
      @bgm.stop
	  server = DRbObject.new_with_uri(URI)
	  server.msg_start
      # 次のフレームからは「:game」シーンに切り替えるよう、Sceneクラスに命ずる。
      Scene.set_current_scene(:game)
      Scene.current_scene.bgm
    end
  end
end
