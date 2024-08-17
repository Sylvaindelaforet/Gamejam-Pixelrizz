extends Area2D

signal clicked()

func _input_event(_v, event, _int):
	if event.is_action_pressed("clic_gauche"):
		clicked.emit()

