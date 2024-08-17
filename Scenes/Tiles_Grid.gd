extends Node


var level = null

# `init_grid` sera propre a chaque niveau
var init_grid = []
"""
Exemple (N = 4 columns, M = 3 rows) :
[
	[ "blue",   null,   null, "blue" ],
	[ "blue", "blue", "blue", "blue" ],
	[ "blue", "blue", "blue", "blue" ]
]
"""

var tiles_grid = []
# After tiles loading :
# tiles = [ [ tile_1_1, ..., tile_1_N ],
#           [ tile_2_1, ..., tile_1_N ],
#           ...
#           [ tile_M_1, ..., tile_M_N ] ]


# the grid is placed in order to occupy all the window's height
var y_margin = 100
var colors = ["red", "blue"]

# the same textures will be preloaded for all the tiles
var tiles_textures = {}  # { "red": red_texture, ... }


func _ready():
	#var script = preload("res://Scenes/Script.gd")
	#script.new()
	pass

func _process(delta):
	pass


func init(_level, _init_grid, _window_width, _window_height):
	level = _level
	init_grid = _init_grid
	load_textures()
	init_tiles(_window_width, _window_height)


func init_tiles(_window_width, _window_height):
	var nb_rows = len(init_grid)
	var nb_columns = len(init_grid[0])
	# total grid length
	var grid_height = _window_height - 2 * y_margin
	# we deduce the dimensions of 1 tile
	var tile_size = grid_height / nb_rows
	var tile_width = tile_size
	var tile_height = tile_size
	# first tile position: bottom left
	var x_0 = (_window_width - nb_columns * tile_width) / 2
	var y_0 = _window_height - y_margin  # warning: y-axis is upside-down
	# init the tiles grid
	tiles_grid = []
	for i_y in range(nb_rows): 
		tiles_grid.append([])
		for i_x in range(nb_columns):
			tiles_grid[i_y].append(null)
	# instantiate the tiles
	var tile_scene = load("res://Scenes/Tile.tscn")
	for i_y in range(nb_rows):
		for i_x in range(nb_columns):
			if init_grid[-1-i_y][i_x] != null:
				var x = x_0 + i_x * tile_width
				var y = y_0 - (i_y+1) * tile_height
				create_tile(x, y, tile_width, tile_height, i_x, i_y, tile_scene)


func create_tile(x, y, tile_width, tile_height, i_x, i_y, tile_scene):
	var tile = tile_scene.instantiate()
	var color = init_grid[-1-i_y][i_x]
	tile.init(self, x, y, tile_height, tile_width, i_x, i_y, color, tiles_textures)
	self.add_child(tile)
	var a = [tile]
	tiles_grid[i_y][i_x] = null


func load_textures():
	for color in colors:
		var texture = load("res://Images/Tile_"+color+".png") 
		tiles_textures[color] = texture


# Single color change

var is_propagating = false

func user_clicked_on_tile(i_x, i_y):
	print(i_x)
	print(i_y)
	"""
	var selected_color = level.get_selected_color()
	if is_propagating:
		return
	var has_changed = false
	if has_changed:
		is_propagating = true
		$Propagation_Timer.start()
	"""

# Propagation of color changes

func get_new_grid(old_grid):
	var nb_rows = len(init_grid)
	var nb_columns = len(init_grid[0])
	# init the tiles grid
	var new_grid = []
	for i_y in range(nb_rows): 
		new_grid.append([])
		for i_x in range(nb_columns):
			new_grid[i_y].append(null)
	return new_grid

# we assume the dimensions are the same
func is_same_grid(grid_1, grid_2):
	var nb_rows = len(grid_1)
	var nb_columns = len(grid_1[0])
	for i_y in range(nb_rows): 
		for i_x in range(nb_columns):
			if grid_1[i_y][i_x] != grid_2[i_y][i_x]:
				return false
	return true

func propagate():
	"""
	var new_grid = get_new_grid(colors_grid)
	var has_changed = !is_same_grid(colors_grid, new_grid)
	if has_changed:
		# 1 s de delai entre chaque propagation
		$Propagation_Timer.start()
	else:
		is_propagating = false
		if level.validate_grid() == true:
			level.next_level()
	"""

func update_textures():
	pass

func _on_propagation_timer_timeout():
	propagate()




