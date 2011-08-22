# シーン（場面）管理用クラス
class Scene
  # シーンの一覧を確保するハッシュを初期化する。
  # クラス変数を使っている点がポイント。
  # ここに、本ゲーム中に登場する全てのシーンオブジェクトが格納される。
  @@scenes = {}

  # 現在実行すべきシーン名を保持する変数
  @@current_scene_name = nil

  # シーン一覧にシーンを追加するクラスメソッド
  # * scene_obj:  シーンの実体となるオブジェクト。必ず「play」メソッドを持つことが期待される。
  # * scene_name: シーン名を表すシンボル。文字列で指定しても良い。
  def self.add_scene(scene_obj, scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end


  # 実行するシーンを変更するクラスメソッド
  # 本メソッドにシーン名を渡すことで、描画されるシーンを切り替えることが出来る。
  def self.set_current_scene(scene_name)
    @@current_scene_name = scene_name.to_sym
  end


  # 現在のシーンを描画するクラスメソッド
  # シーンの実体となるオブジェクトには、必ず「play」メソッドを持つことが保証されているので、
  # 現在の描画対象シーン（の実体オブジェクト）に対して「play」メソッドを呼び出し、シーンを
  # 描画する。
  def self.play_scene
   @@scenes[@@current_scene_name].play
  end
  
  def self.current_scene
    return @@scenes[@@current_scene_name]
  end
end
