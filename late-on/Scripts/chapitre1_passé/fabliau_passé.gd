extends Node2D

@onready var Text2 = $Texte_Fabliau2
@onready var Text3 = $Texte_Fabliau3
@onready var Text4 = $Texte_Fabliau4
@onready var Text5 = $Texte_Fabliau5
@onready var Text6 = $Texte_Fabliau6

# Called when the node enters the scene tree for the first time.
func _on_visibility_changed() -> void:
	print("hello")
	if global.enigme1_Wall1 :
		print("1")
		Text2.visible = true
	if global.enigme1_Wall2 :
		print("2")
		Text3.visible = true
	if global.enigme1_Wall3 :
		print("3")
		Text4.visible = true
	if global.enigme1_Wall4 :
		Text5.visible = true
	if global.enigme1_Wall5 :
		Text6.visible = true
