extends Sprite2D


func _process(delta):
	self.position.x = -1
	self.position.y = -1
	self.scale.x = 1.1 * get_viewport().size.x / 100
	self.scale.y = 1.1 * get_viewport().size.y / 100

