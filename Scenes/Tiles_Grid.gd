extends Node


var level = null

# `init_grid` sera propre a chaque niveau
var colors_grid = []
"""
Exemple (N = 4 columns, M = 3 rows) :
[
	[ "blue",   null,   null, "blue" ],
	[ "blue", "blue", "blue", "blue" ],
	[ "blue", "blue", "blue", "blue" ]
]
"""

var tiles_lists = []
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
	colors_grid =  create_grid_copy(_init_grid)
	load_textures()
	init_tiles(_window_width, _window_height)


func init_tiles(_window_width, _window_height):
	var nb_rows = len(colors_grid)
	var nb_columns = len(colors_grid[0])
	# total grid length
	var grid_height = _window_height - 2 * y_margin
	# we deduce the dimensions of 1 tile
	var tile_size = grid_height / nb_rows
	var tile_width = tile_size
	var tile_height = tile_size
	# first tile position: bottom left
	var x_0 = (_window_width - nb_columns * tile_width) / 2
	var y_0 = y_margin  # warning: y-axis is upside-down
	# init the tiles grid
	tiles_lists = []
	for i_y in range(nb_rows): 
		tiles_lists.append([])
		for i_x in range(nb_columns):
			tiles_lists[i_y].append(null)
	# instantiate the tiles
	var tile_scene = load("res://Scenes/Tile.tscn")
	for i_y in range(nb_rows):
		for i_x in range(nb_columns):
			if colors_grid[i_y][i_x] != null:
				var x = x_0 + i_x * tile_width
				var y = y_0 + i_y * tile_height
				create_tile(x, y, tile_width, tile_height, i_x, i_y, tile_scene)


func create_tile(x, y, tile_width, tile_height, i_x, i_y, tile_scene):
	var tile = tile_scene.instantiate()
	var color = colors_grid[i_y][i_x]
	tile.init(self, x, y, tile_height, tile_width, i_x, i_y, color, tiles_textures)
	self.add_child(tile)
	tiles_lists[i_y][i_x] = tile


func load_textures():
	for color in colors:
		var texture = load("res://Images/Tile_"+color+".png") 
		tiles_textures[color] = texture


# Single color change

var is_propagating = false

func user_clicked_on_tile(i_x, i_y):
	print(i_x)
	print(i_y)
	var selected_color = level.get_selected_color()
	var current_color = colors_grid[i_y][i_x]
	print(selected_color)
	print(current_color)
	print(tiles_lists[i_y][i_x])
	if !is_propagating and selected_color != current_color:
		colors_grid[i_y][i_x] = selected_color
		tiles_lists[i_y][i_x].set_color(selected_color)
		is_propagating = true
		$Propagation_Timer.start()
	else:
		return


# Propagation of color changes

func get_new_grid(old_grid):
	var nb_rows = len(old_grid)
	var nb_columns = len(old_grid[0])
	# init the new grid as empty
	var new_grid = []
	for i_y in range(nb_rows): 
		new_grid.append([])
		for i_x in range(nb_columns):
			new_grid[i_y].append(null)
	# fill the new grid
	for i_y in range(nb_rows):
		for i_x in range(nb_columns):
			var new_value = null
			if old_grid[i_y][i_x] != null:
				
				
				
				# CALCUL DES NOUVELLES COULEURS ICI
				
				# Par exemple, ci dessous on fait en sorte que toutes les cases en-dessous d'une case rouge deviennent rouges
				# (attention l'axe y est vers le haut dans le sens de y decroissant !)
					if i_y >= 1 and old_grid[i_y-1][i_x] != null and old_grid[i_y-1][i_x] == "red":
						new_value = "red"
					else:
						new_value = old_grid[i_y][i_x]
				
				
				
				
				
			new_grid[i_y][i_x] = new_value
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


func get_colors_grid():
	return create_grid_copy(colors_grid)


func create_grid_copy(grid):
	var nb_rows = len(grid)
	var nb_columns = len(grid[0])
	var copy = []
	for i_y in range(nb_rows): 
		copy.append([])
		for i_x in range(nb_columns):
			copy[i_y].append(grid[i_y][i_x])
	return copy

func update_textures():
	var nb_rows = len(colors_grid)
	var nb_columns = len(colors_grid[0])
	for i_y in range(nb_rows):
		for i_x in range(nb_columns):
			if colors_grid[i_y][i_x] != null:
				tiles_lists[i_y][i_x].set_color(colors_grid[i_y][i_x])


func propagate():
	var new_grid = get_new_grid(colors_grid)
	var has_changed = !is_same_grid(colors_grid, new_grid)
	if has_changed:
		# 1 s de delai entre chaque propagation
		colors_grid = new_grid
		update_textures()
		$Propagation_Timer.start()
	else:
		is_propagating = false
		if level.validate_grid() == true:
			level.next_level()

func _on_propagation_timer_timeout():
	propagate()


