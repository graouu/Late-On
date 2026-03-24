extends Node2D

@onready var Space1 = $BlockInside1
@onready var Space2 = $BlockInside2
@onready var Space3 = $BlockInside3
@onready var Space4 = $BlockInside4
@onready var Space5 = $BlockInside5
@onready var ButtonValidate = $Button_Validate
@onready var ButtonReturn = $Button_Return
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/TextPopUp

func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#Si la partie menteur est complète, proposer de valider
	if Space1.name_inside != "empty" and Space2.name_inside != "empty" and Space3.name_inside != "empty" and Space4.name_inside != "empty" and Space5.name_inside != "empty":
		ButtonValidate.visible = true
	else:
		ButtonValidate.visible = false

func _on_button_validate_pressed() -> void:
	PopUp.visible = true
	if Space1.name_inside == "Beverage3" and Space2.name_inside == "Beverage5" and Space3.name_inside == "Beverage2" and Space4.name_inside == "Beverage1" and Space5.name_inside == "Beverage4":
		PopUp.visible = true
		PopUpText.text = "Bravo, tu es tellement intelligent! Tu as bien mérité ces 2000 points :D"
		global.enigme4_fini = true
	else:
		global.enigme4f_Nbtry = global.enigme4f_Nbtry +1
		if global.enigme4f_Nbtry == 1:
			PopUpText.text = "Ce n'est pas tout à fait ça. En relisant les consignes, je suis sûr que tu peux y arriver!"
		if global.enigme4f_Nbtry >= 2 and global.enigme2f_Nbtry <= 5:
			PopUpText.text = "Ce n'est pas ça. Tu as besoin d'un coup de pouce? Le fichier contenant les plans du manoirs est tout à droite :)"
		if global.enigme4f_Nbtry >= 5:
			PopUpText.text = "Ce n'est pas tout à fait ça, mais il est temps que tu passes à la prochaine étape. Voici la solution: 1) Textes // 2) Liste invités // 3) Portraits // 4) Politique // 5) Plans "

func _on_button_validate_mouse_entered() -> void:
	ButtonValidate.scale = Vector2(1.05,1.05)

func _on_button_validate_mouse_exited() -> void:
	ButtonValidate.scale = Vector2(1,1)

func _on_button_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Futur/Futur_Ordi.tscn")

func _on_button_return_mouse_entered() -> void:
	ButtonReturn.scale = Vector2(1.05,1.05)

func _on_button_return_mouse_exited() -> void:
	ButtonReturn.scale = Vector2(1,1)
