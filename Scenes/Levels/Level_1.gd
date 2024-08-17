extends Node2D


var selected_color = "blue"
var tiles_grid = null


# Initial state of the grid
var init_grid = [
	[  null,   null,   null,   null,   null,   null,   null,   null ],
	[  null,   null,   null, "blue", "blue",   null,   null,   null ],
	[  null,   null, "blue", "blue", "blue",   null,   null,   null ],
	[  null, "blue", "blue", "blue", "blue", "blue",   null,   null ],
	[  null, "blue", "blue", "blue", "blue", "blue",   "blue",   null ],
	["blue", "blue", "blue", "blue", "blue", "blue",   "blue",   null ],
	["blue", "blue", "blue", "blue", "blue", "blue",   "blue",   null ]
]


func _ready():
	var tiles_grid_scene = load("res://Scenes/Tiles_Grid.tscn")
	tiles_grid = tiles_grid_scene.instantiate()
	var window_width = get_viewport().size.x
	var window_height = get_viewport().size.y
	tiles_grid.init(self, init_grid, 1200, 720)
	$Centered_View/Position_For_Tiles_Grid.add_child(tiles_grid)

func scale_black():
	$Black.position.x = -1
	$Black.position.y = -1
	$Black.scale.x = 1.1 * get_viewport().size.x / 100
	$Black.scale.y = 1.1 * get_viewport().size.y / 100

func _process(delta):
	# black background
	scale_black()
	# Centered_View scale
	var background_width = 1200
	var background_height = 720
	var scale = 1.0 * get_viewport().size.y / background_height
	if scale * background_width > get_viewport().size.x:
		scale = 1.0 * get_viewport().size.x / background_width
	$Centered_View.scale.x = scale
	$Centered_View.scale.y = scale
	# Centered_View position
	$Centered_View.position.x = (get_viewport().size.x - scale * background_width) / 2
	$Centered_View.position.y = (get_viewport().size.y - scale * background_height) / 2


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

func _on_pot_couleur_choisie(pot_color):
	selected_color = pot_color
	match pot_color:
		"red":
			Input.set_custom_mouse_cursor(load("res://Images/Pinceaux/pinceau_rouge.png"))
		"blue":
			Input.set_custom_mouse_cursor(load("res://Images/Pinceaux/pinceau_bleu.png"))
		"yellow":
			Input.set_custom_mouse_cursor(load("res://Images/Pinceaux/pinceau_jaune.png"))


