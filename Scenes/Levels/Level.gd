extends Node2D


var tiles_grid = null

func _ready():
	var init_grid = get_parent().get_init_grid()
	var tiles_grid_scene = load("res://Scenes/Tiles_Grid.tscn")
	tiles_grid = tiles_grid_scene.instantiate()
	tiles_grid.init(self, init_grid)
	$Position_For_Tiles_Grid.add_child(tiles_grid)

func _process(delta):
	# Centered_View scale
	var background_width = 1200
	var background_height = 720
	var scale = 1.0 * get_viewport().size.y / background_height
	if scale * background_width > get_viewport().size.x:
		scale = 1.0 * get_viewport().size.x / background_width
	self.scale.x = scale
	self.scale.y = scale
	# Centered_View position
	self.position.x = (get_viewport().size.x - scale * background_width) / 2
	self.position.y = (get_viewport().size.y - scale * background_height) / 2

func get_grid_x():
	return get_parent().grid_x

func get_tiles_grid():
	return tiles_grid

func get_pot_by_color(color):
	var pot_name_by_color = {
		"blue"  : "PotBleu",
		"yellow": "PotJaune",
		"red"   : "PotRouge"
	}
	var pot = $Pots.get_node(pot_name_by_color[color])
	return pot

func game_is_lost():
	var pots = $Pots.get_children()
	for pot in pots:
		if !pot.is_empty():
			return false
	return true

func game_over():
	$InfoButton.show_failure()

func game_success():
	$AnimSuccess.show()
	$InfoButton.show_success()

func get_selected_color():
	return get_parent().get_selected_color()

func restart_level():
	get_tree().reload_current_scene()

func validate_grid():
	return get_parent().validate_grid()
