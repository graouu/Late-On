extends Node2D

@onready var SpaceTypeMap1 = $SpaceTypeMap1
@onready var SpaceTypeMap2 = $SpaceTypeMap2
@onready var SpaceTypeMap3 = $SpaceTypeMap3
@onready var SpaceTypeMap4 = $SpaceTypeMap4
@onready var ButtonValidate = $Button_Validate
@onready var ButtonReturn = $Button_Return
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/TextPopUp

signal end_puzzle(dialogue : String)
signal quit_puzzle

@export var dialogue_to_play : Array[DialogueLine]

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	#Si le joueur joue, la pop up disparait
	if global.is_dragging:
		PopUp.visible = false
	
	#Si la partie menteur est complète, proposer de valider
	if SpaceTypeMap1.name_inside != "empty" and SpaceTypeMap2.name_inside != "empty" and SpaceTypeMap3.name_inside != "empty" and SpaceTypeMap4.name_inside != "empty":
		ButtonValidate.visible = true
	else:
		ButtonValidate.visible = false

func _on_button_return_pressed() -> void:
	quit_puzzle.emit()

func _on_button_return_mouse_entered() -> void:
	ButtonReturn.scale = Vector2(1.05,1.05)

func _on_button_return_mouse_exited() -> void:
	ButtonReturn.scale = Vector2(1,1)

func _on_button_validate_pressed() -> void:
	PopUp.visible = true
	if SpaceTypeMap1.name_inside == "TypeMap4" and SpaceTypeMap2.name_inside == "TypeMap3" and SpaceTypeMap3.name_inside == "TypeMap2" and SpaceTypeMap4.name_inside == "TypeMap1":
		PopUp.visible = true
		PopUpText.text = "J'ai trouvé :)"
		global.enigme2_fini = true
		end_puzzle.emit(dialogue_to_play)
	else:
		PopUpText.text = "J'ai le sentiment que ce n'est pas la bonne combinaison"

func _on_button_validate_mouse_entered() -> void:
	ButtonValidate.scale = Vector2(1.05,1.05)

func _on_button_validate_mouse_exited() -> void:
	ButtonValidate.scale = Vector2(1,1)
