extends Node2D

enum COLORS {BLUE, RED, YELLOW}

var color_to_int = {
	COLORS.BLUE : "blue",
	COLORS.RED : "red",
	COLORS.YELLOW : "yellow",
}

signal couleur_choisie(pot_color)

@export var pot_color : COLORS

func _ready():
	_choose_sprite()


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


