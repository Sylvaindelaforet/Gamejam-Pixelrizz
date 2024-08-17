extends Node2D


var selected_color = "red"
var tiles_grid = null


# Initial state of the grid
var init_grid = [
	[  null,   null,   null, "blue", "blue",   null,   null,   null ],
	[  null,   null,   null, "blue", "blue",   null,   null,   null ],
	[  null,   null,   null, "blue", "blue",   null,   null,   null ],
	[  null,   null, "blue", "blue", "blue", "blue",   null,   null ],
	[  null,   null, "blue", "blue", "blue", "blue",   null,   null ],
	["blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue" ],
	["blue", "blue", "blue", "blue", "blue", "blue", "blue", "blue" ]
]


func _ready():
	var tiles_grid_scene = load("res://Scenes/Tiles_Grid.tscn")
	tiles_grid = tiles_grid_scene.instantiate()
	var window_width = get_viewport().size.x
	var window_height = get_viewport().size.y
	tiles_grid.init(self, init_grid, window_width, window_height)
	$Position_For_Tiles_Grid.add_child(tiles_grid)


func _process(delta):
	pass

func validate_grid():
	var colors_grid = tiles_grid.get_colors_grid()
	var count_red = 0
	var nb_rows = len(colors_grid)
	var nb_columns = len(colors_grid[0])
	for i_y in range(nb_rows): 
		for i_x in range(nb_columns):
			if colors_grid[i_y][i_x] == "red":
				count_red += 1
	return count_red >= 5

func get_selected_color():
	return selected_color

func next_level():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_2.tscn")
