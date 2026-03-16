@icon("res://Assets/Textures/Buttons_Proto/Shop_Grimoire1.png")

class_name Interactable extends TextureButton

signal open_dialogue(dialogue_ar : Array[DialogueLine])

#La ligne de dialogue de l'interactable
@export var dialogue_array : Array[DialogueLine]

func _on_pressed() -> void:
	#Quand l'interactable est pressé, on envoie un signal pour jouer ce dialogue
	open_dialogue.emit(dialogue_array)
