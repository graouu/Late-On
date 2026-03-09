class_name Interactable extends TextureButton

signal open_dialogue

@export var dialogue_text : String
@export var dialogue_name : String
@export var dialogue_texture : Texture2D

func _on_pressed() -> void:
	print("hello")
	open_dialogue.emit(dialogue_text, dialogue_name, dialogue_texture)
