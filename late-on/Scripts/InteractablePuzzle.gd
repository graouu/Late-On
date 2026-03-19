extends Interactable

@export var sentence_number : int

@onready var array_global = [global.Duo3_sentence1]

func _on_pressed() -> void:
	if sentence_number>6 or sentence_number<1:
		print("Error, sentence number in button too high or too low")
	else:
		if sentence_number == 1:
			global.Duo3_sentence1 = true
		elif sentence_number == 2:
			global.Duo3_sentence2 = true
		elif sentence_number == 3:
			global.Duo3_sentence3 = true
		elif sentence_number == 4:
			global.Duo3_sentence4 = true
		elif sentence_number == 5:
			global.Duo3_sentence5 = true
		elif sentence_number == 6:
			global.Duo3_sentence6 = true
	open_dialogue.emit(dialogue_array)
