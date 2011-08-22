# encoding: Shift_JIS
# 設定ファイル

# ライブラリの読み込み
require "dxruby"
require "dxrubyex"
require "drb/drb"

# 各種ディレクトリのパスを設定
LIB_DIR = BASE_DIR + '/lib/'
IMG_DIR = BASE_DIR + '/images/'
OBJ_DIR = BASE_DIR + '/objects/'

# 必要ファイルの読み込み
require LIB_DIR + "game.rb"
require LIB_DIR + "window.rb"
require LIB_DIR + "scene.rb"
require LIB_DIR + "title.rb"
require OBJ_DIR + "character.rb"
require OBJ_DIR + "blocks.rb"
require OBJ_DIR + "player.rb"
require OBJ_DIR + "shijimi.rb"
require OBJ_DIR + "point.rb"
require OBJ_DIR + "enemy.rb"

# ウィンドウ関係
WIN_WIDTH = 720
WIN_HEIGHT = 660

# 内部に表示するウインドウ
INWIN_WIDTH = 650
INWIN_HEIGHT = 490

# window の初期化
Window.caption = "S H I M A N E M A N"
Window.width = WIN_WIDTH
Window.height = WIN_HEIGHT

# マップ関係
EMP = 0
WALL = 1
PLY1 = 2
PLY2 = 3
SHIJIMI = 4
BLOCK_W = 16
BLOCK_H = 12
BLOCK_SIZE = 40
SHIJIMI_X = 21
SHIJIMI_Y = 593
POP_x = 62
POP_y = 590

$map = [
2, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0,
0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0,
1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0,
0, 1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0,
0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0,
0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1, 0,
0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1,
0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0,
0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 3,
]

# 画像関係
IMG_WALL = IMG_DIR + "wall.png"
IMG_EMP = IMG_DIR + "background.png"
IMG_PLY1 = IMG_DIR + "player1_r.png"
IMG_PLY2 = IMG_DIR + "player2_l.png"
IMG_SHIJIMI = IMG_DIR + "joshi.png"
IMG_ITEM1 = IMG_DIR + "shijimi.png"
IMG_ITEM2 = IMG_DIR + "point.png"
IMG_TITLE = IMG_DIR + "title.png"
IMG_POP = IMG_DIR + "pop.png"
IMG_WIN = IMG_DIR + "win.png"
IMG_LOSE = IMG_DIR + "lose.png"
IMG_DRAW = IMG_DIR + "draw.png"
IMG_START = IMG_DIR + "start.png"

# フォント関係
FONT_SIZE1 = 18
FONT_SIZE2 = 22
FONT_TYPE1 = "Calibri"
FONT_TYPE2 = "メイリオ"
POINT1_x = 20
POINT1_y = 550
POINT2_x = 370
POINT2_y = 550
INFO_x = 80
INFO_y = 601

# 得点関係
POINT = 1
SHIJIMI_POINT = 3

#ワンポイントメッセージ
$info = [
	"弱った肝臓を修復！お酒好きのおたすけ食材しじみ！",
	"これがしじみ？島根のしじみは泥臭くもなくアサリみたい！",
	"うまみ抜群！ほめるしかないこのおいしさは知る人ぞ知るしじみ汁！",
	"高血圧や低血圧にも効果あり！お菓子を食べない祖父母のプレゼントにもぴったり！",
	"女性にもおススメ！ミネラルが豊富で肌荒れやシミを防ぐよ！",
	"宍道湖のしじみは驚くほど大粒でまさに黒いダイヤモンド！",
	"マしじみ、ヤマトしじみ、セタしじみは三大しじみ！宍道湖のしじみはヤマトしじみ!",
	"カレー、ラーメン、グラタン、パエリア何に入れてもおいしいしじみ！",
	"冷凍すればオルニチンというダイエット成分が4倍！痩せたいあなたは迷わずしじみ！",
	"糖尿病、体力の衰え、寝汗、抜け毛、白髪の予防、下肢の痺れの改善にも有効だよ！",
	"対戦ユーザーの接続待ち"
]

# キャラクタ関係
# player1 の初期設定
$PLY1 = {}
$PLY1["x"] = 40
$PLY1["y"] = 40
$PLY1["size"] = 30
$PLY1["img"] = IMG_PLY1
$PLY1["speed"] = 3

# player2 の初期設定
$PLY2 = {}
$PLY2["x"] = 640
$PLY2["y"] = 480
$PLY2["size"] = 30
$PLY2["img"] = IMG_PLY2
$PLY2["speed"] = 3

# ネットワーク関係
URI = 'druby://127.0.0.1:3000'
ERROR_MAX = "最大接続数に達しました"

# 方向
UP = 0
LEFT = 1
DOWN = 2
RIGHT = 3

