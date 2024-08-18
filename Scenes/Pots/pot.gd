extends Node2D

enum COLORS {BLUE, RED, YELLOW}

var color_to_int = {
	COLORS.BLUE : "blue",
	COLORS.RED : "red",
	COLORS.YELLOW : "yellow",
}

signal couleur_choisie(pot_color)

@export var pot_color : COLORS
@export var content : int

func _ready():
	_choose_sprite()
	update_label()

# reduce by 1 the content of the pot
func remove_1():
	if content > 0:
		content -= 1
		update_label()

#reduce by 1 the content of the pot
func is_empty():
	return content == 0

func update_label():
	$Label.set_text(str(content))

func _choose_sprite():
	match pot_color:
		COLORS.BLUE:
			$PotSprite.texture = load('res://Images/potBleu.png')
		COLORS.RED:
			$PotSprite.texture = load('res://Images/potRouge.png')
		COLORS.YELLOW:
			$PotSprite.texture = load('res://Images/potJaune.png')

func set_color(_new_color:COLORS):
	pot_color = _new_color
	_choose_sprite()

func _pot_clicked():
	couleur_choisie.emit(color_to_int[pot_color])


