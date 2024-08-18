extends Node2D


var next_level = "Level_6"
var selected_color = "blue"
var tiles_grid = null
var grid_x = 36


# Initial state of the grid
var init_grid = [
	[  null,   "blue", "green", "green", "green",   "blue",   null ],
	[  "blue", "blue", "blue", "blue", "blue", "blue",   "blue" ],
	[  "blue", "blue", "green", "green", "green", "blue",   "blue" ],
	["blue", "blue", "blue", "blue", "blue", "blue", "blue" ],
	["blue", "blue", "blue", "blue", "blue", "blue", "blue" ]
]


func _ready():
	update_pinceau(selected_color)

func validate_grid():
	var tiles_grid = $Level.get_tiles_grid()
	var colors_grid = tiles_grid.get_colors_grid()
	return colors_grid[0][3] != "blue" and colors_grid[1][3] != "blue" and colors_grid[2][3] != "blue" and colors_grid[3][3] != "blue" and colors_grid[4][3] != "blue"

func get_init_grid():
	return init_grid

func get_grid_x():
	return grid_x

func get_selected_color():
	return selected_color

func load_next_level():
	get_tree().change_scene_to_file("res://Scenes/Levels/"+next_level+".tscn")

func _on_pot_couleur_choisie(pot_color):
	selected_color = pot_color
	update_pinceau(pot_color)

func update_pinceau(color):
	match color:
		"red":
			Input.set_custom_mouse_cursor(load("res://Images/Pinceaux/pinceau_rouge.png"))
		"blue":
			Input.set_custom_mouse_cursor(load("res://Images/Pinceaux/pinceau_bleu.png"))
		"yellow":
			Input.set_custom_mouse_cursor(load("res://Images/Pinceaux/pinceau_jaune.png"))

