extends Node2D

@onready var Sentence1 = $Sentence1
@onready var Sentence2 = $Sentence2
@onready var Sentence3 = $Sentence3
@onready var Sentence4 = $Sentence4
@onready var Space1 = $BlockInside1
@onready var Space2 = $BlockInside2
@onready var Space3 = $BlockInside3
@onready var Space4 = $BlockInside4
@onready var Space5 = $BlockInside5
@onready var ButtonValidate = $Button_Validate
@onready var ButtonReturn = $Button_Return
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/TextPopUp

# Rendre les phrases visibles une fois qu'on a parlé au perso.
func _ready() -> void:
	if global.enigme4_sentence1 :
		Sentence1.visible = true 
	else:
		Sentence1.visible = false

	if global.enigme4_sentence2 :
		Sentence2.visible = true 
	else:
		Sentence2.visible = false

	if global.enigme4_sentence3 :
		Sentence3.visible = true 
	else:
		Sentence3.visible = false

	if global.enigme4_sentence4 :
		Sentence4.visible = true 
	else:
		Sentence4.visible = false

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
		PopUpText.text = "J'ai trouvé :)"
		global.enigme4_fini = true
	else:
		PopUpText.text = "J'ai le sentiment que ce n'est pas la bonne combinaison"

func _on_button_validate_mouse_entered() -> void:
	ButtonValidate.scale = Vector2(1.05,1.05)

func _on_button_validate_mouse_exited() -> void:
	ButtonValidate.scale = Vector2(1,1)

func _on_button_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Passé/Passé_Manor.tscn")

func _on_button_return_mouse_entered() -> void:
	ButtonReturn.scale = Vector2(1.05,1.05)

func _on_button_return_mouse_exited() -> void:
	ButtonReturn.scale = Vector2(1,1)
