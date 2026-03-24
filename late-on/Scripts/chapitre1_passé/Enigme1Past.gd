extends Node2D

@onready var ButtonReturn = $Button_Return
@onready var PopUp = $PopUp
@onready var PopUpText = $PopUp/TextPopUp
var Word1 = false
var Word2 = false
var Word3 = false
var Word4 = false
var Word5 = false
var Word6 = false

func _ready() -> void:
	PopUpText.text = "Cette boite s'ouvre en faisant en sorte que la bille du labyrinthe active les bons mots. En cas d'oubli, j'ai toujours le fabliaux me permettant de me souvenir des mots et de leur ordre."
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	pass

func _on_button_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Passé/Passé_Maison.tscn")

func _on_button_return_mouse_entered() -> void:
	ButtonReturn.scale = Vector2(1.05,1.05)

func _on_button_return_mouse_exited() -> void:
	ButtonReturn.scale = Vector2(1,1)
