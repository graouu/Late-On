extends Node2D

@onready var SpaceTypeMap1 = $SpaceTypeMap1
@onready var SpaceTypeMap2 = $SpaceTypeMap2
@onready var SpaceTypeMap3 = $SpaceTypeMap3
@onready var SpaceTypeMap4 = $SpaceTypeMap4
@onready var ButtonValidate = $Button_Validate
@onready var ButtonReturn = $Button_Return
@onready var PopUpText = $PopUp/TextPopUp

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	#Si le joueur joue, la pop up disparait
	if global.is_dragging:
		PopUpText.text = "Je crois en toi! tu peux le faire! Pense à tous ces points que tu vas gagner!!!"
	
	#Si la partie menteur est complète, proposer de valider
	if SpaceTypeMap1.name_inside != "empty" and SpaceTypeMap2.name_inside != "empty" and SpaceTypeMap3.name_inside != "empty" and SpaceTypeMap4.name_inside != "empty":
		ButtonValidate.visible = true
	else:
		ButtonValidate.visible = false

func _on_button_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Futur_Ordi.tscn")

func _on_button_return_mouse_entered() -> void:
	ButtonReturn.scale = Vector2(1.05,1.05)

func _on_button_return_mouse_exited() -> void:
	ButtonReturn.scale = Vector2(1,1)

func _on_button_validate_pressed() -> void:
	if SpaceTypeMap1.name_inside == "TypeMap4" and SpaceTypeMap2.name_inside == "TypeMap3" and SpaceTypeMap3.name_inside == "TypeMap2" and SpaceTypeMap4.name_inside == "TypeMap1":
		PopUpText.text = "Bravo c'est la bonne solution! Tu es vraiment trop fort! Tu as bien mérité ces 500 points! Je suis heureux de t'avoir comme employé"
		global.enigme2f_fini = true
	else:
		global.enigme2f_Nbtry = global.enigme2f_Nbtry +1
		if global.enigme2f_Nbtry == 1:
			PopUpText.text = "Ce n'est pas tout à fait ça. En relisant les consignes, je suis sûr que tu peux y arriver!"
		if global.enigme2f_Nbtry >= 2 and global.enigme2f_Nbtry <= 5:
			PopUpText.text = "Ce n'est pas ça. Tu as besoin d'un coup de pouce? Le dossier des tenues est tout à gauche :)"
		if global.enigme2f_Nbtry >= 5:
			PopUpText.text = "Ce n'est pas tout à fait ça, mais il est temps que tu passes à la prochaine étape. Voici la solution: 1) Tenues // 2) Structures // 3) documents // 4) maps"

func _on_button_validate_mouse_entered() -> void:
	ButtonValidate.scale = Vector2(1.05,1.05)

func _on_button_validate_mouse_exited() -> void:
	ButtonValidate.scale = Vector2(1,1)
