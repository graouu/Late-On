@icon("res://Assets/Textures/Buttons_Proto/Shop_Grimoire1.png")

class_name Interactable extends TextureButton

signal open_dialogue(dialogue_ar : Array[DialogueLine])
signal open_puzzle(puzzle : String)
enum Type {DIALOGUE, PUZZLE}

var timer = 0

@export var interaction_type : Type = 0

#La ligne de dialogue de l'interactable
@export var dialogue_array : Array[DialogueLine]
@export var puzzle : String

func _ready() -> void:
	if !pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)
	pivot_offset_ratio = Vector2(0.5,0.5)

func _on_pressed() -> void:
	print(name, " has been pressed")
	#Quand l'interactable est pressé, on envoie un signal pour jouer ce dialogue
	if interaction_type == Type.DIALOGUE:
		open_dialogue.emit(dialogue_array)
	else:
		open_puzzle.emit(puzzle)

#func _process(delta: float) -> void:
	#timer += delta
	#if timer >= 0.7:
		#print("yes")
		#if rotation >= 0.05:
			#rotation = -0.05
		#else:
			#rotation =+ 0.05
		#timer = 0
	#
