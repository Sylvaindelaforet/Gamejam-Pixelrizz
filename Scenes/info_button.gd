extends Node2D

signal change_level()

@export_multiline var text_to_display : String

enum STATE {INFO, FAILURE, SUCCESS, END_GAME}

var current_state : STATE

func _ready():
	current_state = STATE.INFO
	$Popup/Label.text = text_to_display
	display()

func display():
	$ManuscriptSound.play()
	$Popup.show()

func show_success():
	$Popup/Label.text = "Vous avez gagné !\n\nCliquez sur le parchemin pour passer au niveau suivant"
	current_state = STATE.SUCCESS
	display()

func show_end_game():
	$Popup/Label.text = "Félicitations !!\n\nVous avez terminé le jeu.\n\nVous êtes désormais certain de pouvoir utiliser le pouvoir\ndes couleurs afin d'atteindre vos objectifs de vie.\n(et vous savez également que vous n'êtes pas daltonien !)"
	current_state = STATE.END_GAME
	display()

func show_failure():
	$Popup/Label.text = "Vous avez perdu.\n\nCliquez sur le parchemin pour réessayer."
	current_state = STATE.FAILURE
	display()

func end_display():
	match current_state:
		STATE.FAILURE:
			get_parent().restart_level()
		STATE.SUCCESS:
			get_parent().get_parent().load_next_level()
		STATE.INFO:
			$Popup.hide()
		STATE.END_GAME:
			pass

