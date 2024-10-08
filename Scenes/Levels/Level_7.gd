extends Node2D


var next_level = null
var selected_color = "blue"
var tiles_grid = null
var grid_x = 76


# Initial state of the grid
var init_grid = [
	[     null,     null,     null,     null,     null,     null,     null,     null],
	[   "blue", "blue", "yellow", "yellow", "yellow", "yellow", "yellow",   "blue" ],
	[     "blue", "blue",   "blue", "yellow",   "blue", "yellow",   "blue",   "blue" ],
	[     "blue",   "blue",   "blue",   "blue",   "blue",   "blue",   "blue",   "blue" ],
	[     "blue",   "blue",   "blue",   "blue",   "blue",   "blue",   "blue",   "blue" ],
	[     "blue",   "blue",  "green",  "green",   "green",   "green",  "blue",  "blue" ]
]


func _ready():
	$Level.set_is_last_level(true)
	update_pinceau(selected_color)

func validate_grid():
	var tiles_grid = $Level.get_tiles_grid()
	var colors_grid = tiles_grid.get_colors_grid()
	var count_green = 0
	var count_yellow = 0
	var nb_rows = len(colors_grid)
	var nb_columns = len(colors_grid[0])
	for i_y in range(nb_rows): 
		for i_x in range(nb_columns):
			if colors_grid[i_y][i_x] == "green":
				count_green += 1
			if colors_grid[i_y][i_x] == "yellow":
				count_yellow += 1
	return count_green == 0 and count_yellow == 0

func get_init_grid():
	return init_grid

func get_grid_x():
	return grid_x

func get_selected_color():
	return selected_color

func load_next_level():
	#var final_message_scene = load("res://Scenes/Levels/Final_Message.tscn")
	#var final_message = final_message_scene.instantiate()
	#$Level.add_child(final_message)
	pass
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

