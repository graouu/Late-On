@icon("res://Assets/Textures/Buttons_Proto/Shop_Grimoire1.png")

class_name Interactable extends TextureButton

signal open_dialogue(dialogue_ar : Array[DialogueLine])
enum Type {DIALOGUE, PUZZLE}

@export var interaction_type : Type = 0

#La ligne de dialogue de l'interactable
@export var dialogue_array : Array[DialogueLine]
@export var puzzle : PackedScene

func _on_pressed() -> void:
	#Quand l'interactable est pressé, on envoie un signal pour jouer ce dialogue
	if interaction_type == Type.DIALOGUE:
		open_dialogue.emit(dialogue_array)
	else:
		get_tree().change_scene_to_packed(puzzle)
