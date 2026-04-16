extends Place

@export var dialogue_character : Array[DialogueLine]
@export var dialogue_feuilles : Array[DialogueLine]

func _ready() -> void:
	if global.house_front_character_dialogue:
		interactable_list[0].dialogue_array = dialogue_character
		interactable_list[1].interaction_type = 1
	if global.enigme2_fini:
		$Buttons/Right.show()
		interactable_list[1].interaction_type = 0
		$Interactable2.hide()
		$TextureRect2.show()
	super()
	interactable_list[0].open_dialogue.connect(update_global)

func update_global(_sent_dialogue_array):
	interactable_list[0].dialogue_array = dialogue_character
	interactable_list[1].interaction_type = 1
	global.house_front_character_dialogue = true
