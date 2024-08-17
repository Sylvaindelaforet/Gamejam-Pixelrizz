extends Node2D



@export_multiline var text_to_display : String

func _ready():
	$Popup/Label.text = text_to_display


func display():
	$Popup.show()

