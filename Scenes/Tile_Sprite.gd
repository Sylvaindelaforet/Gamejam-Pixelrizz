extends Sprite2D


var tile = null

func init(_tile):
	tile = _tile

func _input(event):
	if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			tile.clicked()
