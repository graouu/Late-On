extends Place

@export var next_dialogue : Array[DialogueLine]
@export var next_interactible_dialogue : Array[DialogueLine]

func _ready() -> void:
	if global.enigme2f_fini:
		$AnimationPlayer.stop()
		$Label.text = "Tâche 37\nGlobal ID : 45ds8d7df7\nCrédits : 10\n\nIntitulé : Organiser les dossiers en vue de la\nprocédure de transfert intertemporel."
		$Interactable2.hide()
		$Buttons.show()
		interactable_list[0].dialogue_array = next_interactible_dialogue
		dialogue_list = next_dialogue
	super()
