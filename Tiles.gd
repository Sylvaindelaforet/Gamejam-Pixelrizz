extends Node

# 10 columns
# 6 rows
var config = [
	[0, 0, 0, 0, 1, 1, 0, 0, 0, 0 ],
	[0, 0, 0, 0, 1, 1, 0, 0, 0, 0 ],
	[0, 0, 0, 0, 1, 1, 0, 0, 0, 0 ],
	[0, 0, 0, 1, 1, 1, 1, 0, 0, 0 ],
	[0, 0, 0, 1, 1, 1, 1, 0, 0, 0 ],
	[0, 0, 0, 1, 1, 1, 1, 0, 0, 0 ]
]

# the grid is placed in order to occupy all the windows' height
var y_margin = 100


func _ready():
	var nb_rows = len(config)
	var nb_columns = len(config[0])
	# total grid length
	var y_length = get_viewport().size.y - 2 * y_margin
	# we deduce the dimensions of 1 tile
	var tile_size = y_length / nb_rows
	var x_length = tile_size
	var y_length = tile_size
	# first tile position
	var x_0 = (get_viewport().size.y - nb_columns * x_length) / 2
	var y_0 = y_margin
	var mob = Dog.instance()
	get_tree().get_root().get_node("Main/Mobs").add_child(mob)


func _process(delta):
	pass


