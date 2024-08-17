extends Node2D

var tiles_grid = null
var tiles_textures = null

var i_x = -1
var i_y = -1
var color = null

func _ready():
	pass

func _process(delta):
	pass

func init(_tiles_grid, _x , _y, _width, _height, _i_x, _i_y, _color, _tiles_textures):
	tiles_grid = _tiles_grid
	self.position.x = _x
	self.position.y = _y
	set_dimensions(_width, _height)
	i_x = _i_x
	i_y = _i_y
	tiles_textures = _tiles_textures
	set_color(_color)
	$Sprite2D.init(self)

func clicked():
	tiles_grid.user_clicked_on_tile(i_x, i_y)

func set_dimensions(_width, _height):
	$Sprite2D.scale.x = 1.0 * _width  / $Sprite2D.texture.get_width() 
	$Sprite2D.scale.y = 1.0 * _height / $Sprite2D.texture.get_height()

# change the appearance
func set_color(_color):
	color = _color
	$Sprite2D.texture = tiles_textures[_color] 
